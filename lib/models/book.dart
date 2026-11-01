class Book {
  final int id;
  final String title;
  final String? type;
  final String? price;
  final String? pubCity;
  final String? authCountry;
  final String? publisherName;
  final String? authorFirstName;
  final String? authorLastName;

  Book({
    required this.id,
    required this.title,
    this.type,
    this.pubCity,
    this.authCountry,
    this.price,
    this.publisherName,
    this.authorFirstName,
    this.authorLastName,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['Id'] as int,
      title: json['Title'] as String,
      type: json['Type'] as String?,
      authCountry: json['AuthCountry'],
      pubCity: json['PubCity'],
      price: json['Price'],
      publisherName: json['PName'] as String?,
      authorFirstName: json['Fname'] as String?,
      authorLastName: json['Lname'] as String?,
    );
  }
}
