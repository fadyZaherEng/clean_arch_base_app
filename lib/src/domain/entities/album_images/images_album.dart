import 'package:city_eye/src/domain/entities/album_images/images.dart';

class ImagesAlbum {
  final List<Images> images;
  final int initialIndex;

  ImagesAlbum({required this.initialIndex, required this.images});
}
