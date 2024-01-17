import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/screens/qr_details/blocs/qr_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/theme/color_schemes.dart';
import 'qr_details_widget.dart';

class QrDetailsCardWidget extends StatelessWidget {
  const QrDetailsCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrDetailsBloc, QrDetailsState>(
      listener: (context, state) {
        if (state is NavigateToBackState) {
          Navigator.of(context).pop();
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 63.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context
                        .read<QrDetailsBloc>()
                        .add(NavigateToBackEvent()),
                    child: SvgPicture.asset(ImagePaths.arrowLeft),
                  ),
                  const SizedBox(width: 133.0),
                  Text(
                    'Details',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorSchemes.white,
                          fontSize: 18.0,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              SvgPicture.asset(ImagePaths.doneSuccess),
              const SizedBox(height: 32.0),
              Container(
                height: 495.0,
                width: 343.0,
                constraints: const BoxConstraints(
                  minHeight: 495.0,
                  maxWidth: 343.0,
                ),
                decoration: const BoxDecoration(
                  color: ColorSchemes.white,
                  borderRadius: BorderRadiusDirectional.all(
                    Radius.circular(16.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorSchemes.notificationShadow,
                      spreadRadius: 0.0,
                      blurRadius: 32.0,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: const QrDetailsWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
