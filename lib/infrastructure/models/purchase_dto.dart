class PurchaseDto {
  String id;
  String cartId;
  String buyerId;
  String producerId;
  String status;
  String holderName;
  String cardNumber;
  String expirationDate;
  String securityCode;
  int installmentNumber;
  double price;
  DateTime purchaseDate;

  PurchaseDto({
    required this.id,
    required this.cartId,
    required this.buyerId,
    required this.producerId,
    required this.status,
    required this.holderName,
    required this.cardNumber,
    required this.expirationDate,
    required this.securityCode,
    required this.installmentNumber,
    required this.price,
    required this.purchaseDate,
  });

  factory PurchaseDto.fromMap(Map<String, dynamic> map) {
    return PurchaseDto(
      id: map['id'], 
      cartId: map['cartId'], 
      buyerId: map['buyerId'], 
      producerId: map['producerId'], 
      status: map['status'], 
      holderName: map['holderName'], 
      cardNumber: map['cardNumber'], 
      expirationDate: map['expirationDate'], 
      securityCode: map['security'], 
      installmentNumber: map['installmentNumber'], 
      price: map['price'], 
      purchaseDate: map['purchaseDate']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cartId': cartId,
      'buyerId': buyerId,
      'producerId': producerId,
      'status': status,
      'holderName': holderName,
      'cardNumber': cardNumber,
      'expirationDate': expirationDate,
      'securityCode': securityCode,
      'installmentNumber': installmentNumber,
      'price': price,
      'purchaseDate': purchaseDate,
    };
  }
}