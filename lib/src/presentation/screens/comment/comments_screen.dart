import 'dart:async';
import 'package:city_eye/src/domain/entities/comment/comment.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/presentation/blocs/comment/comments_bloc.dart';
import 'package:city_eye/src/presentation/screens/comment/widgets/new_message_widget.dart';
import 'package:city_eye/src/presentation/screens/comment/widgets/skelton_comments_screen.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../domain/entities/comment/order.dart';

class CommentsScreen extends BaseStatefulWidget {
  final Order order;

  const CommentsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  BaseState<CommentsScreen> baseCreateState() => _CommentScreenState();
}

class _CommentScreenState extends BaseState<CommentsScreen> {
  CommentsBloc get _bloc => BlocProvider.of<CommentsBloc>(context);

  List<Comment> _comments = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetCommentsEvent(
      orderId: widget.order.id,
      showLoading: true,
    ));

    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _bloc.add(GetCommentsEvent(
        orderId: widget.order.id,
        showLoading: false,
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<CommentsBloc, CommentsState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is GetCommentsSuccessState) {
          _comments = state.comments;
        } else if (state is GetCommentsErrorState) {
        } else if (state is OpenMediaBottomSheetState) {
          showBottomSheetUploadMedia(
              context: context,
              onTapGallery: () {
                _navigateBackEvent();
                _askForCameraPermissionEvent(
                  () {
                    _galleryPressedEvent();
                  },
                );
              },
              onTapCamera: () {
                _navigateBackEvent();
                _askForCameraPermissionEvent(
                  () {
                    _cameraPressedEvent();
                  },
                );
              });
        } else if (state is NavigateBackState) {
          Navigator.pop(context);
        } else if (state is AskForCameraPermissionState) {
          _askForCameraPermission(state.onTab);
        } else if (state is OpenCameraState) {
          _getImage(ImageSource.camera);
        } else if (state is OpenGalleryState) {
          _getImage(ImageSource.gallery);
        } else if (state is SendCommentSuccessState) {
        } else if (state is SendCommentErrorState) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(
            context,
            title: S.of(context).supportRequest,
            isHaveBackButton: true,
            onBackButtonPressed: () {
              _navigateBackEvent();
            },
          ),
          body: state is ShowSkeletonState
              ? const SkeletonCommentsScreen()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      _comments.isEmpty
                          ? Expanded(
                              child: EmptyWidget(
                                text: S.of(context).noMessagesYet,
                                imagePath: ImagePaths.commentsEmpty,
                              ),
                            )
                          : Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 16);
                                },
                                itemCount: _comments.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    child: Row(
                                      textDirection:
                                          _isUser(_comments[index].userId)
                                              ? TextDirection.ltr
                                              : TextDirection.rtl,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              _isUser(_comments[index].userId)
                                                  ? CrossAxisAlignment.start
                                                  : CrossAxisAlignment.end,
                                          children: [
                                            Image.network(
                                              _comments[index].userImage,
                                              width: 24,
                                              height: 24,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Center(
                                                  child: Image.asset(
                                                    ImagePaths
                                                        .profilePlaceHolder,
                                                    width: 24,
                                                    height: 24,
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              _comments[index].userName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: ColorSchemes.black,
                                                    letterSpacing: -0.13,
                                                  ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 32),
                                        _comments[index].imageUrl.isEmpty
                                            ? Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16,
                                                    vertical: 12,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: _isUser(
                                                            _comments[index]
                                                                .userId)
                                                        ? ColorSchemes.primary
                                                        : ColorSchemes
                                                            .commentBackground,
                                                    borderRadius: BorderRadiusDirectional.only(
                                                        topStart:
                                                            const Radius.circular(
                                                                25),
                                                        bottomStart: _isUser(
                                                                _comments[index]
                                                                    .userId)
                                                            ? const Radius.circular(
                                                                25)
                                                            : const Radius
                                                                .circular(0),
                                                        bottomEnd:
                                                            const Radius.circular(
                                                                25),
                                                        topEnd: _isUser(
                                                                _comments[index]
                                                                    .userId)
                                                            ? const Radius.circular(0)
                                                            : const Radius.circular(25)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Hello",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            color: _isUser(
                                                                    _comments[
                                                                            index]
                                                                        .userId)
                                                                ? ColorSchemes
                                                                    .white
                                                                : ColorSchemes
                                                                    .blackGrey,
                                                            letterSpacing:
                                                                -0.13,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Image.network(
                                                "",
                                                width: 50,
                                                height: 100,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .only(
                                                      topStart:
                                                          const Radius.circular(
                                                              0),
                                                      bottomStart:
                                                          const Radius.circular(
                                                              0),
                                                      bottomEnd: _isUser(
                                                              _comments[index]
                                                                  .userId)
                                                          ? const Radius
                                                              .circular(25)
                                                          : const Radius
                                                              .circular(0),
                                                      topEnd:
                                                          const Radius.circular(
                                                              0),
                                                    ),
                                                    child: Image.asset(
                                                      ImagePaths
                                                          .uploadImagePlaceholder,
                                                      width: 200,
                                                      height: 150,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                              ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                      const SizedBox(height: 16),
                      NewMessageWidget(
                        onAttach: () {
                          _bloc.add(MediaIconPressedEvent());
                        },
                        onSend: (message) {
                          FocusScope.of(context).unfocus();
                          _bloc.add(SendPressedEvent());
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
        );
      },
    );
  }

  void _navigateBackEvent() {
    _bloc.add(NavigateBackEvent());
  }

  bool _isUser(int userId) {
    return userId == 1;
  }

  void _askForCameraPermissionEvent(Function() onTab) {
    _bloc.add(AskForCameraPermissionEvent(onTab: () {
      onTab();
    }));
  }

  void _cameraPressedEvent() {
    _bloc.add(CameraPressedEvent());
  }

  void _galleryPressedEvent() {
    _bloc.add(GalleryPressedEvent());
  }

  void _askForCameraPermission(Function() onTab) async {
    bool cameraPermission = await PermissionServiceHandler()
        .handleServicePermission(setting: Permission.camera);
    if (cameraPermission) {
      onTab();
    } else {
      _showActionDialog(
        onPrimaryAction: () async {
          _navigateBackEvent();
          openAppSettings().then((value) {
            if (value == true) {
              onTab();
            }
          });
        },
        onSecondaryAction: () {
          _navigateBackEvent();
        },
        primaryText: (!mounted) ? "" : S.of(context).ok,
        secondaryText: (!mounted) ? "" : S.of(context).cancel,
        text: (!mounted) ? "" : S.of(context).youShouldHaveCameraPermission,
      );
    }
  }

  Future<void> _getImage(
    ImageSource imageSource,
  ) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);
    XFile? imageFile = pickedFile;
    if (imageFile == null) {
      return;
    }

    //Send Request to Server
  }

  void _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
  }) {
    showActionDialogWidget(
      context: context,
      text: text,
      primaryText: primaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryText: secondaryText,
      secondaryAction: () {
        onSecondaryAction();
      },
      icon: ImagePaths.frame,
    );
  }
}
