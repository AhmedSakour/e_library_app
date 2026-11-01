class User {
  final int lid;
  final String username;
  final String fName;
  final String? lName;

  final bool isAdmin;

  User({
    required this.lid,
    required this.username,
    required this.fName,
    required this.lName,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      lid: json['lid'] as int,
      username: json['Username'] as String,
      fName: json['FName'] as String,
      lName: json['LName'] ?? '',
      isAdmin: json['isAdmin'] as bool,
    );
  }
}
