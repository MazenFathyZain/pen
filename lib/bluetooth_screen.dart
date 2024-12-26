// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// class BluetoothScreen extends StatefulWidget {
//   const BluetoothScreen({super.key});
//   @override
//   // ignore: library_private_types_in_public_api
//   _BluetoothScreenState createState() => _BluetoothScreenState();
// }
// class _BluetoothScreenState extends State<BluetoothScreen> {
//   late StreamSubscription<List<ScanResult>> scanResultsSubscription;
//   BluetoothDevice? targetDevice;
//   String targetDeviceName = 'ESP32-C3';
//   String targetDeviceAddress = '64:E8:33:89:CB:F2';
//   bool isScanning = false;
//   bool isConnected = false;
//   // State variables for device data
//   String? bpm = "";
//   String? breathingRate = "";
//   String? pressure = "";
//   @override
//   void initState() {
//     super.initState();
//     initializeBluetooth();
//   }
//   @override
//   void dispose() {
//     scanResultsSubscription.cancel();
//     super.dispose();
//   }
//   void initializeBluetooth() async {
//     if (!await FlutterBluePlus.isSupported) {
//       _showError('Bluetooth is not supported on this device.');
//       return;
//     }
//     FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
//       if (state == BluetoothAdapterState.on) {
//         refreshScan();
//       } else {
//         _showError('Bluetooth is off. Please turn it on.');
//       }
//     });
//     if (Platform.isAndroid) {
//       await FlutterBluePlus.turnOn();
//     }
//   }
//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       backgroundColor: Colors.red,
//     ));
//   }
//   Future<void> refreshScan() async {
//     if (isConnected) {
//       await disconnectFromDevice();
//       return;
//     }
//     setState(() {
//       isScanning = true;
//       targetDevice = null;
//     });
//     try {
//       scanResultsSubscription = FlutterBluePlus.onScanResults.listen((results) {
//         for (var result in results) {
//           if (result.device.platformName == targetDeviceName &&
//               result.device.remoteId.toString() == targetDeviceAddress) {
//             log('Target device found: $targetDeviceName');
//             targetDevice = result.device;
//             connectToDevice(targetDevice!);
//             FlutterBluePlus.stopScan();
//             break;
//           }
//         }
//       });
//       await FlutterBluePlus.startScan(timeout: const Duration(seconds: 7));
//     } catch (e) {
//       _showError('Error during scanning: $e');
//     } finally {
//       setState(() {
//         isScanning = false;
//       });
//     }
//   }
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect();
//       log('Connected to ${device.remoteId} successfully');
//       isConnected = true;
//       List<BluetoothService> services = await device.discoverServices();
//       await _subscribeToCharacteristic(services, '00c8');
//     } catch (e) {
//       _showError('Error connecting to device: $e');
//     }
//   }
//   Future<void> _subscribeToCharacteristic(
//       List<BluetoothService> services, String characteristicUUID) async {
//     for (BluetoothService service in services) {
//       for (BluetoothCharacteristic characteristic in service.characteristics) {
//         if (characteristic.uuid.toString() == characteristicUUID) {
//           await characteristic.setNotifyValue(true);
//           log('Subscribed to notifications for characteristic: ${characteristic.uuid}');
//           characteristic.lastValueStream.listen((value) {
//             var readableValue = String.fromCharCodes(value);
//             log('Readable notification value: $readableValue');
//             var split = readableValue.split(' ');
//             setState(() {
//               bpm = split[1];
//               breathingRate = split[2];
//               pressure = split[3];
//             });
//           });
//           return;
//         }
//       }
//     }
//     log('Characteristic with UUID $characteristicUUID not found.');
//   }
//   Future<void> disconnectFromDevice() async {
//     if (targetDevice == null) return;
//     try {
//       await targetDevice!.disconnect();
//       log('Disconnected from ${targetDevice!.remoteId} successfully');
//       isConnected = false;
//       setState(() {
//         targetDevice = null;
//         bpm = "";
//         breathingRate = "";
//         pressure = "";
//       });
//     } catch (e) {
//       _showError('Error disconnecting from device: $e');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Smart Pen'),
//         actions: [
//           IconButton(
//             onPressed: refreshScan,
//             icon: Icon(isConnected ? Icons.link_off : Icons.refresh),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           if (isScanning) const Center(child: LinearProgressIndicator()),
//           Expanded(child: _dataDisplayCard()),
//         ],
//       ),
//     );
//   }
//   Widget _dataDisplayCard() {
//     return Card(
//       margin: const EdgeInsets.all(16.0),
//       color: Colors.grey[300],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Device Data',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             _dataRow('BPM', bpm ?? '--'),
//             _dataRow('Breathing Rate', breathingRate ?? '--'),
//             _dataRow('Pressure', pressure ?? '--'),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _dataRow(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label, style: const TextStyle(fontSize: 18)),
//         Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
//       ],
//     );
//   }
// }

// #######################################################################

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  late StreamSubscription<List<ScanResult>> scanResultsSubscription;
  BluetoothDevice? targetDevice;
  String targetDeviceName = 'ESP32-C3';
  String targetDeviceAddress = '64:E8:33:89:CB:F2';
  bool isScanning = false;
  bool isConnected = false;

  String? bpm = "";
  String? breathingRate = "";
  String? pressure = "";
  String? email = '';
  String? userName = '';
  String? image = '';

  @override
  void dispose() {
    scanResultsSubscription.cancel();
    super.dispose();
  }

  void initializeBluetooth() async {
    if (!await FlutterBluePlus.isSupported) {
      _showError('Bluetooth is not supported on this device.');
      return;
    }

    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        refreshScan();
      } else {
        _showError('Bluetooth is off. Please turn it on.');
      }
    });

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  Future<void> refreshScan() async {
    if (isConnected) {
      await disconnectFromDevice();
      return;
    }

    setState(() {
      isScanning = true;
      targetDevice = null;
    });

    try {
      scanResultsSubscription = FlutterBluePlus.onScanResults.listen((results) {
        for (var result in results) {
          if (result.device.platformName == targetDeviceName &&
              result.device.remoteId.toString() == targetDeviceAddress) {
            log('Target device found: $targetDeviceName');
            targetDevice = result.device;
            connectToDevice(targetDevice!);
            FlutterBluePlus.stopScan();
            break;
          }
        }
      });

      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 7));
    } catch (e) {
      _showError('Error during scanning: $e');
    } finally {
      setState(() {
        isScanning = false;
      });
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      log('Connected to ${device.remoteId} successfully');
      isConnected = true;

      List<BluetoothService> services = await device.discoverServices();
      await _subscribeToCharacteristic(services, '00c8');
    } catch (e) {
      _showError('Error connecting to device: $e');
    }
  }

  Future<void> _subscribeToCharacteristic(
      List<BluetoothService> services, String characteristicUUID) async {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == characteristicUUID) {
          await characteristic.setNotifyValue(true);
          log('Subscribed to notifications for characteristic: ${characteristic.uuid}');

          characteristic.lastValueStream.listen((value) {
            var readableValue = String.fromCharCodes(value);
            log('Readable notification value: $readableValue');
            var split = readableValue.split(' ');
            setState(() {
              bpm = split[1];
              breathingRate = split[2];
              pressure = split[3];
            });
          });
          return;
        }
      }
    }
    log('Characteristic with UUID $characteristicUUID not found.');
  }

  Future<void> disconnectFromDevice() async {
    if (targetDevice == null) return;

    try {
      await targetDevice!.disconnect();
      log('Disconnected from ${targetDevice!.remoteId} successfully');
      isConnected = false;
      setState(() {
        targetDevice = null;
        bpm = "";
        breathingRate = "";
        pressure = "";
      });
    } catch (e) {
      _showError('Error disconnecting from device: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        iconTheme: IconThemeData(color: Colors.blueGrey[800]),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'القلم الذكي',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800]),
        ),
        actions: [
          IconButton(
            onPressed: refreshScan,
            icon: Icon(
              isConnected ? Icons.link_off : Icons.refresh,
              color: const Color(0xFF37474F),
            ),
          ),
        ],
      ),
      body: isScanning
          ? const CircularProgressIndicator()
          : _dataDisplayCard(
              bpm!,
              breathingRate!,
              pressure!,
            ),
    );
  }

  Widget _dataDisplayCard(String bpm, String breathingRate, String pressure) {
    return Card(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'بيانات القلم',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 20),
            _dataRow('ضربات القلب', bpm),
            _dataRow('معدل التنفس', breathingRate),
            _dataRow('الضغط', pressure),
          ],
        ),
      ),
    );
  }

  Widget _dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}
