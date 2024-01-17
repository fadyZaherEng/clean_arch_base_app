import 'package:equatable/equatable.dart';

class Status extends Equatable {
  final int id;
  final String name;
  final String color;
  final String textColor;
  final int currentStatus; //0 - not started, 1 - in progress, 2 - completed

  const Status({
    this.id = 0,
    this.name = "",
    this.color = "",
    this.textColor = "",
    this.currentStatus = -1,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        color,
        textColor,
        currentStatus,
      ];
}
