import 'dart:convert';

class Command {
  String title;
  Server server;

  Command(this.title, this.server);
}

class Server {
  String address;
  bool isOnline = false;
  String port;

  Server({required this.address, required this.port});

  factory Server.fromJson(Map<String, dynamic> jsonData) {
    return Server(address: jsonData['address'], port: jsonData['port']);
  }

  static Map<String, dynamic> toMap(Server server) => {'address': server.address, 'port': server.port};

  static String encode(List<Server> servers) => jsonEncode(servers.map<Map<String, dynamic>>((server) => Server.toMap(server)).toList());

  static List<Server> decode(String servers) => (jsonDecode(servers) as List<dynamic>).map<Server>((item) => Server.fromJson(item)).toList();
}

