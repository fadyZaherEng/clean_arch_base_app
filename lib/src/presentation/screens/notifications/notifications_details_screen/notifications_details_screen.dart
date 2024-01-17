import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/presentation/blocs/notifications/notification_details/notification_details_bloc.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_details_screen/skeleton/skeleton_notifications_details_screen.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_details_screen/widgets/gallery_image_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class NotificationDetailsScreen extends StatefulWidget {
  NotificationDetailsScreen(
      {required this.isPushedNotification,
      required this.notificationDetails,
      super.key});

  bool isPushedNotification = false;
  NotificationItem notificationDetails;

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  NotificationDetailsBloc get _bloc =>
      BlocProvider.of<NotificationDetailsBloc>(context);

  @override
  void initState() {
    if (!widget.isPushedNotification) {
      getLocalNotificationDetailsDataEvent();
    } else {
      getNotificationDetailsDataEvent();
    }
    super.initState();
  }

  Future<void> getNotificationDetailsDataEvent() async {
    await Future.delayed(const Duration(seconds: 3));
    _bloc.add(GetNotificationDetailsDataEvent());
  }

  Future<void> getLocalNotificationDetailsDataEvent() async {
    await Future.delayed(const Duration(seconds: 1));
    _bloc.add(SetLocalNotificationDetailsDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(context,
          title: S.of(context).notificationDetails,
          isHaveBackButton: true, onBackButtonPressed: () {
        _bloc.add(BackEvent());
      }),
      body: BlocConsumer<NotificationDetailsBloc, NotificationDetailsState>(
        listener: (context, state) {
          if (state is BackState) {
            _backDestination();
          } else if (state is ShowSkeletonState) {
          } else if (state is GetNotificationDetailsDataState) {
            widget.notificationDetails = state.list;
          } else if (state is SetLocalNotificationDetailsDataState) {
            // _bloc.add(HideSkeletonEvent());
          }
        },
        builder: (context, state) {
          return state is ShowSkeletonState
              ? const SkeletonNotificationDetailsScreen()
              : Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          widget.notificationDetails.header,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: ColorSchemes.black,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        convertTimestampToDateFormat(
                            widget.notificationDetails.date),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.primary,
                              fontSize: 12,
                            ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: widget
                                  .notificationDetails.imageUri.isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 12),
                                child: SizedBox(
                                  height: 160,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: GalleryImageWidget(
                                      image:
                                          widget.notificationDetails.imageUri,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                widget.notificationDetails.body,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: ColorSchemes.gray,
                                    ),
                              ),
                            ),
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

  void _backDestination() {
    if (widget.isPushedNotification) {
      Navigator.pushReplacementNamed(
        context,
        Routes.notifications,
      ); //(route) => false
    } else {
      Navigator.pop(context);
    }
  }
}
