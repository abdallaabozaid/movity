import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:movity/config/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit(this.connectivity) : super(InternetLoading()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) {
      print(connectivityResult);
      if (connectivityResult == ConnectivityResult.wifi) {
        emittingInternetConnected(ConnectionType.wifi);
        print('int cubit constructed');
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emittingInternetConnected(ConnectionType.mobile);
        print('int cubit constructedd');
      } else {
        emittingInternetDiscConnected();
        print('int cubit constructedddd');
      }
    });
  }
  final Connectivity connectivity;

  void emittingInternetConnected(ConnectionType connectionType) =>
      emit(Connected(connectionType: connectionType));

  void emittingInternetDiscConnected() => emit(InternetDisconnected());
}
