class Country {
  final int id;
  final String name;
  final String? image;

  Country({required this.id, required this.name, this.image});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['country_key'],
      name: json['country_name'],
      image: json['country_logo'],
    );
  }
}
