import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class AddCaseDetails extends StatefulWidget {
  const AddCaseDetails({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddCaseDetailsState createState() => _AddCaseDetailsState();
}

class _AddCaseDetailsState extends State<AddCaseDetails> {
  String deviceName = '';
  String deviceId = '';
  String imeiNumber = '';

  @override
  void initState() {
    super.initState();
    getDeviceInformation();
  }

  Future<void> getDeviceInformation() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName = androidInfo.model;
        deviceId = androidInfo.id;
        imeiNumber = androidInfo
            .serialNumber; // IMEI number is deprecated in recent Android versions
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName = iosInfo.name;
        deviceId = iosInfo.identifierForVendor!;
      }
      setState(() {});
    } catch (e) {
      print('Error getting device information: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Device Name: $deviceName'),
            Text('Device ID: $deviceId'),
            Text('IMEI Number: $imeiNumber'),
          ],
        ),
      ),
    );
  }
}
