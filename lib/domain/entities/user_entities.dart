import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

class UserEntities extends Equatable {
  final String id;
  final String email;
  final String name;
  final String hobby;
  final int balance;

  const UserEntities({
    required this.id,
    required this.email,
    required this.name,
    this.hobby = '',
    this.balance = 0,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        hobby,
        balance,
      ];

  UserEntities copyWith({
    String? id,
    String? email,
    String? name,
    String? hobby,
    int? balance,
  }) {
    return UserEntities(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      hobby: hobby ?? this.hobby,
      balance: balance ?? this.balance,
    );
  }

  UserModel toModel() => UserModel(
        id: id,
        email: email,
        name: name,
        hobby: hobby,
        balance: balance,
      );
}
