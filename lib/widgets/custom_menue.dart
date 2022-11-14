import 'package:flutter/material.dart';
class MyPopupMenueItem<T> extends PopupMenuItem<T> {
  //ctrl+o to override
  final Widget child;
  final Function onClick;

  const MyPopupMenueItem({required this.child, required this.onClick})
      : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenueItemState();
  }
}

class MyPopupMenueItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopupMenueItem<T>> {
  @override
  void handleTap() {
    widget.onClick();

  }
}