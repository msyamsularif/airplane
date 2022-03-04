import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String hobby;
  final int balance;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.hobby = '',
    this.balance = 0,
  });

  @override
  List<Object?> get props => [id, email, name, hobby, balance];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'hobby': hobby,
      'balance': balance,
    };
  }

  factory UserModel.fromJson(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      hobby: map['hobby'] ?? '',
      balance: map['balance']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, hobby: $hobby, balance: $balance)';
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? hobby,
    int? balance,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      hobby: hobby ?? this.hobby,
      balance: balance ?? this.balance,
    );
  }
}
