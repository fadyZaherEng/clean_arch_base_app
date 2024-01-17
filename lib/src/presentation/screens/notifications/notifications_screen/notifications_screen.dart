import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/data/sources/local/notifcationsSingleton.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_screen/skeleton/skeleton_notification_screen.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_screen/widgets/notification_list_item_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/routes_manager.dart';

class NotificationsScreen extends BaseStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _NotificationsScreenState();
}

List<NotificationItem> notifications = [];

class _NotificationsScreenState extends BaseState<NotificationsScreen> {
  NotificationsBloc get _bloc => BlocProvider.of<NotificationsBloc>(context);

  @override
  void initState() {
    getNotificationsDataEvent();
    super.initState();
  }

  Future<void> getNotificationsDataEvent() async {
    await Future.delayed(const Duration(seconds: 3));
    _bloc.add(GetNotificationsDataEvent());
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.white,
      appBar: buildAppBarWidget(context,
          title: S.of(context).notifications,
          isHaveBackButton: true, onBackButtonPressed: () {
        _bloc.add(NotificationsPopEvent());
      }),
      body: BlocConsumer<NotificationsBloc, NotificationsState>(
        listener: (context, state) {
          if (state is NotificationsDataState) {
            notifications = state.notifications;
            NotificationsSingleton().notifications = notifications;
          } else if (state is NotificationsPopState) {
            Navigator.pop(context);
          } else if (state is NotificationClickActionState) {
            Navigator.pushNamed(
              context,
              Routes.notificationDetails,
              arguments: {
                "isPushedNotification": false,
                "details": state.notificationItem,
              },
            );
          }
        },
        builder: (context, state) {
          return state is ShowSkeletonState
              ? const SkeletonNotificationScreen()
              : Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                NotificationListItemWidget(
                                  notifications[index],
                                  onClickActionEvent,
                                ),
                            itemCount: notifications.length),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  void onClickActionEvent(NotificationItem notificationItem) {
    _bloc.add(NotificationClickActionEvent(notificationItem));
  }
}
