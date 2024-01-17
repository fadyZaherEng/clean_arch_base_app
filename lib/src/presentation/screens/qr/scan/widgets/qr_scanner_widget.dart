import 'dart:developer';
import 'dart:io';

import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BuildingQrScannerViewWidget extends BaseStatefulWidget {
  final GlobalKey qrScannerKey;

  const BuildingQrScannerViewWidget({
    super.key,
    required this.qrScannerKey,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _BuildingQrScannerViewWidget();
}

class _BuildingQrScannerViewWidget
    extends BaseState<BuildingQrScannerViewWidget> {
  QRViewController? qrViewController;
  Barcode? barcode;

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await qrViewController?.pauseCamera();
    } else if (Platform.isIOS) {
      qrViewController?.resumeCamera();
    }
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: QRView(
        key: widget.qrScannerKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderLength: 38.0,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderColor: ColorSchemes.white,
          borderWidth: 9.0,
          borderRadius: 1.0,
          //cutOutWidth: 30.0
        ),
      ),
    );
  }

  void onQRViewCreated(QRViewController qrViewController) {
    setState(
      () => this.qrViewController = qrViewController,
    );
    qrViewController.scannedDataStream.listen(
      (barcode) {
        //setState(() => this.barcode = barcode);log(barcode.code!);
        Navigator.of(context).pushReplacementNamed(Routes.qrDetails);
      },
    );
    // if (barcode != null) {
    //   Navigator.of(context).pushReplacementNamed(Routes.qrDetails);
    // }
  }
}
