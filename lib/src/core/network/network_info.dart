import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetwrokInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetwrokInfo {
  @override
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
