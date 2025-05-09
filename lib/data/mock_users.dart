List<Map<String, dynamic>> _fakeUsers = [
  {
    'email': 'joao@email.com',
    'name': 'João',
    'password': '123456',
    'type': 'Comprador'
  },
  {
    'email': 'ana@email.com',
    'name': 'Ana',
    'password': 'senha123',
    'type': 'Vendedor'
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
    'type': type
  });
}

Map<String, dynamic>? getUserByEmail(String email) {
  try {
    return _fakeUsers.firstWhere((user) => user[email] == email);
  } catch (e) {
    return null;
  }
}

void removeUser(String email) {
  _fakeUsers.removeWhere((user) => user['email'] == email);
}