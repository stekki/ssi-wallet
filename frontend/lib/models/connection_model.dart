class Connection {
  final String id;
  final String ourDid;
  final String theirDid;
  final String theirEndpoint;
  final String theirLabel;
  final String createdMs;
  final String approvedMs;
  final bool invited;

  const Connection({
    required this.id,
    required this.ourDid,
    required this.theirDid,
    required this.theirEndpoint,
    required this.theirLabel,
    required this.createdMs,
    required this.approvedMs,
    required this.invited,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      id: json['id'],
      ourDid: json['ourDid'],
      theirDid: json['theirDid'],
      theirEndpoint: json['theirEndpoint'],
      theirLabel: json['theirLabel'],
      createdMs: json['createdMs'],
      approvedMs: json['approvedMs'],
      invited: json['invited'],
    );
  }
}
