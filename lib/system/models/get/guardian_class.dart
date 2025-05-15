class Guardian {
  final String id;
  final String lastName;
  final String firstName;
  final String dateOfBirth;
  final String relationship;
  final String phoneNumber;
  final String email;
  String? guardianAccount;
  List<String>? children;

  Guardian({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.dateOfBirth,
    required this.relationship,
    required this.phoneNumber,
    required this.email,
    this.guardianAccount,
    this.children,
  });

  factory Guardian.fromJson(Map<String, dynamic> map) {
    // Handle children: empty string → empty list or null
    List<String>? parsedChildren;
    final rawChildren = map['children'];
    if (rawChildren != null &&
        rawChildren is String &&
        rawChildren.trim().isNotEmpty) {
      parsedChildren = rawChildren.split(',').map((e) => e.trim()).toList();
    }

    return Guardian(
      id: map['guardian_id'].toString(),
      lastName: map['last_name'] ?? '',
      firstName: map['first_name'] ?? '',
      dateOfBirth: map['date_of_birth'] ?? '',
      relationship: map['relationship'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      email: map['email'] ?? '',
      guardianAccount: map['guardian_account'],
      children: parsedChildren,
    );
  }
}
