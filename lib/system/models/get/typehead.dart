class Typehead {
  final int sessionId;
  final String sessionNameAr;
  Typehead({required this.sessionId, required this.sessionNameAr});

  factory Typehead.fromJson(Map<String, dynamic> json) {
    return Typehead(
        sessionId: int.parse(json['id']), sessionNameAr: json['name']);
  }
}
