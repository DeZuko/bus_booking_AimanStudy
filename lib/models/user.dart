import 'dart:convert';

class User {
  final int? id;
  final String fName;
  final String lName;
  final String username;
  final String password;
  final String mobileHp;
  User({
    this.id,
    this.fName = '',
    this.lName = '',
    this.username = '',
    this.password = '',
    this.mobileHp = '',
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? userName,
    String? password,
    String? phoneNum,
  }) {
    return User(
      id: id ?? this.id,
      fName: firstName ?? fName,
      lName: lastName ?? lName,
      username: userName ?? username,
      password: password ?? this.password,
      mobileHp: phoneNum ?? mobileHp,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'user_id': id});
    }
    result.addAll({'f_name': fName});
    result.addAll({'l_name': lName});
    result.addAll({'username': username});
    result.addAll({'password': password});
    result.addAll({'mobilehp': mobileHp});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user_id']?.toInt(),
      fName: map['f_name'] ?? '',
      lName: map['l_name'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      mobileHp: map['mobilehp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id,  firstName: $fName, lastName: $lName, userName: $username, password: $password, phoneNum: $mobileHp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.fName == fName &&
        other.lName == lName &&
        other.username == username &&
        other.password == password &&
        other.mobileHp == mobileHp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fName.hashCode ^
        lName.hashCode ^
        username.hashCode ^
        password.hashCode ^
        mobileHp.hashCode;
  }
}
