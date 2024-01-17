import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/comment/comment.dart';

part 'comments_event.dart';

part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final List<Comment> _comments = [
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "dsdsddsdsdsd",
      userId: 1,
      userImage: "",
      userName: "Hassan",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 1,
      userImage: "",
      userName: "Hassan",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 1,
      userImage: "",
      userName: "Hassan",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 2,
      userImage: "",
      userName: "Amr",
    ),
    const Comment(
      id: 0,
      comment: "Hello",
      imageUrl: "",
      userId: 1,
      userImage: "",
      userName: "Hassan",
    ),
  ];

  CommentsBloc() : super(CommentsInitial()) {
    on<GetCommentsEvent>(_onGetCommentsEvent);
    on<AskForCameraPermissionEvent>(_onAskForCameraPermissionEvent);
    on<CameraPressedEvent>(_onCameraPressedEvent);
    on<GalleryPressedEvent>(_onGalleryPressedEvent);
    on<MediaIconPressedEvent>(_onMediaIconPressedEvent);
    on<SendPressedEvent>(_onSendPressedEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
  }

  FutureOr<void> _onGetCommentsEvent(
      GetCommentsEvent event, Emitter<CommentsState> emit) async {
    if(event.showLoading){
      emit(ShowSkeletonState());
    }

    await Future.delayed(const Duration(seconds: 2));
    emit(GetCommentsSuccessState(comments: _comments));
    // if(event.showLoading){
    //   emit(HideLoadingState());
    // }
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<CommentsState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onAskForCameraPermissionEvent(
      AskForCameraPermissionEvent event, Emitter<CommentsState> emit) {
    emit(AskForCameraPermissionState(onTab: event.onTab));
  }

  FutureOr<void> _onCameraPressedEvent(
      CameraPressedEvent event, Emitter<CommentsState> emit) {
    emit(OpenCameraState());
  }

  FutureOr<void> _onGalleryPressedEvent(
      GalleryPressedEvent event, Emitter<CommentsState> emit) {
    emit(OpenGalleryState());
  }

  FutureOr<void> _onMediaIconPressedEvent(
      MediaIconPressedEvent event, Emitter<CommentsState> emit) {
    emit(OpenMediaBottomSheetState());
  }

  FutureOr<void> _onSendPressedEvent(
      SendPressedEvent event, Emitter<CommentsState> emit) async {
    emit(ShowLoadingState());

    await Future.delayed(const Duration(seconds: 2));
    emit(SendCommentSuccessState());

    emit(HideLoadingState());
  }
}
