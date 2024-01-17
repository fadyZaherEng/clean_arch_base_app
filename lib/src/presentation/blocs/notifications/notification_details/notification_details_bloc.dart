import 'dart:async';

import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/domain/usecase/notifications/get_notification_details_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_details_event.dart';

part 'notification_details_state.dart';

class NotificationDetailsBloc
    extends Bloc<NotificationDetailsEvent, NotificationDetailsState> {
  final GetNotificationDetailsDataUseCase _getNotificationDetailsDataUseCase;

  NotificationDetailsBloc(this._getNotificationDetailsDataUseCase)
      : super(ShowSkeletonState()) {
    on<BackEvent>(_onBackEvent);
    on<GetNotificationDetailsDataEvent>(_onGetNotificationDetailsDataEvent);
    on<SetLocalNotificationDetailsDataEvent>(
        _onSetLocalNotificationDetailsDataEvent);
    on<ShowSkeletonEvent>(_onShowSkeletonEvent);
    on<HideSkeletonEvent>(_onHideSkeletonEvent);
  }

  FutureOr<void> _onBackEvent(
      BackEvent event, Emitter<NotificationDetailsState> emit) {
    emit(BackState());
  }

  FutureOr<void> _onGetNotificationDetailsDataEvent(
      GetNotificationDetailsDataEvent event,
      Emitter<NotificationDetailsState> emit) {
    emit(GetNotificationDetailsDataState(_getNotificationDetailsDataUseCase()));
  }

  FutureOr<void> _onSetLocalNotificationDetailsDataEvent(
      SetLocalNotificationDetailsDataEvent event,
      Emitter<NotificationDetailsState> emit) {
    emit(SetLocalNotificationDetailsDataState());
  }

  FutureOr<void> _onShowSkeletonEvent(
      ShowSkeletonEvent event, Emitter<NotificationDetailsState> emit) {
    emit(ShowSkeletonState());
  }

  FutureOr<void> _onHideSkeletonEvent(
      HideSkeletonEvent event, Emitter<NotificationDetailsState> emit) {
    emit(HideSkeletonState());
  }
}
