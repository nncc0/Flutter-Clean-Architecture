// 🌐 Network Information
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<ConnectivityResult> get connectivityStream;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  final Connectivity connectivity;
  
  NetworkInfoImpl(this.connectionChecker, this.connectivity);
  
  @override
  Future<bool> get isConnected async => connectionChecker.hasConnection;
  
  @override
  Stream<ConnectivityResult> get connectivityStream =>
      connectivity.onConnectivityChanged.expand((results) => results);
}
