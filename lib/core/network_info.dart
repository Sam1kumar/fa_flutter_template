import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:fa_flo/utils/device_utils.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl({required this.connectionChecker});

  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected =>
      connectionChecker.hasConnection;
}