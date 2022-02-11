import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:movity/config/enums.dart';
import 'package:movity/src/data/model/moveis/movie_model.dart';
import 'package:movity/src/data/model/user_model.dart';
import 'package:movity/src/logic/preferences/movies/movies_preferences.dart';
import 'package:movity/src/logic/preferences/user/user_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitUser());

  final _firebaseInstance = FirebaseAuth.instance;

  static UserModel? userModel;

  UserModel _userModelFromFireBaseUser({
    required User? firebaseUser,
    String? firsName,
    String? lastName,
    bool? isNew,
  }) {
    return UserModel(
      uid: firebaseUser?.uid ?? '',
      isAnon: firebaseUser?.isAnonymous ?? false,
      isNew: isNew ?? false,
      email: firebaseUser?.email ?? '',
      profileImgUrl: firebaseUser?.photoURL ??
          'assets/images/user_info/profile_default.png',
      firstName: firebaseUser?.displayName?.split(' ').first ?? firsName ?? '',
      lastName: firebaseUser?.displayName?.split(' ').last ?? lastName ?? '',
      bestQuote: '',
      favoriteActors: [],
      favoriteMovies: [],
      toWatchMovies: [],
      watchedMovies: [],
    );
  }

  void editUser({
    String? email,
    String? firstName,
    String? lastName,
    String? bestMovie,
    String? bestQuote,
    File? headerFileImage,
    File? profileFileImage,
    Movie? addFavoriteMovie,
    ActorList? addFavoriteActor,
    Movie? toWatchMovie,
    Movie? watchedMovie,
    String? profileImageAsset,
  }) {
    userModel!.email = email ?? userModel!.email;
    userModel!.firstName = firstName ?? userModel!.firstName;
    userModel!.lastName = lastName ?? userModel!.lastName;
    userModel!.bestQuote = bestQuote ?? userModel!.bestQuote;
    userModel!.headerImageFile = headerFileImage ?? userModel!.headerImageFile;
    userModel!.profileImageFile =
        profileFileImage ?? userModel!.profileImageFile;
    addFavoriteMovie == null
        ? null
        : userModel!.favoriteMovies.add(addFavoriteMovie);

    addFavoriteActor == null
        ? null
        : userModel!.favoriteActors.add(addFavoriteActor);

    toWatchMovie == null ? null : userModel!.toWatchMovies.add(toWatchMovie);

    watchedMovie == null ? null : userModel!.watchedMovies.add(watchedMovie);
    userModel!.toWatch = userModel!.toWatchMovies.length;
    userModel!.watched = userModel!.watchedMovies.length;

    emit(UserEdited(user: userModel!));
  }

  void addToWatch(Movie toWatchMovie) {
    final listOfSimilarsToWatch = userModel!.toWatchMovies
        .where((element) => element.id == toWatchMovie.id)
        .toList();
    final listOfSimilarsWatched = userModel!.watchedMovies
        .where((element) => element.id == toWatchMovie.id)
        .toList();

    if (listOfSimilarsToWatch.isNotEmpty) {
      emit(AlreadyInTheToWatchList());
    } else if (listOfSimilarsWatched.isNotEmpty) {
      emit(AlreadyInTheWatchedList());
    } else {
      emit(ToWatchedAdded());
      editUser(toWatchMovie: toWatchMovie);
    }
  }

  void addToWatched(Movie watchedMovie) {
    userModel!.toWatchMovies.remove(watchedMovie);
    userModel!.watchedMovies.insert(0, watchedMovie);
    emit(Watched());
    emit(UserEdited(user: userModel!));
  }

  void unwatched(Movie unWatchedMovie, int index) {
    userModel!.watchedMovies.remove(unWatchedMovie);
    userModel!.toWatchMovies.insert(index, unWatchedMovie);

    emit(UnWatched());
    emit(UserEdited(user: userModel!));
  }

  bool checkWatched(Movie movie) {
    //  final listOfSimilarsToWatch = userModel!.toWatchMovies
    //     .where((element) => element.id == toWatchMovie.id)
    //     .toList();
    final listOfSimilarsWatched = userModel!.watchedMovies
        .where((element) => element.id == movie.id)
        .toList();

    if (listOfSimilarsWatched.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void removeToWatch(Movie toWatchMovie) {
    userModel!.toWatchMovies
        .removeWhere((element) => element.id == toWatchMovie.id);
    userModel!.toWatch = userModel!.toWatchMovies.length;

    emit(UserEdited(user: userModel!));
  }

  void emittingLocalUser() {
    userModel = UserPreferences.getLocalUserModel();
    userModel?.toWatch = userModel!.toWatchMovies.length;
    userModel?.watched = userModel!.watchedMovies.length;
    emit(LocalUser(userModel));
  }

  Future<BaseUser?> signInAnon() async {
    emit(Loading(true));
    try {
      UserCredential userCred = await _firebaseInstance.signInAnonymously();
      User? firebaseUser = userCred.user;

      userModel = _userModelFromFireBaseUser(firebaseUser: firebaseUser);
      editUser(
        email: '${userModel!.uid}@anon.com',
        firstName: 'Anon',
        lastName: 'Al Anon',
        profileImageAsset: 'assets/images/user_info/anon_profile.png',
      );

      emit(Logged(user: userModel!));

      return userModel;
    } on FirebaseAuthException catch (e) {
      emit(Loading(false));
      emit(AuthError(
          exception: PlatformException(code: e.code, message: e.message)));
    }
    return null;
  }

  Future<void> submitt({
    required FormType formType,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      emit(Loading(true));

      if (formType == FormType.signUp) {
        await createAccountWithEmailAndPassword(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
        );

        emit(Loading(false));
      } else {
        await signInWithEmailAndPassword(email: email, password: password);

        emit(Loading(false));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(
          exception: PlatformException(code: e.code, message: e.message)));

      emit(Loading(false));
    }
  }

  Future<BaseUser?> createAccountWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final firebaseUserCred = await _firebaseInstance
        .createUserWithEmailAndPassword(email: email, password: password);
    final firebaseUser = firebaseUserCred.user;

    userModel = _userModelFromFireBaseUser(
      firebaseUser: firebaseUser,
      isNew: firebaseUserCred.additionalUserInfo?.isNewUser,
      firsName: firstName,
      lastName: lastName,
    );

    emit(Logged(user: userModel!));
    return userModel;
  }

  Future<BaseUser?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final firebaseUserCred = await _firebaseInstance.signInWithEmailAndPassword(
        email: email, password: password);
    final firebaseUser = firebaseUserCred.user;

    userModel = _userModelFromFireBaseUser(
        firebaseUser: firebaseUser,
        isNew: firebaseUserCred.additionalUserInfo?.isNewUser);

    emit(Logged(user: userModel!));
    return userModel;
  }

  Future<BaseUser?> signInWithGoogle() async {
    emit(Loading(true));
    try {
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          final authResult = await _firebaseInstance.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );

          emit(Loading(false));

          userModel = _userModelFromFireBaseUser(
            firebaseUser: authResult.user,
            isNew: authResult.additionalUserInfo?.isNewUser,
          );

          emit(Logged(user: userModel!));
          return userModel;
        } else {
          emit(
            AuthError(
              exception: PlatformException(
                code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
                message: 'Missing Google Auth Token',
              ),
            ),
          );

          emit(Loading(false));
        }
      } else {
        emit(
          AuthError(
            exception: PlatformException(
              code: 'ERROR_ABORTED_BY_USERrrr',
              message: 'Sign in aborted by userrrr',
            ),
          ),
        );

        emit(Loading(false));
      }
    } on PlatformException catch (e) {
      emit(
        AuthError(
          exception: PlatformException(
            code: e.code,
            message: e.message,
          ),
        ),
      );
      emit(Loading(false));
    }
    return null;
  }

  void toggleFormType(FormType formType) {
    if (formType == FormType.signIn) {
      formType = FormType.signUp;
    } else {
      formType = FormType.signIn;
    }
    emit(FormToggled(formType: formType));
  }

  Future<void> signOut() async {
    try {
      emit(Loading(true));

      await GoogleSignIn().signOut();
      // await FacebookAuth.instance.logOut();
      await _firebaseInstance.signOut();
      await UserPreferences.removeLocalUserModel();
      await TopMoviesPreferences.removeMovies();
      emit(Loading(false));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(
          exception: PlatformException(code: e.code, message: e.message)));
      throw PlatformException(code: 'code', message: e.toString());
    }
  }

  void imageEdited(File? profileFile, File? headerFile) {
    print('imageEdited emitted');
    emit(ImageEdited(headerFile: headerFile, profileFile: profileFile));
  }
}
