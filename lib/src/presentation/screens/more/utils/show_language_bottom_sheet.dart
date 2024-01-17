import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/more/language.dart';
import '../widgets/language_bottom_sheet_widget.dart';

Future showLanguageBottomSheet({
  required BuildContext context,
  required double height,
  required List<Language> languages,
  required Language selectedLanguage,
  required Function(Language) onLanguageSelected,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomSheetWidget(
        titleLabel: S.of(context).selectLanguage,
        height: height,
        content: LanguageBottomSheetWidget(
          languages: languages,
          selectedLanguage: selectedLanguage,
          onLanguageSelected: onLanguageSelected,
        ),
      ),
    ),
  );
}
