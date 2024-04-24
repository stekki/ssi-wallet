class Credential {
  // final String credDefId;
  final String issuer;
  final String item; // target item
  final String date;
  final String holder; // holder's name
  final String status; // validity of the credential

  bool isExpanded = true;

  Credential({
    // required this.credDefId,
    required this.issuer,
    required this.item,
    required this.date,
    required this.holder,
    required this.status,
  });
  factory Credential.fromJson(Map<String, dynamic> json) {
    final issuer = json["attributes"].firstWhere((e) => e["name"] == "issuer")["value"];
    final item = json["attributes"].firstWhere((e) => e["name"] == "item")["value"];
    final date = json["attributes"].firstWhere((e) => e["name"] == "date")["value"];
    final holder = json["attributes"].firstWhere((e) => e["name"] == "holder")["value"];
    return Credential(
      // credDefId: json["credDefId"],
      issuer: issuer,
      item: item,
      date: date,
      holder: holder,
      status: "valid",
    );
  }
}
