import 'package:city_eye/src/domain/entities/comment/status.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final String orderID;
  final String serviceIcon;
  final String serviceName;
  final String time;
  final String date;
  final double rate;
  final String review;
  final List<Status> statuses;

  const Order({
    this.id = 0,
    this.orderID = "",
    this.serviceIcon = "",
    this.serviceName = "",
    this.time = "",
    this.date = "",
    this.rate = 0,
    this.review = "",
    this.statuses = const [],
  });

  @override
  List<Object?> get props => [
        id,
        orderID,
        serviceIcon,
        serviceName,
        time,
        date,
        rate,
        review,
        statuses,
      ];
}
