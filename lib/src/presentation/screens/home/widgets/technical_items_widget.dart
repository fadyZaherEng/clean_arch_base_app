import 'package:city_eye/src/presentation/screens/home/widgets/technical_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/color_schemes.dart';
import '../../../../core/resources/image_paths.dart';
import '../../../../domain/entities/home/job.dart';
import '../../../widgets/custom_button_widget.dart';

class TechnicalItemsWidget extends StatelessWidget {
  final List<JobEntity> jobs;
  final Function(JobEntity) onTapCard;

  const TechnicalItemsWidget({
    super.key,
    required this.jobs,
    required this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Jobs',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorSchemes.black,
                  ),
            ),
          ],
        ),
        jobs.isNotEmpty
            ? Column(
                children: [
                  const SizedBox(height: 10.0),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => TechnicalCardWidget(
                      job: jobs[index],
                      onTapCardWidget: onTapCard,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12.0,
                    ),
                    itemCount: jobs.length,
                  ),
                ],
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  SvgPicture.asset(
                    ImagePaths.emptyJobs,
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    'Sorry no jobs yet',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.black,
                          fontSize: 16.0,
                        ),
                  )
                ],
              ),
      ],
    );
  }
}
