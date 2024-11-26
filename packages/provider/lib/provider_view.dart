import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderView<P extends Provider> extends StatefulWidget {
  const ProviderView({
    super.key,
    required this.child,
    required this.initializeProvider,
    this.isAutoDispose = true,
    this.tag,
  });

  final Widget child;
  final bool isAutoDispose;
  final P Function() initializeProvider;
  final String? tag;

  @override
  State<ProviderView> createState() => _ProviderViewState<P>();
}

class _ProviderViewState<P extends Provider> extends State<ProviderView<P>> {
  @override
  void initState() {
    CustomProviderManager.checkAddProviderIfNotExist<P>(
      widget.initializeProvider,
      tag: widget.tag,
    );

    min(1, 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    Map map = {3: 'three', 1: 'one', 4: 'four', 5: 'five', 2: 'two'};

    var sortedByValueMap = Map.fromEntries(
        map.entries.toList()..sort((e1, e2) => e1.value.compareTo(e2.value)));

    print('Sort map:' + sortedByValueMap.toString());

    if (widget.isAutoDispose) {
      CustomProviderManager.removeProvider<P>(tag: widget.tag);
    }
    // Test
    super.dispose();
  }
}
