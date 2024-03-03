import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:frontend/utils/styles.dart';
import 'package:go_router/go_router.dart';

MobileScannerController cameraController = MobileScannerController(autoStart: true,
            detectionSpeed: DetectionSpeed.normal,
            facing: CameraFacing.back,
            torchEnabled: false,
          );        

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen>
    with SingleTickerProviderStateMixin {

void createConnection(String? link) async {
  await ref
      .read(connectionServiceProvider)
      .acceptConnection(link);
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
              onPressed: () {
                Navigator.of(context).pop();
                createConnection(qrValue);
                context.go('/home');

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
      appBar: AppBar(
        title: const Text('Add Connection', style: TextStyles.appBarText),
      ),
      body: Container(
        decoration: scaffoldBackground,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 410,
            height: 410,
            child: MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> qrcodes = capture.barcodes;
                if (qrcodes.isNotEmpty) {
                  final qrcode = qrcodes.first;
                  cameraController.stop();
                  debugPrint('Code found: ${qrcode.rawValue}');
                  showConfirmationDialog(qrcode.rawValue);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}