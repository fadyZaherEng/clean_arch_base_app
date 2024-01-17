import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import 'check_statistic_item.dart';

class CheckingStatisticsWidget extends StatelessWidget {
  const CheckingStatisticsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CheckStatisticItem(
          pathIcon: ImagePaths.secondCheckIn,
          titleOfChecking: S.of(context).checkIn,
          value: '09:10',
        ),
        CheckStatisticItem(
          pathIcon: ImagePaths.secondCheckOut,
          titleOfChecking: S.of(context).checkOut,
          value: '-:-',
        ),
        CheckStatisticItem(
          pathIcon: ImagePaths.done,
          titleOfChecking: S.of(context).workHour,
          value: '7',
        ),
      ],
    );
  }
}
