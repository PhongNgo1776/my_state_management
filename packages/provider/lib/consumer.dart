import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Consumer<P extends Provider, T> extends StatefulWidget {
  const Consumer({
    super.key,
    required this.value,
    required this.builder,
    this.tag,
  });

  final String? tag;
  final T? Function(P) value;
  final Widget Function(BuildContext context, P provider) builder;

  @override
  State<Consumer<P, T>> createState() => _ConsumerState<P, T>();
}

class _ConsumerState<P extends Provider, T> extends State<Consumer<P, T>> {
  late final P provider;
  T? oldValue;

  @override
  void initState() {
    super.initState();
    provider = CustomProviderManager.getProvider<P>(tag: widget.tag);
    oldValue = widget.value(provider);
    provider.addListener(_valueChanged);
  }

  void _valueChanged() {
    final newValue = widget.value(provider);
    if (newValue != oldValue) {
      oldValue = widget.value(provider);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, provider);

  @override
  void dispose() {
    provider.removeListener(_valueChanged);
    super.dispose();
  }
}
