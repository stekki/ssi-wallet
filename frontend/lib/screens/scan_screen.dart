import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  /*
  void popUntilRoot(BuildContext context) {
    while (context.canPop()) {  
      context.pop();
    }
  }
  */
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Add Connection')),
        body: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.normal,
            facing: CameraFacing.back,
            torchEnabled: false,
            // TODO: Make the scanning stop when the scan screen is closed
          ),
          onDetect: (capture) {
            final List<Barcode> qrcodes = capture.barcodes;
            for(final qrcode in qrcodes) {
              debugPrint('Code found: ${qrcode.rawValue}');
            }
          } 
        
        ,)
      );
  }
}
