class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final String? initialPrice;
  final String? productPrice;
  final int? quantity;
  final String? unitTag;
  final String? image;

  Cart(
      {this.id,
      this.productId,
      this.productName,
      this.initialPrice,
      this.productPrice,
      this.quantity,
      this.unitTag,
      this.image});

  factory Cart.fromMap(Map<String, dynamic> fromMap) {
    return Cart(
      id: fromMap['id'],
      productId: fromMap['productId'],
      productName: fromMap['prodcutName'],
      initialPrice: fromMap['initialPrice'],
      productPrice: fromMap['productPrice'],
      quantity: fromMap['quantity'],
      unitTag: fromMap['unitTag'],
      image: fromMap['image'],
    );
  }

  //
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity,
      'unitTage': unitTag,
      'image': image,
    };
  }
}
