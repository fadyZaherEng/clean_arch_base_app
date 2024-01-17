import 'package:city_eye/src/domain/entities/home/visitor.dart';
import 'package:city_eye/src/presentation/screens/home/utils/home_enum.dart';
import 'package:city_eye/src/presentation/screens/home/utils/home_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../generated/l10n.dart';
import '../../../../config/theme/color_schemes.dart';
import '../../../../core/resources/image_paths.dart';
import '../../../../core/utils/constants.dart';

class VisitorCardWidget extends StatelessWidget {
  final VisitorEntity visitor;

  final Function() onTapCardWidget;

  const VisitorCardWidget({
    super.key,
    required this.visitor,
    required this.onTapCardWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: onTapCardWidget,
        child: Container(
            decoration: BoxDecoration(
              color: ColorSchemes.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    color: ColorSchemes.lightGray,
                    offset: Offset(0, 1),
                    blurRadius: 30,
                    spreadRadius: 0)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ColorSchemes.searchBackground,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${visitor.visitorType == VisitorType.single ? S.of(context).single : S.of(context).multi} - ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: ColorSchemes.black,
                                        letterSpacing: -0.16),
                              ),
                              Text(
                                'Friend',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.16,
                                      fontWeight: Constants.fontWeightRegular,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            visitor.date,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.16,
                                      fontWeight: Constants.fontWeightRegular,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: visitor.statusColor.toColor,
                                ),
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                visitor.status.status,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: visitor.statusColor.toColor,
                                      fontSize: 16.0,
                                      letterSpacing: -0.24,
                                    ),
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            ImagePaths.arrowRight,
                            fit: BoxFit.scaleDown,
                          ),
                        ],
                      ),
                      const SizedBox(width: 26.0,),
                      Text(
                        "${_getDate(visitor.time)} at ${_getTime(visitor.time)}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.gray,
                              fontSize: 16.0,
                              letterSpacing: -0.16,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset(ImagePaths.owner),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Owner",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.16,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(
                        width: 62.0,
                      ),
                      Text(
                        visitor.owner,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.16,
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  visitor.validDate != null
                      ? Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImagePaths.date),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Text(
                                  "Valid Date",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: ColorSchemes.gray,
                                        letterSpacing: -0.16,
                                        fontSize: 16.0,
                                      ),
                                ),
                                const SizedBox(
                                  width: 35.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '${_getDate(visitor.validDate!)} at ${_getTime(visitor.validDate!)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: ColorSchemes.black,
                                          letterSpacing: -0.16,
                                          fontSize: 16.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        )
                      : const SizedBox.shrink(),
                  Row(
                    children: [
                      SvgPicture.asset(ImagePaths.visitor),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Visitor",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.16,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(
                        width: 67.0,
                      ),
                      Text(
                        visitor.visitor,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.16,
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset(ImagePaths.unit),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Unit",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.16,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(
                        width: 82.0,
                      ),
                      Text(
                        visitor.unit,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.black,
                              letterSpacing: -0.16,
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )),
      ),
    );
  }

  String _getDate(String date) =>
      DateFormat('dd-MM-yyyy').format(DateTime.parse(date));

  String _getTime(String time) => DateFormat.jm().format(
        DateTime.parse(time),
      );
}
