import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_message_dialog_widget.dart';
import 'package:city_eye/src/domain/entities/album_images/images.dart';
import 'package:city_eye/src/domain/entities/album_images/images_album.dart';
import 'package:city_eye/src/presentation/blocs/job_details/job_details_bloc.dart';
import 'package:city_eye/src/presentation/screens/album_images_screen/album_images_screen.dart';
import 'package:city_eye/src/presentation/screens/job_details/skeleton/job_details_skeleton.dart';
import 'package:city_eye/src/presentation/screens/job_details/widgets/bottom_widget_item.dart';
import 'package:city_eye/src/presentation/screens/job_details/widgets/images_widget_list.dart';
import 'package:city_eye/src/presentation/widgets/audio_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class JobDetailsScreen extends BaseStatefulWidget {
  final String title;

  const JobDetailsScreen({required this.title, super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends BaseState<JobDetailsScreen> {
  JobDetailsBloc get _bloc => BlocProvider.of<JobDetailsBloc>(context);

  VideoPlayerController? _videoPlayerController;
  String videoUrl =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";

  List<Images> imagesList = [
    Images(
        id: 1,
        imagePath:
            "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg"),
    Images(
        id: 2,
        imagePath:
            "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg"),
    Images(
        id: 3,
        imagePath:
            "https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg"),
    Images(
        id: 4,
        imagePath:
            "https://fastly.picsum.photos/id/976/200/200.jpg?hmac=xz9CTpScnLHQm_wNTcJmz8bQM6-ApTQnof5-4LGtu-s"),
    Images(
        id: 5,
        imagePath:
            "https://fastly.picsum.photos/id/976/200/200.jpg?hmac=xz9CTpScnLHQm_wNTcJmz8bQM6-ApTQnof5-4LGtu-s"),
    Images(
        id: 6,
        imagePath:
            "https://fastly.picsum.photos/id/976/200/200.jpg?hmac=xz9CTpScnLHQm_wNTcJmz8bQM6-ApTQnof5-4LGtu-s"),
    Images(id: 7, imagePath: "https://www.gstatic.com/webp/gallery3/1.sm.png"),
  ];

  String _audioPath =
      "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3";

  bool isSkeleton = true;

  @override
  void initState() {
    _bloc.add(GetJobsDetailsDataEvent());

    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(context,
          title: widget.title, isHaveBackButton: true, onBackButtonPressed: () {
        _bloc.add(BackEvent());
      },
          actionWidget: !isSkeleton
              ? GestureDetector(
                  onTap: () => _bloc.add(ActionWidgetClickedEvent()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SvgPicture.asset(ImagePaths.commentIcon),
                  ))
              : const SizedBox.shrink()),
      bottomNavigationBar: !isSkeleton
          ? Container(
              height: 80,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                    blurRadius: 32,
                    color: Color.fromRGBO(0, 0, 0, 0.12),
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomWidgetItem(
                      imagePath: ImagePaths.receiveIcon,
                      text: S.of(context).receive,
                      onBottomItemTap: () {
                        _onBottomReceiveClickEvent();
                      },
                    ),
                    Container(
                      height: 32,
                      width: 1,
                      color: ColorSchemes.lightGray,
                    ),
                    BottomWidgetItem(
                      imagePath: ImagePaths.startJobIcon,
                      text: S.of(context).startJob,
                      onBottomItemTap: () {
                        _onBottomStartJobClickEvent();
                      },
                    ),
                    Container(
                      height: 32,
                      width: 1,
                      color: ColorSchemes.lightGray,
                    ),
                    BottomWidgetItem(
                      imagePath: ImagePaths.completeIcon,
                      text: S.of(context).complete,
                      onBottomItemTap: () {
                        _onBottomCompleteClickEvent();
                      },
                    ),
                    Container(
                      height: 32,
                      width: 1,
                      color: ColorSchemes.lightGray,
                    ),
                    BottomWidgetItem(
                      imagePath: ImagePaths.moreIcon,
                      text: S.of(context).more,
                      onBottomItemTap: () {
                        _bloc.add(OnBottomMoreClickEvent());
                      },
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: BlocConsumer<JobDetailsBloc, JobDetailsState>(
        listener: (context, state) {
          if (state is BackState) {
            Navigator.pop(context);
          } else if (state is ActionWidgetClickedState) {
            _onActionWidgetClicked();
          } else if (state is ShowSkeletonState) {
          } else if (state is GetJobsDetailsFailedState) {
            _showMessageDialogWidget(text: "Failed to get data");
          } else if (state is GetJobsDetailsSuccessState) {
            _videoPlayerController =
                VideoPlayerController.networkUrl(Uri.parse(videoUrl))
                  ..initialize().then((value) => setState(() {}));
            _loadingComplete();
          } else if (state is OnBottomReceiveFailedState) {
            _showMessageDialogWidget(text: state.message);
          } else if (state is OnBottomReceiveSuccessState) {
            _showMessageDialogWidget(text: state.message);
          } else if (state is OnBottomStartJobFailedState) {
            _showMessageDialogWidget(text: state.message);
          } else if (state is OnBottomStartJobSuccessState) {
            _showMessageDialogWidget(text: state.message);
          } else if (state is OnBottomCompleteFailedState) {
            _showMessageDialogWidget(text: state.message);
          } else if (state is OnBottomCompleteSuccessState) {
            _showMessageDialogWidget(text: state.message);
          } else if (state is OnBottomMoreFailedState) {
            _showMessageDialogWidget(text: state.message);
          } else if (state is OnBottomMoreSuccessState) {
            _showContextMenu(context);
          }
        },
        builder: (context, state) {
          return state is ShowSkeletonState
              ? const JobDetailsSkeleton()
              : CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      ImagePaths.jobDetailsNameIcon,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: ColorSchemes.black,
                                              fontSize: 16),
                                    ),
                                    const Expanded(child: SizedBox(width: 8)),
                                    Text(
                                      "11 Sep 2023",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: ColorSchemes.gray,
                                              fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      ImagePaths.unitIcon,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      S.of(context).unit,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: ColorSchemes.gray,
                                              fontSize: 16),
                                    ),
                                    const Expanded(child: SizedBox(width: 8)),
                                    Text(
                                      "V/10",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: ColorSchemes.black,
                                              fontSize: 16),
                                    ),
                                    const Expanded(child: SizedBox(width: 8)),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: ColorSchemes.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Completed",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: ColorSchemes.green,
                                              fontSize: 16,
                                              letterSpacing: -0.24),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                Text(
                                  "s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: ColorSchemes.gray,
                                        fontSize: 16,
                                        letterSpacing: -0.16,
                                      ),
                                ),
                                const SizedBox(height: 24),
                                _videoPlayerController == null
                                    ? const SizedBox.shrink()
                                    : _videoPlayerController!
                                            .value.isInitialized
                                        ? VideoWidget(
                                            videoController:
                                                _videoPlayerController!,
                                          )
                                        : const SizedBox.shrink(),
                                imagesList.isNotEmpty
                                    ? ImagesWidgetList(
                                        images: imagesList,
                                        onImageItemClick: (index) {
                                          _onNavigateToAlbumImagesScreenState(
                                              images: imagesList,
                                              initialIndex: index);
                                        },
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(height: 20),
                                _audioWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }

  Widget _audioWidget() {
    return _audioPath.isEmpty
        ? const SizedBox.shrink()
        : AudioWidget(
            audioPath: _audioPath,
          );
  }

  void _showMessageDialogWidget({required String text}) {
    hideLoading();
    showMessageDialogWidget(
        context: context,
        text: text,
        icon: ImagePaths.frame,
        buttonText: S.of(context).ok,
        onTap: () {
          _bloc.add(BackEvent());
        });
  }

  void _loadingComplete() {
    setState(() {
      isSkeleton = false;
    });
  }

  void _onNavigateToAlbumImagesScreenState({
    required List<Images> images,
    required int initialIndex,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlbumImageScreen(
          imagesAlbum: ImagesAlbum(
            initialIndex: initialIndex,
            images: images,
          ),
        ),
      ),
    );
    /*Navigator.pushNamed(context, Routes.albumImages,
        arguments: ImagesAlbum(
          initialIndex: initialIndex,
          images: images,
        ));*/
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose();
  }

  _onActionWidgetClicked() {
    // todo navigate to Comment Screen
  }

  void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();

    await showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height - 240, 100, 100),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),
        items: [
          PopupMenuItem(
            onTap: () => _onBottomReceiveClickEvent(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(ImagePaths.receiveIcon),
                const SizedBox(width: 4),
                Text(S.of(context).receive),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () => _onBottomStartJobClickEvent(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(ImagePaths.startJobIcon),
                const SizedBox(width: 4),
                Text(S.of(context).startJob),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () => _onBottomCompleteClickEvent(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(ImagePaths.completeIcon),
                const SizedBox(width: 4),
                Text(S.of(context).complete),
              ],
            ),
          )
        ]);
  }

  _onBottomReceiveClickEvent() {
    showLoading();
    _bloc.add(OnBottomReceiveClickEvent());
  }

  _onBottomStartJobClickEvent() {
    showLoading();
    _bloc.add(OnBottomStartJobClickEvent());
  }

  _onBottomCompleteClickEvent() {
    showLoading();
    _bloc.add(OnBottomCompleteClickEvent());
  }
}
