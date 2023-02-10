import 'package:device_info_plus/device_info_plus.dart';

class LinuxInfo {
  final DeviceInfoPlugin _plugin = DeviceInfoPlugin();
  String uuid;
  LinuxInfo({required this.uuid});
  Future<Map<String, String>> get info async {
    LinuxDeviceInfo linuxInfo = await _plugin.linuxInfo;
    return {
      'deviceName':
          '${linuxInfo.name}:${linuxInfo.machineId} on ${linuxInfo.versionCodename}',
      'deviceUUID': uuid,
      'deviceType': 'LINUX'
    };
  }
}
