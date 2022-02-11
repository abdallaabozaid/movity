part of 'auth_cubit.dart';

// import 'dart:convert';

@immutable
abstract class AuthState {}

class InitUser extends AuthState {}

class LocalUser extends AuthState {
  final UserModel? user;

  LocalUser(this.user);
}

class Loading extends AuthState {
  Loading(this.isLoading);

  final bool isLoading;
}

class DoneLoading extends AuthState {}

class Logged extends AuthState {
  Logged({required this.user}) {
    print('logged emitted');
    UserPreferences.saveLocalUserModel(user);
  }

  final UserModel user;
}

class UserEdited extends AuthState {
  UserEdited({required this.user}) {
    UserPreferences.saveLocalUserModel(user);
  }

  final UserModel user;
}

class AuthError extends AuthState {
  final PlatformException exception;

  AuthError({required this.exception});
}

class UnLogged extends AuthState {}

class FormToggled extends AuthState {
  FormToggled({required this.formType});
  final FormType formType;
}

class ImageEdited extends AuthState {
  ImageEdited({this.headerFile, this.profileFile});
  final File? profileFile;
  final File? headerFile;
}

class ToWatchedAdded extends AuthState {}

class Watched extends AuthState {}

class UnWatched extends AuthState {}

class AlreadyInTheToWatchList extends AuthState {}

class AlreadyInTheWatchedList extends AuthState {}

class ConfirmationBackground extends AuthState {
  ConfirmationBackground({required this.delete});

  final bool delete;
}
