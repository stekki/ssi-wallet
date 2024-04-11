class Credential {
  final String issuer;
  final String item; // target item
  final String date;
  final String holder; // holder's name
  final String status; // validity of the credential

  bool isExpanded = true;

  Credential({
    required this.issuer,
    required this.item,
    required this.date,
    required this.holder,
    required this.status,
  });
}
