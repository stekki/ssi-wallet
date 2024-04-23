class FidoCommand {
  final String url;
  String? aaguid;
  int? counter;
  String? jwt;
  String? origin;

  FidoCommand(
    this.url,
    this.aaguid, {
    this.counter = 0,
    this.jwt = '',
    this.origin = '',
  });

  factory FidoCommand.loadMap(Map<String, dynamic> m) =>
      FidoCommand(m['url'], m['aaguid']);
}
