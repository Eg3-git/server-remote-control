class Command {
  String title;
  Server server;

  Command(this.title, this.server);
}

class Server {
  String address;
  bool isOnline = true;

  Server(this.address);
}

