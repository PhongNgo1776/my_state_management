library provider;

import 'package:flutter/material.dart';
export 'consumer.dart';
export 'provider_view.dart';
export 'provider.dart';

class Provider extends ChangeNotifier implements Listenable {}

class CustomProviderManager {
  static final Map<String, ProviderWrapper> providerWrapperMap = {};
  static P getProvider<P extends Provider>({String? tag}) {
    final providerWrapperKey = getProviderWrapperKey<P>(tag: tag);
    final key =
        providerWrapperMap.keys.firstWhere((e) => e == providerWrapperKey);

    return (providerWrapperMap[key]!.getInstance() as P);
  }

  static void checkAddProviderIfNotExist<P extends Provider>(
      P Function() initializeProvider,
      {String? tag}) {
    final providerWrapper = ProviderWrapper<P>();
    final providerWrapperKey = getProviderWrapperKey<P>(tag: tag);

    if (CustomProviderManager.providerWrapperMap[providerWrapperKey] == null) {
      providerWrapper.init(instance: initializeProvider());
      CustomProviderManager.providerWrapperMap[providerWrapperKey] =
          providerWrapper;
    }
  }

  static void removeProvider<P extends Provider>({String? tag}) {
    final providerWrapperKey = getProviderWrapperKey<P>(tag: tag);
    if (CustomProviderManager.providerWrapperMap[providerWrapperKey] != null) {
      CustomProviderManager.providerWrapperMap.remove(providerWrapperKey);
    }
  }

  static String getProviderWrapperKey<P extends Provider>({String? tag}) {
    final testProviderWrapper = ProviderWrapper<P>();
    return '${testProviderWrapper.runtimeType}${tag != null ? '_$tag' : ''}';
  }
}

class ProviderWrapper<P extends Provider> {
  P? _instance;
  P? get instance => _instance;
  ProviderWrapper();

  void init({required P instance}) {
    this._instance = instance;
  }

  P getInstance() => _instance!;
}
