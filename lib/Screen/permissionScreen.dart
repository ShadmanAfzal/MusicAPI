import 'package:appyhigh_assignment_flutter/Components/permissionTiles.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key key}) : super(key: key);

  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool fileSystem = false;
  bool camera = false;
  bool location = false;
  bool bluetooth = false;
  bool sms = false;
  bool voiceInput = false;
  bool notification = false;
  Map<Permission, PermissionStatus> statuses = {};

  @override
  void initState() {
    askedForPermission();
    super.initState();
  }

  askedForPermission() async {
    statuses = await [
      Permission.location,
      Permission.camera,
      Permission.sms,
      Permission.bluetooth,
      Permission.notification,
      Permission.storage,
      Permission.microphone
    ].request();

    fileSystem = statuses[Permission.storage]?.isGranted ?? false;
    camera = statuses[Permission.camera]?.isGranted ?? false;
    sms = statuses[Permission.sms]?.isGranted ?? false;
    bluetooth = statuses[Permission.bluetooth]?.isGranted ?? false;
    notification = statuses[Permission.notification]?.isGranted ?? false;
    voiceInput = statuses[Permission.microphone]?.isGranted ?? false;
    location = statuses[Permission.location]?.isGranted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Test App"),
      ),
      body: Column(
        children: [
          Text("Permission Allowed"),
          permissionTiles(fileSystem, "File System"),
          permissionTiles(camera, "Camera"),
          permissionTiles(location, "Location"),
          permissionTiles(bluetooth, "Bluetooth"),
          permissionTiles(sms, "SMS"),
          permissionTiles(voiceInput, "Voice Input"),
          permissionTiles(notification, "Notification"),
        ],
      ),
    );
  }
}
