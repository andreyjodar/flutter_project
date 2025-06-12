import 'package:flutter_project/data/mock_product.dart';

List<Map<String, dynamic>> _fakePurchase = [
  {
    'product': 'Alface',
    'company': 'Ecoleafs',
    'email': 'joão@gmail.com', // email comprador
    'address': 'Rua Ribeiro Silva, 66',
    'quantity': 8,
    'total-price': 28.00,
    'date': DateTime.now()
  }
];

double _calculatePrice(String product, String company, int quantity) {
  var mockProduct = getProductByNameAndCompany(product, company);
  return mockProduct!['price'] * quantity;
}

void addPurchase(String product, String company, String email, int quantity,
    String address) {
  _fakePurchase.add({
    'product': product,
    'company': company,
    'email': email,
    'quantity': quantity,
    'address': address,
    'total-price': _calculatePrice(product, company, quantity),
    'date': DateTime.now()
  });
}
