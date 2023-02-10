import 'package:device_info_plus/device_info_plus.dart';

class WindowsInfo {
  final DeviceInfoPlugin _plugin = DeviceInfoPlugin();
  String uuid;
  WindowsInfo({required this.uuid});
  Future<Map<String, String>> get info async {
    WindowsDeviceInfo windowsInfo = await _plugin.windowsInfo;
    return {
      'deviceName':
          '${windowsInfo.computerName} Cores:${windowsInfo.numberOfCores}; RAM : ${windowsInfo.systemMemoryInMegabytes}',
      'deviceUUID': uuid,
      'deviceType': 'WINDOWS'
    };
  }
}
