import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnectionCheck;
  ConnectionCheckerImpl(this.internetConnectionCheck);

  @override
  Future<bool> get isConnected async =>
      await internetConnectionCheck.hasInternetAccess;
}
