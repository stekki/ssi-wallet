import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:frontend/utils/styles.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

MobileScannerController cameraController = MobileScannerController(
  autoStart: true,
  detectionSpeed: DetectionSpeed.normal,
  facing: CameraFacing.back,
  torchEnabled: false,
  formats: [BarcodeFormat.qrCode],
);

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen>
    with SingleTickerProviderStateMixin {
  void createConnection(String? link) async {
    await ref.read(connectionServiceProvider).acceptConnection(link);
  }

  bool _bottomSheetErrorOpen = false;

  void _showFailureDialog(String message){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Connection failed"),
          content: Text(message),
          actions: <Widget>[
            TextButton(child: const Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
              cameraController.start();
            }
            ,)
          ]
        );
      }
    );
  }
  void _showBottomSheetDialog(String? message) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
      // animation necessary?
      return AnimatedContainer(
        color: Colors.transparent,
        // what is a good duration?
        duration: const Duration(milliseconds: 40),
        child: Container(
          height: 100,
          color: const Color.fromARGB(255, 255, 145, 75), //change the color?
          child: const Center(child: Text("Not an invitation code"))
        )
      );
     },
    );
    Timer(const Duration(seconds: 2), () {
      if(_bottomSheetErrorOpen){
        Navigator.of(context).pop();
      }
      _bottomSheetErrorOpen = false;
    });
  }  

  void showConfirmationDialog(String? qrValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Connection'),
          content: const Text('Do you want to create this connection?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                cameraController.start();
              },
            ),
            TextButton(
              child: const Text('Accept'),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  createConnection(qrValue);
                  context.go('/home');                    
                } catch (e) {
                  _showFailureDialog(e.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Align(        // Container -> decoration: scaffoldBackground
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Add connection", style: TextStyles.scanProfileScreenText),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 410,
              height: 410,
              child: MobileScanner(
                controller: cameraController,
                onDetect: (capture) {
                  final List<Barcode> qrcodes = capture.barcodes;
                  if (qrcodes.isNotEmpty) {
                    final qrcode = qrcodes.first;
                    String? scannedValue = qrcode.rawValue;
                      if (scannedValue != null && scannedValue.startsWith('didcomm://aries_connection_invitation') == true) {
                        cameraController.stop();
                        debugPrint('Code found: $scannedValue');
                      showConfirmationDialog(scannedValue);
                    } else {
                      if(!_bottomSheetErrorOpen) {
                        _bottomSheetErrorOpen = true;
                        _showBottomSheetDialog(scannedValue);
                        debugPrint('Faulty code found: $scannedValue');
                      }
                    }
                  }
                },
              ),           
            ),
          ],
        ) 
      ),
    );
    
  }
}
