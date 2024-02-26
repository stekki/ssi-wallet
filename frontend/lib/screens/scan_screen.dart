import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

MobileScannerController cameraController = MobileScannerController(autoStart: true,
            detectionSpeed: DetectionSpeed.normal,
            facing: CameraFacing.back,
            torchEnabled: false,
          );
class ScanScreen extends StatelessWidget {
  //const ScanScreen({super.key});
  const ScanScreen({super.key});
    @override
    Widget build(BuildContext context) {
      return Scaffold(
       appBar: AppBar(title: const Text('Add Connection')),

        body: Stack(alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture){
              final List<Barcode> qrcodes = capture.barcodes;
              for(final qrcode in qrcodes) {
                debugPrint('Code found: ${qrcode.rawValue}');
              }
              //context.go('/home');
              //cameraController.stop();
            }
          ),
      ],)
    );
  }
}

