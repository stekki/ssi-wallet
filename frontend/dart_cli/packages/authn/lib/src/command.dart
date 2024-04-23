class Command {
  final String address;
  final int port;

  Command(this.address, this.port);

  factory Command.loadMap(Map<String, dynamic> m) =>
      Command(m['address'], m['port']);
}
