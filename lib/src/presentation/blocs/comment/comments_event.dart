part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class GetCommentsEvent extends CommentsEvent {
  final int orderId;
  final bool showLoading;
  GetCommentsEvent({
    required this.orderId,
    required this.showLoading,
  });
}

class MediaIconPressedEvent extends CommentsEvent {}

class AskForCameraPermissionEvent extends CommentsEvent {
  final Function() onTab;

  AskForCameraPermissionEvent({
    required this.onTab,
  });
}

class CameraPressedEvent extends CommentsEvent {}

class GalleryPressedEvent extends CommentsEvent {}

class SendPressedEvent extends CommentsEvent {
}

class NavigateBackEvent extends CommentsEvent {}
