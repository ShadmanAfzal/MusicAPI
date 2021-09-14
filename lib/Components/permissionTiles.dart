import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget permissionTiles(bool isEnabled, String permissionName) {
  return ListTile(
    leading: isEnabled
        ? Icon(
            Icons.done,
            color: Colors.green,
          )
        : Icon(
            Icons.close,
            color: Colors.red,
          ),
    title: Text(permissionName),
  );
}
