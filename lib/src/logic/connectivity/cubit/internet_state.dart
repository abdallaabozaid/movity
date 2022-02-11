part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class Connected extends InternetState {
  final ConnectionType connectionType;

  Connected({required this.connectionType});
}

class InternetDisconnected extends InternetState {}
