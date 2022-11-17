class Cart {
  late final int? id;
  final String productId;
  final String productName;
  final int initialPrice;
  final int productPrice;
  final int quantity;
  final String unitTag;
  final String image;

  Cart(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.initialPrice,
      required this.productPrice,
      required this.quantity,
      required this.unitTag,
      required this.image});

  factory Cart.fromMap(Map<String, dynamic> cart) {
    return Cart(
        id: cart['id'],
        productId: cart['productId'],
        productName: cart['productName'],
        initialPrice: cart['initialPrice'],
        productPrice: cart['productPrice'],
        quantity: cart['quantity'],
        unitTag: cart['unitTag'],
        image: cart['image']);
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity,
      'unitTag': unitTag,
      'image': image,
    };
  }
}
