import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'checking_statistics_widget.dart';
import 'checking_toggle_buttom_widget.dart';

class CheckInAndOutWidget extends StatelessWidget {
  const CheckInAndOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minHeight: 242.0,
      ),
      decoration: const BoxDecoration(
        color: ColorSchemes.searchBackground,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Row(
              children: [
                Text(
                  _getTimeNow(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: ColorSchemes.black),
                ),
                const SizedBox(
                  width: 28.0,
                ),
                Text(
                  _getDatTimeNowWithSpecificFormat(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: ColorSchemes.black, fontSize: 16.0),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 23.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CheckingToggleButtonWidget(
              onPressCheckIn: () {},
              onPressCheckOut: () {},
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          const Divider(
            color: ColorSchemes.lightGray,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CheckingStatisticsWidget(),
          ),
        ],
      ),
    );
  }

  String _getTimeNow() => DateFormat.jm().format(
        DateTime.now(),
      );

  String _getDatTimeNowWithSpecificFormat() =>
      DateFormat('EEEE MMMM dd').format(
        DateTime.now(),
      );
}
