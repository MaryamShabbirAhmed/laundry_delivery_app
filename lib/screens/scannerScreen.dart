import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_delivery/utils/colors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: blackColor,
        leadingWidth: 120,
        leading: IconButton(
          onPressed: () {},
          icon: Row(
            children: [
              Icon(Icons.arrow_back_ios, color: primaryColor, size: 15),
              Text(
                'Scan',
                style: TextStyle(
                    fontSize: 15,
                    color: whiteColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return Icon(Icons.flash_off, color: whiteColor, size: 20);
                  case TorchState.on:
                    return Icon(Icons.flash_on, color: Colors.blue, size: 20);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          // IconButton(
          //   color: Colors.white,
          //   icon: ValueListenableBuilder(
          //     valueListenable: cameraController.cameraFacingState,
          //     builder: (context, state, child) {
          //       switch (state as CameraFacing) {
          //         case CameraFacing.front:
          //           return const Icon(Icons.camera_front);
          //         case CameraFacing.back:
          //           return const Icon(Icons.camera_rear);
          //       }
          //     },
          //   ),
          //   iconSize: 32.0,
          //   onPressed: () => cameraController.switchCamera(),
          // ),
        ],
      ),
      body: Center(
        child: MobileScanner(
          // fit: BoxFit.contain,
          controller: cameraController,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
            }
          },
        ),
      ),
    );
  }
}
