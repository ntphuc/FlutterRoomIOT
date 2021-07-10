import 'package:demo_b/modules/base/baseModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  BaseView(
      {this.builder,
      this.model,
      this.child,
      this.onModelReady,
      this.onModelDestroy});

  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;
  final Function(T) onModelDestroy;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    if (widget.onModelReady != null) widget.onModelReady(model);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.onModelDestroy != null) widget.onModelDestroy(model);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => widget.model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
