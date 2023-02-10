import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_onboarding/constants/constants.dart';
import 'package:user_onboarding/models/common/deviceInfo/LinuxInfo.dart';
import 'package:user_onboarding/models/common/deviceInfo/windowsInfo.dart';
import 'package:uuid/uuid.dart';

import 'androidInfo.dart';
import 'webInfo.dart';
import 'iosInfo.dart';

class DeviceInfo {
  Future<String> generateUUID() async {
    String? deviceUUID;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    void updateWebUUID() {
      deviceUUID = const Uuid().v4();
      if (deviceUUID != null) prefs.setString('uuid', deviceUUID!);
    }

    if (prefs.containsKey('uuid')) {
      String temp = prefs.getString('uuid')!;
      if (temp.isEmpty) {
        updateWebUUID();
      } else {
        deviceUUID = temp;
      }
    } else {
      updateWebUUID();
    }
    return deviceUUID!;
  }

  Future<Map<String, String>> get info async {
    if (Constants.useMock) {
      return {
        'deviceName': 'MOCK_DEVICE',
        'deviceUUID': 'f15cdc5a-06ef-4c62-a5ff-bfc14cafcfc1',
        'deviceType': 'MOCK'
      };
    }
    String uuid = await generateUUID();
    if (kIsWeb) {
      return await WebInfo(uuid: uuid).info;
    } else if (Platform.isIOS) {
      return await IosInfo(uuid: uuid).info;
    } else if (Platform.isAndroid) {
      return await AndroidInfo(uuid: uuid).info;
    } else if (Platform.isWindows) {
      return await WindowsInfo(uuid: uuid).info;
    } else if (Platform.isLinux) {
      return await LinuxInfo(uuid: uuid).info;
    } else {
      return {};
    }
  }
}
