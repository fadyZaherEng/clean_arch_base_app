import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'qr_details_event.dart';

part 'qr_details_state.dart';

class QrDetailsBloc extends Bloc<QrDetailsEvent, QrDetailsState> {
  QrDetailsBloc() : super(ShowingSkeletonQrDetailsState()) {
    on<FetchQrDetailsEvent>(_onFetchQrDetailsEvent);
    on<NavigateToBackEvent>(_onNavigateToBackEvent);
  }

  Future<void> _onFetchQrDetailsEvent(
      FetchQrDetailsEvent event, Emitter<QrDetailsState> emit) async {
    await Future.delayed(const Duration(seconds: 6));
    emit(FetchQrDetailsState());
  }

  FutureOr<void> _onNavigateToBackEvent(
      NavigateToBackEvent event, Emitter<QrDetailsState> emit) {
    emit(NavigateToBackState());
  }
}
