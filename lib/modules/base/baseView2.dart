import 'package:demo_b/modules/base/baseModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class BaseView2<T extends BaseModel, V extends BaseModel>
    extends StatefulWidget {
  BaseView2(
      {this.builder,
      this.model1,
      this.model2,
      this.child,
      this.onModelReady,
      this.onModelDestroy});

  final Widget Function(BuildContext context, T model1, V model2, Widget child)
      builder;
  final T model1;
  final V model2;
  final Widget child;
  final Function(T, V) onModelReady;
  final Function(T, V) onModelDestroy;

  @override
  _BaseView2State<T, V> createState() => _BaseView2State<T, V>();
}

class _BaseView2State<T extends BaseModel, V extends BaseModel>
    extends State<BaseView2<T, V>> {
  T model1;
  V model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    if (widget.onModelReady != null) widget.onModelReady(model1, model2);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.onModelDestroy != null) widget.onModelDestroy(model1, model2);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<T>(
          create: (_) => model1,
        ),
        ChangeNotifierProvider<V>(
          create: (_) => model2,
        )
      ],
      child: Consumer2<T, V>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
