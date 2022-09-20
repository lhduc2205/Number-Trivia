import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(Connectivity connectivity) : _connectivity = connectivity;

  @override
  Future<bool> get isConnected async =>
      await (_connectivity.checkConnectivity()) != ConnectivityResult.none;
}
