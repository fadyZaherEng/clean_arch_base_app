import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChange;
  final Function() onClear;
  final String searchText;

  const SearchTextFieldWidget({
    Key? key,
    required this.controller,
    required this.onChange,
    required this.searchText,
    required this.onClear,
  }) : super(key: key);

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  bool _showHideClearIcon = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: widget.controller,
      onChanged: (value) {
        _onChange(value);
        widget.onChange(value);
      },
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: ColorSchemes.gray, letterSpacing: -0.13),
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorSchemes.white,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorSchemes.lightGray,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorSchemes.lightGray,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorSchemes.lightGray,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16)),
        hintText: widget.searchText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: ColorSchemes.gray, letterSpacing: -0.13),
        prefixIconConstraints:
            const BoxConstraints(maxHeight: 45, maxWidth: 45),
        prefixIcon: Padding(
          padding:
              const EdgeInsets.only(left: 16, bottom: 7, right: 12.5, top: 5),
          child: SvgPicture.asset(ImagePaths.search, width: 16, height: 16),
        ),
        suffixIcon: InkWell(
          onTap: () {
            _onClear();
            widget.onClear();
          },
          child: _showHideClearIcon
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 10, bottom: 5, right: 10, top: 5),
                  child: SvgPicture.asset(
                    fit: BoxFit.scaleDown,
                    ImagePaths.close,
                    width: 18,
                    height: 18,
                  ),
                )
              : const SizedBox(),
        ),
        contentPadding: const EdgeInsets.only(left: 16.0),
        labelStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: ColorSchemes.gray, letterSpacing: -0.13),
        errorMaxLines: 2,
      ),
    );
  }

  void _onClear() {
    setState(() {
      _showHideClearIcon = false;
      widget.controller.clear();
    });
  }

  void _onChange(String value) {
    setState(() {
      if (value.trim().isNotEmpty) {
        _showHideClearIcon = true;
      } else {
        _showHideClearIcon = false;
      }
    });
  }
}
