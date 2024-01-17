import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'job_details_event.dart';

part 'job_details_state.dart';

class JobDetailsBloc extends Bloc<JobDetailsEvent, JobDetailsState> {
  JobDetailsBloc() : super(ShowSkeletonState()) {
    on<BackEvent>(_onBackEvent);
    on<GetJobsDetailsDataEvent>(_onGetDataFromRemoteEvent);
    on<OnBottomReceiveClickEvent>(_onOnBottomReceiveClickEvent);
    on<OnBottomStartJobClickEvent>(_onOnBottomStartJobClickEvent);
    on<OnBottomCompleteClickEvent>(_onOnBottomCompleteClickEvent);
    on<OnBottomMoreClickEvent>(_onOnBottomMoreClickEvent);
  }

  FutureOr<void> _onBackEvent(BackEvent event, Emitter<JobDetailsState> emit) {
    emit(BackState());
  }

  FutureOr<void> _onGetDataFromRemoteEvent(
      GetJobsDetailsDataEvent event, Emitter<JobDetailsState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(GetJobsDetailsSuccessState());
  }

  FutureOr<void> _onOnBottomReceiveClickEvent(
      OnBottomReceiveClickEvent event, Emitter<JobDetailsState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(OnBottomReceiveSuccessState(message: "Receive Success"));
  }

  FutureOr<void> _onOnBottomStartJobClickEvent(
      OnBottomStartJobClickEvent event, Emitter<JobDetailsState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(OnBottomStartJobSuccessState(message: "Job Start Success"));
  }

  FutureOr<void> _onOnBottomCompleteClickEvent(
      OnBottomCompleteClickEvent event, Emitter<JobDetailsState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(OnBottomCompleteSuccessState(message: "Complete Success"));
  }

  FutureOr<void> _onOnBottomMoreClickEvent(
      OnBottomMoreClickEvent event, Emitter<JobDetailsState> emit) async {
    // await Future.delayed(const Duration(seconds: 2));
    emit(OnBottomMoreSuccessState(message: "More Success"));
  }
}
