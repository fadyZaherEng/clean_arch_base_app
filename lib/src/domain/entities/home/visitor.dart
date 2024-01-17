import '../../../presentation/screens/home/utils/home_enum.dart';

final class VisitorEntity {
  final VisitorType visitorType;
  final String date;
  final StatusVisitor status;
  final StatusColor statusColor;
  final String time;
  final String owner;
  final String visitor;
  final String unit;
  final String? validDate;

  VisitorEntity({
    required this.visitorType,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.time,
    required this.owner,
    required this.visitor,
    required this.unit,
    this.validDate,
  });

  @override
  String toString() {
    return 'VisitorEntity{visitorType: $visitorType, date: $date, status: $status, statusColor: $statusColor, time: $time, owner: $owner, visitor: $visitor, unit: $unit, validDate: $validDate}';
  }
}
