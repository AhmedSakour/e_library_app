class Author {
  final int? id;
  final String fname;
  final String lname;
  final String? country;
  final String? city;
  final String? address;

  Author({
    this.id,
    required this.fname,
    required this.lname,
    this.country,
    this.city,
    this.address,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['Id'] as int?,
      fname: json['Fname'] as String,
      lname: json['Lname'] as String,
      country: json['Country'] as String?,
      city: json['City'] as String?,
      address: json['Address'] as String?,
    );
  }
}
