part of 'connectivity_cubit.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityState {
  final ConnectivityStatus status;

  const ConnectivityState({this.status = ConnectivityStatus.connected});

  ConnectivityState copyWith({ConnectivityStatus? status}) {
    return ConnectivityState(status: status ?? this.status);
  }
}

class DeviceConnectedState extends ConnectivityState {
  final bool isConnected;

  const DeviceConnectedState({
    super.status = ConnectivityStatus.connected,
    required this.isConnected,
  });
}
