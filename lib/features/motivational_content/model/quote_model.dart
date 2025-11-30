class Quote {
  final String id;
  final String name;
  final String quote;
  final String imageUrl;

  Quote({
    required this.id,
    required this.name,
    required this.quote,
    required this.imageUrl,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      name: json['name'],
      quote: json['quote'],
      imageUrl: json['imageUrl'],
    );
  }
}
