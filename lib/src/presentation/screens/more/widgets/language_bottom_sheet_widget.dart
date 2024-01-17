import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/presentation/widgets/custom_radio_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/more/language.dart';

class LanguageBottomSheetWidget extends StatelessWidget {
  final List<Language> languages;
  final Language selectedLanguage;
  final Function(Language) onLanguageSelected;

  const LanguageBottomSheetWidget({
    Key? key,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: languages.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () => onLanguageSelected(languages[index]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.network(
                        languages[index].name,
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            ImagePaths.flagPlaceHolder,
                            fit: BoxFit.fill,
                            width: 24,
                            height: 24,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      languages[index].name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: Constants.fontWeightRegular,
                            letterSpacing: -0.24,
                            color: selectedLanguage.code == languages[index].code
                                ? ColorSchemes.primary
                                : ColorSchemes.gray,
                          ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomRadioButtonWidget(
                      isSelected: selectedLanguage.code == languages[index].code,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 0.6,
              width: double.infinity,
              color: ColorSchemes.border,
            )
          ],
        );
      },
    );
  }
}
