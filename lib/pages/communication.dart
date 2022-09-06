import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Communicatin extends StatefulWidget {
  const Communicatin({Key? key}) : super(key: key);

  @override
  State<Communicatin> createState() => _CommunicatinState();
}

class _CommunicatinState extends State<Communicatin> {

  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: _getBatteryLevel, child: const Text('click me')),
          Text(_batteryLevel)
        ],
      ),
    );
  }
}
