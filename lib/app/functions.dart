import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

import '../domain/model/model.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;

      name = build.brand + " " + build.model;

      identifier = build.androidId;
      version = build.version.codename;
    }

    if (Platform.isIOS) {
      var build = await deviceInfoPlugin.iosInfo;

      name = "${build.name} ${build.model}";

      identifier = build.identifierForVendor;
      version = build.systemVersion;
    }

    return DeviceInfo(identifier: identifier, name: name, version: version);
  } on PlatformException {
    return DeviceInfo(identifier: identifier, name: name, version: version);
  }
}
