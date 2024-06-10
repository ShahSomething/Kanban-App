abstract class INetworkInfo {
  /// This method tells whether the system is connected with the internet or not
  /// Output : returns the string as output
  Future<bool> get isConnected;
}
