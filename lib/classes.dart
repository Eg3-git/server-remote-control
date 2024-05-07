class Command {
  String title;
  Server server;

  Command(this.title, this.server);
}

class Server {
  String address;
  bool isOnline = true;
  String port;

  Server(this.address, this.port);
}

