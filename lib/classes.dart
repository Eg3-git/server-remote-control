import 'dart:async';

import 'package:http/http.dart' as http;

class Command {
  String title;
  Server serverId;

  Command({required this.title, required this.serverId});

  Map<String, dynamic> toMap() {
    return {'title': title, 'serverId': serverId.toMap()};
  }

  factory Command.fromMap(Map<String, dynamic> map) {
    return Command(title: map['title'], serverId: map['serverId']);
  }
}

class Server {
  String address;
  bool isOnline = false;
  String port;

  Server({required this.address, required this.port});

  Future<bool> pingServer() async {
    try {
      final response = await http.get(Uri.parse(address));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      return false;
    }
  }

  static Future<void> pingAll(List<Server> servers) async {
    for (Server server in servers) {
      server.isOnline = await server.pingServer();
    }
  }

  Map<String, dynamic> toMap() => {'address': address, 'port': port};

  factory Server.fromMap(Map<String, dynamic> map) {
    return Server(address: map['address'], port: map['port']);
  }
}

abstract class StorageHelper {
  Future<void> insertServer(Server s);

  Future<void> insertCommand(Command c);

  Future<List<Server>> getServers();

  Future<List<Command>> getCommands();
}
