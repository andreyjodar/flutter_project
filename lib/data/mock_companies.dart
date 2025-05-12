List<Map<String, dynamic>> _fakeCompanies = [
  {
    'name': 'Ecoleafs',
    'email': 'carlos@email.com', 
    'cnpj': '12.345.678/0001-95',
    'address': 'Rua Vargas Costa, 300',
    'date': DateTime.now()
  },
  {
    'name': 'Greengrains',
    'email': 'alvaro@email.com',
    'cnpj': '47.974.114/0001-30',
    'address': 'Avenida Rui Barbosa, 218',
    'date': DateTime.now()
  }
];

Map<String, dynamic>? getCompanyByName(String name) {
  try {
    return _fakeCompanies.firstWhere((company) => company['name'] == name);
  } catch (e) {
    return null;
  }
}

Map<String, dynamic>? getCompanyByCnpj(String cnpj) {
  try {
    return _fakeCompanies.firstWhere((company) => company['cnpj'] == cnpj);
  } catch (e) {
    return null;
  }
}

void addCompany(String name, String email, String cnpj, String address) {
  _fakeCompanies.add({
    'name': name,
    'email': email,
    'cnpj': cnpj,
    'address': address,
    'date': DateTime.now()
  });
}

void removeCompany(String name) {
  _fakeCompanies.removeWhere((company) => company['name'] == name);
}
