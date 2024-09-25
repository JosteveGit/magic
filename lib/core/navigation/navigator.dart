import 'package:flutter/material.dart';

Future<T?> pushTo<T>(
  BuildContext context,
  Widget page, {
  RouteSettings? settings,
}) async {
  return await Navigator.push<T>(
    context,
    MaterialPageRoute(
      builder: (context) => page,
      settings: settings ?? RouteSettings(name: page.toString()),
    ),
  );
}

Future<T?> popPushTo<T>(
  BuildContext context,
  Widget page, {
  RouteSettings? settings,
}) async {
  pop(context);
  return await Navigator.push<T>(
    context,
    MaterialPageRoute(
      builder: (context) => page,
      settings: settings ?? RouteSettings(name: page.toString()),
    ),
  );
}

Future<T> pushReplacementTo<T>(
  BuildContext context,
  Widget page,
) async {
  return await Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => page,
      settings: RouteSettings(name: page.toString()),
    ),
  );
}

Future<void> pushToAndClearStack(BuildContext context, Widget page) {
  return Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => page,
      settings: RouteSettings(name: page.toString()),
    ),
    (route) => false,
  );
}

void pop<T>(BuildContext context, [T? value]) {
  return Navigator.pop<T>(context, value);
}

void popUntil(BuildContext context, Type page) {
  return Navigator.popUntil(context, ModalRoute.withName(page.toString()));
}
