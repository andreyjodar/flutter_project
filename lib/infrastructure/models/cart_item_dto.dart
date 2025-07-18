class CartItemDto {
  String id;
  String productId;
  int quantity;
  String lastUpdate;

  CartItemDto({
    required this.id, 
    required this.productId,
    required this.quantity,
    required this.lastUpdate
  });

  factory CartItemDto.fromMap(Map<String, dynamic> map) {
    return CartItemDto(
      id: map['id'], 
      productId: map['productId'], 
      quantity: map['quantity'], 
      lastUpdate: map['lastUpdate']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'lastUpdate': lastUpdate,
    };
  }
}