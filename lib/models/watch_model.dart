class WatchModel {
  final String id;
  final String brand;
  final String model;
  final int year;
  final String condition;
  final double price;
  final String description;
  final List<String> images;
  final String sellerId;
  final String sellerName;
  final String sellerImage;
  final bool isFavorite;
  final DateTime createdAt;

  WatchModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.condition,
    required this.price,
    required this.description,
    required this.images,
    required this.sellerId,
    required this.sellerName,
    required this.sellerImage,
    this.isFavorite = false,
    required this.createdAt,
  });

  WatchModel copyWith({
    String? id,
    String? brand,
    String? model,
    int? year,
    String? condition,
    double? price,
    String? description,
    List<String>? images,
    String? sellerId,
    String? sellerName,
    String? sellerImage,
    bool? isFavorite,
    DateTime? createdAt,
  }) {
    return WatchModel(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      condition: condition ?? this.condition,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerImage: sellerImage ?? this.sellerImage,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}