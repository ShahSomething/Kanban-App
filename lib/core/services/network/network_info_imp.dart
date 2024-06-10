import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:kanban/core/services/network/network_info.dart';

class NetworkInfoImpl implements INetworkInfo {
  NetworkInfoImpl({
    required Connectivity connectivity,
  }) : _connectivity = connectivity;
  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
