List<Map<String, dynamic>> _fakeProducts = [
  {
    'name': 'Alface',
    'type': 'Verduras',
    'price': 3.5,
    'un': 'Unidade',
    'company': 'Ecoleafs',
    'date': DateTime.now()
  }, 
  {
    'name': 'Morango',
    'type': 'Frutas',
    'price': 10.0,
    'un': 'Bandeja',
    'company': 'Ecoleafs',
    'date': DateTime.now()
  },
  {
    'name': 'Batata',
    'type': 'Tubérculos',
    'price': 6.0,
    'un': 'Quilograma',
    'company': 'Ecoleafs',
    'date': DateTime.now()
  }, 
  {
    'name': 'Salsa',
    'type': 'Hortaliças',
    'price': 3.0,
    'un': 'Maço',
    'company': 'Ecoleafs',
    'date': DateTime.now()
  },
  {
    'name': 'Feijão',
    'type': 'Grãos',
    'price': 5.0,
    'un': 'Quilograma',
    'company': 'Ecoleafs',
    'date': DateTime.now()
  }
];

void addProduct(String name, String type, double price, String un, String company) {
  _fakeProducts.add({
    'name': name,
    'type': type,
    'price': price,
    'un': un,
    'company': company,
    'date': DateTime.now()
  });
}

void removeProduct(String name, String company) {
  _fakeProducts.removeWhere((product) => product['name'] == name && product['company'] == company);
}

Map<String, dynamic>? getProductByNameAndCompany(String name, String company) {
  try {
    return _fakeProducts.firstWhere((product) => product['name'] == name && product['company'] == company);
  } catch (e) {
    return null;
  }
}