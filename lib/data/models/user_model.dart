import '../../domain/entities/user_entities.dart';

class UserModel extends UserEntities {
  const UserModel({
    required String id,
    required String email,
    required String name,
    String hobby = '',
    int balance = 0,
  }) : super(
          id: id,
          email: email,
          name: name,
          hobby: hobby,
          balance: balance,
        );

  @override
  List<Object?> get props => [id, email, name, hobby, balance];

  UserEntities toEntity() => UserEntities(
        id: id,
        email: email,
        name: name,
        hobby: hobby,
        balance: balance,
      );

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
}
