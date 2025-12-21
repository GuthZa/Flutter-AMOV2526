class InterestPoint {
  final int id;
  final String name;
  final String shortDescription;
  final String description;
  final String imageUrl;
  final String schedule;
  final String averagePrice;
  final String location;

  InterestPoint({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.imageUrl,
    required this.schedule,
    required this.averagePrice,
    required this.location,
  });

  factory InterestPoint.fromJson(Map<String, dynamic> json) {
    return InterestPoint(
      id: json['id'],
      name: json['name'],
      shortDescription: json['short_description'],
      description: json['description'],
      imageUrl: json['image'],
      schedule: json['schedule'],
      averagePrice: json['average_price'],
      location: json['location'],
    );
  }
}
