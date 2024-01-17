import 'dart:async';

import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/domain/usecase/notifications/get_notifications_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsDataUseCase _getNotificationsDataUseCase;

  NotificationsBloc(this._getNotificationsDataUseCase)
      : super(ShowSkeletonState()) {
    on<GetNotificationsDataEvent>(_onGetNotificationsDataEvent);
    on<NotificationsPopEvent>(_onNotificationsPopEvent);
    on<NotificationClickActionEvent>(_onNotificationClickActionEvent);
  }

  FutureOr<void> _onGetNotificationsDataEvent(
      GetNotificationsDataEvent event, Emitter<NotificationsState> emit) {
    emit(NotificationsDataState(notifications: _getNotificationsDataUseCase()));
  }

  FutureOr<void> _onNotificationsPopEvent(
      NotificationsPopEvent event, Emitter<NotificationsState> emit) {
    emit(NotificationsPopState());
  }

  FutureOr<void> _onNotificationClickActionEvent(
      NotificationClickActionEvent event, Emitter<NotificationsState> emit) {
    emit(NotificationClickActionState(event.notificationItem));
  }
}
