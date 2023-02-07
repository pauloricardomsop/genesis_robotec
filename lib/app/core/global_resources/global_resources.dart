import 'package:flutter/material.dart';

dynamic push(BuildContext context, Widget widget) async {
  var result = await Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  return result;
}