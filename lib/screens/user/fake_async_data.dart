import 'package:my_state_management/screens/user/models/order_model.dart';
import 'package:my_state_management/screens/user/models/user_model.dart';

class FakeAsyncData {
  static Future<List<OrderModel>> getFakeAsyncOrders() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      const OrderModel(name: 'Sticker', price: 1.5),
      const OrderModel(name: 'Picker', price: 2),
      const OrderModel(name: 'Ruler', price: 3),
      const OrderModel(name: 'Pen', price: 4)
    ];
  }

  static Future<UserModel> getBuyer() async {
    await Future.delayed(const Duration(seconds: 2));

    return const UserModel(name: 'Phong', age: 20, address: 'HCM');
  }

  static Future<UserModel> getSeller() async {
    await Future.delayed(const Duration(seconds: 2));

    return const UserModel(name: 'Jason', age: 30, address: 'HN');
  }
}
