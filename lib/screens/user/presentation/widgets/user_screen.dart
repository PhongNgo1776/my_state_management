import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_state_management/constants.dart';
import 'package:my_state_management/screens/user/models/order_model.dart';
import 'package:my_state_management/screens/user/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  final bool isBuyer;
  final String userRole;
  const UserScreen({
    super.key,
    required this.isBuyer,
    required this.userRole,
  });

  String get tag => userRole;

  @override
  Widget build(BuildContext context) {
    debugPrint('-----REBUILD BuyerScreen');
    return ProviderView<UserProvider>(
      isAutoDispose: false,
      tag: tag,
      initializeProvider: () => UserProvider(isBuyer: isBuyer),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('User Role: $userRole'),
        ),
        body: Center(
          child: Consumer<UserProvider, bool>(
              tag: tag,
              value: (provider) => provider.isLoading,
              builder: (context, provider) {
                return provider.isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                        children: <Widget>[
                          const Column(
                            children: [
                              Text(
                                'Tap on buttons to change values on Texts.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Check log in Debug Console tab to see which widget is re-rendered after change value',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Single value:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Consumer<UserProvider, String>(
                                    tag: tag,
                                    value: (provider) => provider.name,
                                    builder: (context, provider) {
                                      debugPrint(
                                          '-----REBUILD BuyerScreen: Age Text');
                                      return Text(
                                        ' Name: ${provider.name ?? ''}',
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Multiple values:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Consumer<UserProvider, (String?, int?)>(
                                    tag: tag,
                                    value: (provider) =>
                                        (provider.address, provider.age),
                                    builder: (context, provider) {
                                      debugPrint(
                                          '-----REBUILD BuyerScreen: Address, Name Texts');
                                      return Text(
                                        ' Address: ${provider.address ?? ''}, Age: ${provider.age ?? ''}',
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Consumer<UserProvider, List<OrderModel>?>(
                                tag: tag,
                                value: (provider) => provider.orders,
                                builder: (context, provider) {
                                  debugPrint(
                                      '-----REBUILD SellerScreen: Orders Text');
                                  return provider.orders.isNotEmpty
                                      ? Column(
                                          children: [
                                            const Text(
                                              'Orders: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    provider.orders.length,
                                                itemBuilder: (context, i) =>
                                                    Text(
                                                      '${provider.orders[i]}',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ))
                                          ],
                                        )
                                      : const SizedBox();
                                },
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: _changeNameRandomly,
                                        child: const Text('Update name'),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        onPressed: _clearName,
                                        child: const Text('Clear name'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: _incrementAge,
                                        child: const Text('Increase age'),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        onPressed: _resetAge,
                                        child: const Text('Clear age'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: _updateAddress,
                                        child: const Text('Update address'),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        onPressed: _resetAddress,
                                        child: const Text('Clear address'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => _addOrders(
                                            Random().nextInt(10000).toString(),
                                            20.0),
                                        child: const Text('Add order'),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        onPressed: _clearFavorites,
                                        child: const Text('Clear orders'),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      );
              }),
        ),
        bottomNavigationBar: isBuyer
            ? SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserScreen(
                              userRole: 'Seller',
                              isBuyer: false,
                            ),
                          ),
                        );
                      },
                      child: const Text('Open Seller screen'),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  void _updateAddress() {
    CustomProviderManager.getProvider<UserProvider>(tag: tag)
        .setAddress('Ho Chi Minh');
  }

  void _resetAddress() {
    CustomProviderManager.getProvider<UserProvider>(tag: tag).setAddress(null);
  }

  void _incrementAge() {
    int currentAge =
        CustomProviderManager.getProvider<UserProvider>(tag: tag).age ?? 0;
    CustomProviderManager.getProvider<UserProvider>(tag: tag)
        .setAge(++currentAge);
  }

  void _resetAge() {
    CustomProviderManager.getProvider<UserProvider>(tag: tag).setAge(null);
  }

  void _changeNameRandomly() {
    CustomProviderManager.getProvider<UserProvider>(tag: tag)
        .setName(fakeUserNames[Random().nextInt(fakeUserNames.length)]);
  }

  void _clearName() {
    CustomProviderManager.getProvider<UserProvider>(tag: tag).setName(null);
  }

  void _addOrders(String name, double price) {
    final oldValue =
        CustomProviderManager.getProvider<UserProvider>(tag: tag).orders;
    final newOrders = [...oldValue];

    newOrders.add(OrderModel(name: name, price: price));
    CustomProviderManager.getProvider<UserProvider>(tag: tag)
        .setOrders(newOrders);
  }

  void _clearFavorites() {
    CustomProviderManager.getProvider<UserProvider>(tag: tag).setOrders([]);
  }
}
