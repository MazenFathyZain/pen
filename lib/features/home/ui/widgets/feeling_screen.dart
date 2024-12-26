import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:smart_pen/core/constants.dart';
import 'package:smart_pen/features/analysis/ui/analysis_screen.dart';

class FeelingScreen extends StatefulWidget {
  final String expectation;
  const FeelingScreen({super.key, required this.expectation});

  @override
  State<FeelingScreen> createState() => _FeelingScreenState();
}

class _FeelingScreenState extends State<FeelingScreen> {
  final TextEditingController _textController = TextEditingController();

  late StreamSubscription<List<ScanResult>> scanResultsSubscription;

  BluetoothDevice? targetDevice;

  String targetDeviceName = 'ESP32-C3';

  String targetDeviceAddress = '64:E8:33:8A:24:CE';

  bool isScanning = false;

  bool isConnected = false;

  String? bpm = "";

  String? breathingRate = "";

  String? pressure = "";

  String? email = '';

  String? userName = '';

  String? image = '';

  @override
  void initState() {
    initializeBluetooth();
    super.initState();
  }

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
          // if (result.device.platformName == targetDeviceName && result.device.remoteId.toString() == targetDeviceAddress) {
          if (result.device.platformName == targetDeviceName) {
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("ما هو شعورك"),
        centerTitle: true,
        backgroundColor: mainColor,
        actions: [
          IconButton(
            onPressed: () {
              refreshScan();
            },
            icon: Icon(
              isConnected ? Icons.link_off : Icons.refresh,
              color: const Color(0xFF37474F),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 7, // Allocate 70% of available space
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: _textController, // Attach the controller
                      maxLines: null, // Allows for multiline input
                      expands: true, // Fills available vertical space
                      decoration: const InputDecoration.collapsed(
                        hintText: 'اكتب توقعك الان ...',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return AnalysisScreen(
                            bpm: bpm,
                            breathingRate: breathingRate,
                            pressure: pressure,
                            text: _textController.text,
                          );
                        }));
                        await disconnectFromDevice();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'إنهاء',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
