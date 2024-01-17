import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/color_schemes.dart';

class QrDetailsWidget extends StatelessWidget {
  const QrDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 21.0),
      child: Column(
        children: [
          Text(
            'Multiple',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorSchemes.black,
                ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 7.0,
            ),
            width: 139.0,
            constraints: const BoxConstraints(minWidth: 139.0),
            decoration: const BoxDecoration(
              color: ColorSchemes.iconBackGround,
              borderRadius: BorderRadiusDirectional.all(
                Radius.circular(
                  8.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Guest / ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16.0,
                      ),
                ),
                Text(
                  'Friend',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16.0,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 13.0,
          ),
          const Divider(
            color: ColorSchemes.dividerColor,
            thickness: 3.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Inviter',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.gray),
                    ),
                    Text(
                      'Afify',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13.0,
                ),
                const DottedLine(
                  dashColor: ColorSchemes.lightGray,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Visitor',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.gray),
                    ),
                    Text(
                      'Amr',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13.0,
                ),
                const DottedLine(
                  dashColor: ColorSchemes.lightGray,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Unit',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.gray),
                    ),
                    Text(
                      'V/10',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13.0,
                ),
                const DottedLine(
                  dashColor: ColorSchemes.lightGray,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Days',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.gray),
                    ),
                    Text(
                      'Sunday , Monday , Tuesday',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13.0,
                ),
                const DottedLine(
                  dashColor: ColorSchemes.lightGray,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Why You Come to The Compound ?',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.gray),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'Answer 1 , Answer 2',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 15.0, color: ColorSchemes.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13.0,
                ),
                const DottedLine(
                  dashColor: ColorSchemes.lightGray,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expire Date',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.gray),
                    ),
                    Text(
                      '20/9/2023',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13.0,
                ),
                const DottedLine(
                  dashColor: ColorSchemes.lightGray,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prepared Visit Tome',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.gray),
                    ),
                    Text(
                      '20/9/2023',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15.0, color: ColorSchemes.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
