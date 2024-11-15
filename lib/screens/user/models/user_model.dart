import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final int age;
  final String address;

  const UserModel({
    required this.name,
    required this.age,
    required this.address,
  });

  @override
  List<Object?> get props => [name, age, address];

  @override
  String toString() => 'User(Name: $name, Age: $age, address: $address)';
}
