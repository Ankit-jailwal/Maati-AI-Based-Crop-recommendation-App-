class User{
  DateTime createdAt;
  String id;
  String username;
  String email;
  String password;
  int v;

  User(
    this.createdAt,
    this.id,
    this.username,
    this.email,
    this.password,
    this.v,
  );

  factory User.fromJson(dynamic json) {
    return new User(
        DateTime.parse(json["createdAt"]),
        json["_id"] as String,
        json["username"] as String,
        json["email"] as String,
        json["password"] as String,
        json["__v"] as int);
  }

  @override
  String toString() {
    return '{ ${this.createdAt}, ${this.id} , ${this.username} , ${this.email} , ${this.password} , ${this.v} }';
  }
}
