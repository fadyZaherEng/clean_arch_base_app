import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/screens/qr/scan/widgets/qr_scanner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../generated/l10n.dart';
import '../../../../config/theme/color_schemes.dart';

class QrCodeScanScreen extends BaseStatefulWidget {
  const QrCodeScanScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _QrCodeScanScreenState();
}

class _QrCodeScanScreenState extends BaseState<QrCodeScanScreen> {
  final qrScannerKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget baseBuild(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.center,
          child: SizedBox(
            child: BuildingQrScannerViewWidget(qrScannerKey: qrScannerKey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 72.0,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SvgPicture.asset(
                  ImagePaths.close,
                  color: ColorSchemes.white,
                ),
              ),
              Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  S.of(context).scanQrCode,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.white,
                        fontSize: 16.0,
                      ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
