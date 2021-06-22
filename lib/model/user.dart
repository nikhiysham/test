class User {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? token;
  final String? createdAt;

  const User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.token,
      this.createdAt});

  static User fromJson(Map<dynamic, dynamic> json) {
    return User(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        password: json["password"],
        token: json["token"] ?? "",
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).toIso8601String()
            : "");
  }

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "token": token,
      "createdAt": createdAt
    };
  }

  User copy(
      {int? id,
      String? name,
      String? email,
      String? password,
      String? token,
      String? createdAt}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        token: token ?? this.token,
        createdAt: createdAt ?? this.createdAt);
  }

  @override
  String toString() {
    return '{ Email: ${this.email} | Name: ${this.name} | Password: ${this.password} | Token: ${this.token}';
  }
}
