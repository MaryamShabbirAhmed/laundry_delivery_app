
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/providers/pickupProvider.dart';
import 'package:laundry_delivery/screens/historyScreens/orderDetails.dart';
import 'package:laundry_delivery/utils/providerVeriables.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../scanner_error_widget.dart';
import '../utils/colors.dart';
import '../utils/widgets/snackbars.dart';


class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
   MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
  );

  bool isStarted = true;
  BarcodeCapture? barcode;

  @override
  void initState() {
    // controller.stop();
    super.initState();
    pickupPro.isGet = true;

  }


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
          // IconButton(
          //   color: Colors.white,
          //   icon: isStarted
          //       ? const Icon(Icons.stop)
          //       : const Icon(Icons.play_arrow),
          //   iconSize: 32.0,
          //   onPressed: _startOrStop,
          // ),
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: controller.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return Icon(Icons.flash_off, color: whiteColor, size: 20);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.blue, size: 20);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => controller.toggleTorch(),
          )
        ],
      ),
      body: Consumer<PickupProvider>(
        builder: (context, e, child) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                fit: BoxFit.cover,

                onDetect: (barcode) async {
                  setState(() {
                    this.barcode = null;
                    this.barcode = barcode;

                    if (pickupPro.isCreate) {
                      pickupPro.barcode = null;
                      pickupPro.barcode = this.barcode;
                      // controller.stop();
                      // Get.to(DashboardScreen(index: 2,));
                      if (pickupPro.barcode != null) {


                        controller.stop();
                        pickupPro.referenceNoController.text = pickupPro
                            .barcode!.barcodes.first.rawValue
                            .toString();
                        pickupPro.isCreate = false;
                        pickupPro.isGet = false;

                        Get.back();
                      }
                    }
                  });

                  if (this.barcode != null && pickupPro.isGet) {
                    pickupPro.barcode = null;
                    controller.stop();
                    bool getOrder=await pickupPro.getOrderByRefId(
                        displayValue: this
                            .barcode!
                            .barcodes
                            .first
                            .displayValue
                            .toString());
                    if(getOrder)
                      {
                        await Get.to(const OrderDetails());
                        this.barcode=null;
                        controller.stop();
                        controller.start();
                        // controller = MobileScannerController(
                        //   torchEnabled: false,
                        // );

                        setState(() {

                        });
                      }
                    else
                      {
                        logger.i('Not found');
                      }

                  }
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 50,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ValueListenableBuilder(
                      //   valueListenable: controller.hasTorchState,
                      //   builder: (context, state, child) {
                      //     if (state != true) {
                      //       return const SizedBox.shrink();
                      //     }
                      //     return IconButton(
                      //       color: Colors.white,
                      //       icon: ValueListenableBuilder(
                      //         valueListenable: controller.torchState,
                      //         builder: (context, state, child) {
                      //           if (state == null) {
                      //             return const Icon(
                      //               Icons.flash_off,
                      //               color: Colors.grey,
                      //             );
                      //           }
                      //           switch (state as TorchState) {
                      //             case TorchState.off:
                      //               return const Icon(
                      //                 Icons.flash_off,
                      //                 color: Colors.grey,
                      //               );
                      //             case TorchState.on:
                      //               return const Icon(
                      //                 Icons.flash_on,
                      //                 color: Colors.yellow,
                      //               );
                      //           }
                      //         },
                      //       ),
                      //       iconSize: 32.0,
                      //       onPressed: () => controller.toggleTorch(),
                      //     );
                      //   },
                      // ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          height: 50,
                          child: FittedBox(
                            child: Text(
                              barcode?.barcodes.first.rawValue ??
                                  'Scan something!',
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      // IconButton(
                      //   color: Colors.white,
                      //   icon: ValueListenableBuilder(
                      //     valueListenable: controller.cameraFacingState,
                      //     builder: (context, state, child) {
                      //       if (state == null) {
                      //         return const Icon(Icons.camera_front);
                      //       }
                      //       switch (state as CameraFacing) {
                      //         case CameraFacing.front:
                      //           return const Icon(Icons.camera_front);
                      //         case CameraFacing.back:
                      //           return const Icon(Icons.camera_rear);
                      //       }
                      //     },
                      //   ),
                      //   iconSize: 32.0,
                      //   onPressed: () => controller.switchCamera(),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
