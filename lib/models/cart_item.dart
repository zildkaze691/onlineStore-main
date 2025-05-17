import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  final Map<String, String>? selectedVariants;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedVariants,
  });

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'selectedVariants': selectedVariants,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      selectedVariants: json['selectedVariants'] != null
          ? Map<String, String>.from(json['selectedVariants'])
          : null,
    );
  }
} 