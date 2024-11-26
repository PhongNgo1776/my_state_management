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

    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    if (widget.isAutoDispose) {
      CustomProviderManager.removeProvider<P>(tag: widget.tag);
    }

    print('12');
    super.dispose();
  }
}
