import 'package:flutter/material.dart';

class HeroPopupRoute<T> extends PageRoute<T> {
  final WidgetBuilder _builder;

  HeroPopupRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool fullscreenDialog = false,
  }): _builder = builder, super(settings: settings, fullscreenDialog: fullscreenDialog);

  @override
  // TODO: implement opaque
  bool get opaque => false;

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => true;

  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black54;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => "Popup route open";

  @override
  // TODO: implement maintainState
  bool get maintainState => true;

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}