import 'dart:convert';

class Command {
  String title;
  int serverId;

  Command({required this.title, required this.serverId});

  factory Command.fromJson(Map<String, dynamic> jsonData, List<Server> servers) {
    return Command(title: jsonData['title'], serverId: int.parse(jsonData['serverId']));
  }

  static Map<String, dynamic> toMap(Command command) => {'title': command.title, 'serverId': command.serverId};

  static String encode(List<Command> commands) => jsonEncode(commands.map<Map<String, dynamic>>((command) => Command.toMap(command)).toList());

  static List<Command> decode(String commands, List<Server> servers) => (jsonDecode(commands) as List<dynamic>).map<Command>((item) => Command.fromJson(item, servers)).toList();
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

