import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/valueobjects/credit_card.dart';

enum PurchaseStatus { order, accept, canceled }

class Purchase {
  final String _id;
  final Cart _purchaseCart;
  PurchaseStatus _status;
  final CreditCard _creditCard;
  final int _installmentNumber;
  final DateTime _purchaseDate;

  Purchase({
    required String id,
    required Cart purchaseCart,
    PurchaseStatus status = PurchaseStatus.order,
    required CreditCard creditCard,
    required int installmentNumber,
    DateTime? purchaseDate
  }) : _id = id,
       _purchaseCart = purchaseCart,
       _status = status,
       _creditCard = creditCard,
       _installmentNumber = installmentNumber,
       _purchaseDate = purchaseDate ?? DateTime.now() {
        if(_installmentNumber < 1 || _installmentNumber > 12) throw Exception('Número de parcelas inválido (1 a 12)');
       }
  
  String get id => _id;
  Cart get purchaseCart => _purchaseCart;
  CreditCard get creditCard => _creditCard;
  DateTime get purchaseDate => _purchaseDate;
  bool isOrder() => _status == PurchaseStatus.order;
  bool isAccept() => _status == PurchaseStatus.accept;
  bool isCanceled() => _status == PurchaseStatus.canceled;

  void toggleToAccept() {
    _status = PurchaseStatus.accept;
  }

  void toggleToCanceled() {
    _status = PurchaseStatus.canceled;
  }
}