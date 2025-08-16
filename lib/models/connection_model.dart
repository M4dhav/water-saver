class ConnectionModel {
  final String? bssid;
  String? password;
  final String? name;

  ConnectionModel({
    required this.bssid,
    required this.name,
    this.password,
  });
}
