import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final Key;
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    required this.Key,
    required this.item,
    required this.child,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) => Dismissible(
        //key: UniqueKey(),
        key: Key,
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        child: child,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        child: Icon(Icons.check, size: 32),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.cancel_outlined, size: 32),
      );
}