import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int id;
  final int userId;
  final String userName;
  final String userImage;
  final String comment;
  final String imageUrl;

  const Comment({
    this.id = 0,
    this.userId = 0,
    this.userName = "",
    this.userImage = "",
    this.comment = "",
    this.imageUrl = "",
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        userImage,
        comment,
        imageUrl,
      ];
}
