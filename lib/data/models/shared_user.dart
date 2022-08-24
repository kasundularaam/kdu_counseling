import 'dart:convert';

class SharedUser {
  final int id;
  final String email;
  final String password;
  SharedUser({
    required this.id,
    required this.email,
    required this.password,
  });

  SharedUser copyWith({
    int? id,
    String? email,
    String? password,
  }) {
    return SharedUser(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
    };
  }

  factory SharedUser.fromMap(Map<String, dynamic> map) {
    return SharedUser(
      id: map['id'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SharedUser.fromJson(String source) =>
      SharedUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SharedUser(id: $id, email: $email, password: $password)';

  @override
  bool operator ==(covariant SharedUser other) {
    if (identical(this, other)) return true;

    return other.id == id && other.email == email && other.password == password;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ password.hashCode;
}
