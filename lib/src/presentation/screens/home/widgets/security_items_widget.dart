import 'package:city_eye/src/presentation/screens/home/widgets/visitor_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/color_schemes.dart';
import '../../../../core/resources/image_paths.dart';
import '../../../../domain/entities/home/visitor.dart';
import '../../../widgets/custom_button_widget.dart';

class SecurityItemsWidget extends StatelessWidget {
  final List<VisitorEntity> visitors;
  final Function() onTapPinCode;

  const SecurityItemsWidget({
    this.visitors = const [],
    required this.onTapPinCode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Visitors',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorSchemes.black,
                  ),
            ),
            CustomButtonWidget(
              width: 120.0,
              height: 40.0,
              buttonBorderRadius: 6.0,
              onTap: onTapPinCode,
              text: 'Pin code',
              isPrefixIcon: true,
              spaceBetweenIconAndText: 6.0,
              customTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.white,
                  ),
              prefixIcon: SvgPicture.asset(
                ImagePaths.lock,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
        visitors.isNotEmpty
            ? Column(
                children: [
                  const SizedBox(height: 10.0),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => VisitorCardWidget(
                      visitor: visitors[index],
                      onTapCardWidget: () {},
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12.0,
                    ),
                    itemCount: visitors.length,
                  ),
                ],
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  SvgPicture.asset(
                    ImagePaths.emptyVisitors,
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    'Sorry no visitors yet',
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
