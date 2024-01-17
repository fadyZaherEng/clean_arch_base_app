import 'package:city_eye/src/domain/entities/home/job.dart';
import 'package:city_eye/src/presentation/screens/home/utils/home_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/color_schemes.dart';
import '../../../../core/resources/image_paths.dart';

class TechnicalCardWidget extends StatelessWidget {
  final JobEntity job;

  final Function(JobEntity) onTapCardWidget;

  const TechnicalCardWidget({
    super.key,
    required this.job,
    required this.onTapCardWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          onTapCardWidget(job);
        },
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
                      child: Row(
                        children: [
                          Text(
                            job.id,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.16),
                          ),
                        ],
                      ),
                    ),
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
                        width: 56.0,
                      ),
                      Text(
                        job.unit,
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
                      SvgPicture.asset(ImagePaths.date),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Date",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.16,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(
                        width: 53.0,
                      ),
                      Text(
                        DateFormat('d MMM y').format(DateTime.parse(job.date)),
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
                      SvgPicture.asset(ImagePaths.status),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Status",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: ColorSchemes.gray,
                              letterSpacing: -0.16,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(
                        width: 44.0,
                      ),
                      Container(
                        width: 7.0,
                        height: 7.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorSchemes.green,
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        job.status.status,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: job.status == StatusJob.completed
                                  ? ColorSchemes.green
                                  : ColorSchemes.gray,
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
}
