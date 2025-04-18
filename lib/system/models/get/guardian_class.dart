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
    return Guardian(
      id: map['guardian_id'],
      lastName: map['last_name'],
      firstName: map['first_name'],
      dateOfBirth: map['date_of_birth'],
      relationship: map['relationship'],
      phoneNumber: map['phone_number'],
      email: map['email'],
      guardianAccount: map['guardian_account'],
      children: map['children'] != null
          ? (map['children'] as String).split(',').map((e) => e.trim()).toList()
          : null,
    );
  }
//TODO setters for updates
}
