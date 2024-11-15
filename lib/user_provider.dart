import 'package:my_state_management/screens/user/fake_async_data.dart';
import 'package:my_state_management/screens/user/models/order_model.dart';
import 'package:provider/provider.dart';

class UserProvider extends Provider {
  final bool isBuyer;
  int? age;
  String? address;
  String? name;
  List<OrderModel> orders = [];
  bool isLoading = true;

  UserProvider({
    required this.isBuyer,
    this.age,
    this.name,
    this.address,
    this.orders = const [],
  }) {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    final user = isBuyer
        ? await FakeAsyncData.getBuyer()
        : await FakeAsyncData.getSeller();

    name = user.name;
    age = user.age;
    isLoading = false;
    notifyListeners();
  }

  void setAge(int? age) {
    this.age = age;
    notifyListeners();
  }

  void setAddress(String? address) {
    this.address = address;
    notifyListeners();
  }

  void setName(String? name) {
    this.name = name;
    notifyListeners();
  }

  void setOrders(List<OrderModel> orders) {
    this.orders = orders;
    notifyListeners();
  }
}
