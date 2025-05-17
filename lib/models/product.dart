class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int stockQuantity;
  final Map<String, List<String>>? variants; // For different sizes, colors, etc.
  final String period; // Historical period
  final String condition; // Condition of the vintage item

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.stockQuantity,
    this.variants,
    required this.period,
    required this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'rating': rating,
      'stockQuantity': stockQuantity,
      'variants': variants,
      'period': period,
      'condition': condition,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      rating: json['rating'].toDouble(),
      stockQuantity: json['stockQuantity'],
      variants: json['variants'] != null
          ? Map<String, List<String>>.from(json['variants'])
          : null,
      period: json['period'],
      condition: json['condition'],
    );
  }
} 