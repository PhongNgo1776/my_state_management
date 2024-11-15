import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String name;
  final double price;

  const OrderModel({
    required this.name,
    required this.price,
  });

  @override
  List<Object?> get props => [name, price];

  @override
  String toString() => 'Order(Name: $name, Price: $price)';
}
