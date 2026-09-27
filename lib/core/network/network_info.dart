import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

class ConnectivityNetworkInfo implements NetworkInfo {
  ConnectivityNetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    try {
      final states = await _connectivity.checkConnectivity();
      return !states.contains(ConnectivityResult.none);
    } catch (_) {
      return false;
    }
  }
}
