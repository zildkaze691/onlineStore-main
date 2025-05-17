import '../models/product.dart';

class MockData {
  static List<Product> products = [
    Product(
      id: '1',
      name: 'Victorian Pocket Watch',
      description:
          'Exquisite gold-plated pocket watch from the Victorian era, featuring intricate engravings and a pristine white enamel dial. Complete with original chain and fob.',
      price: 1299.99,
      imageUrl: 'assets/images/victorian_watch.jpg',
      category: 'Pocket Watches',
      rating: 4.8,
      stockQuantity: 1,
      period: 'Victorian (1837-1901)',
      condition: 'Excellent - Fully Working',
    ),
    Product(
      id: '2',
      name: 'Art Deco Mantel Clock',
      description:
          'Stunning 1920s marble mantel clock with geometric designs and chrome accents. Features an 8-day movement and original brass hands.',
      price: 2499.99,
      imageUrl: 'assets/images/art_deco_clock.jpg',
      category: 'Mantel Clocks',
      rating: 4.9,
      stockQuantity: 1,
      period: 'Art Deco (1920s-1930s)',
      condition: 'Very Good - Minor Wear',
    ),
    Product(
      id: '3',
      name: 'Swiss Chronograph 1960s',
      description:
          'Vintage Swiss-made chronograph wristwatch from the 1960s. Features a stainless steel case, original leather strap, and recently serviced movement.',
      price: 3999.99,
      imageUrl: 'assets/images/swiss_chronograph.jpg',
      category: 'Wristwatches',
      rating: 4.7,
      stockQuantity: 2,
      period: 'Mid-Century (1960s)',
      condition: 'Good - Serviced',
    ),
    // Add more products...
  ];

  static List<String> categories = [
    'Pocket Watches',
    'Wristwatches',
    'Mantel Clocks',
    'Wall Clocks',
    'Carriage Clocks',
    'Chronographs',
  ];

  static List<String> periods = [
    'Victorian (1837-1901)',
    'Edwardian (1901-1910)',
    'Art Deco (1920s-1930s)',
    'Mid-Century (1940s-1960s)',
    'Vintage (1970s-1980s)',
  ];
}
