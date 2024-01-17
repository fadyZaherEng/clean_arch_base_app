import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/presentation/screens/qr_details/blocs/qr_details_bloc.dart';
import 'package:city_eye/src/presentation/screens/qr_details/skeleton/qr_details_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/qr_details_card_widget.dart';

class QrDetailsScreen extends BaseStatefulWidget {
  const QrDetailsScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _QrDetailsState();
}

class _QrDetailsState extends BaseState<QrDetailsScreen> {
  QrDetailsBloc get _bloc => BlocProvider.of<QrDetailsBloc>(context);

  @override
  void initState() {
    super.initState();
    _bloc.add(FetchQrDetailsEvent());
  }

  @override
  Widget baseBuild(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light
      ),
      child: BlocConsumer<QrDetailsBloc, QrDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: state is ShowingSkeletonQrDetailsState
                ? const QrDetailsSkeleton()
                : Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: const BoxDecoration(
                          color: ColorSchemes.primary,
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(40.0),
                            topEnd: Radius.circular(40.0),
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
                      ),
                      const QrDetailsCardWidget(),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
