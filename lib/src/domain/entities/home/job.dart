import 'package:city_eye/src/presentation/screens/home/utils/home_enum.dart';

final class JobEntity {
  final String id;
  final String unit;
  final String date;
  final StatusJob status;

  JobEntity({
    required this.id,
    required this.unit,
    required this.date,
    required this.status,
  });
}
