class Publisher {
  final int? id;
  final String pname;
  final String? city;

  Publisher({
    this.id,
    required this.pname,
    this.city,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      id: json['Id'] as int?,
      pname: json['PName'] as String,
      city: json['City'] as String?,
    );
  }
}
