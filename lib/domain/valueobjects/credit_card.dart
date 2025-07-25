import 'package:flutter_project/domain/valueobjects/card_holder_name.dart';
import 'package:flutter_project/domain/valueobjects/card_number.dart';
import 'package:flutter_project/domain/valueobjects/security_code.dart';

class CreditCard {
  final CardHolderName _holderName;
  final CardNumber _cardNumber;
  final DateTime _expirationDate;
  final SecurityCode _securityCode;

  CreditCard({
    required CardHolderName holderName,
    required CardNumber cardNumber,
    required DateTime expirationDate,
    required SecurityCode securityCode
  }) : _holderName = holderName,
       _cardNumber = cardNumber,
       _expirationDate = expirationDate,
       _securityCode = securityCode;

  String get cardHolderName => _holderName.toString();
  String get creditCardNumber => _cardNumber.toString();
  DateTime get expirationDate => _expirationDate;
  String get securityCode => _securityCode.toString();
}