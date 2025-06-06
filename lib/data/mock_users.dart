List<Map<String, dynamic>> _fakeUsers = [
  {
    'email': 'joao@email.com',
    'name': 'João',
    'password': 'senha123',
    'type': 'Comprador',
    'date': DateTime.now()
  },
  {
    'email': 'ana@email.com',
    'name': 'Ana',
    'password': 'senha123',
    'type': 'Produtor',
    'date': DateTime.now()
  }
];

bool isValidUser(String email, String password) {
  final user = getUserByEmail(email);
  if (user == null) return false;
  return user['password'] == password;
}

void addUser(String email, String password, String name, String type) {
  _fakeUsers.add({
    'email': email,
    'name': name,
    'password': password,
    'type': type,
    'date': DateTime.now()
  });
}

Map<String, dynamic>? getUserByEmail(String email) {
  try {
    return _fakeUsers.firstWhere((user) => user['email'] == email);
  } catch (e) {
    return null;
  }
}

void removeUser(String email) {
  _fakeUsers.removeWhere((user) => user['email'] == email);
}
