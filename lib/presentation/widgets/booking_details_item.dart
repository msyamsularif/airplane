import 'package:flutter/material.dart';

import '../../core/shared/theme.dart';

class BookingDetailsItem extends StatelessWidget {
  final String title;
  final String valuetext;
  final Color valueColor;

  const BookingDetailsItem({
    Key? key,
    required this.title,
    required this.valuetext,
    required this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(right: 6),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icon_check.png'),
              ),
            ),
          ),
          Text(
            title,
            style: blackTextStyle,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              valuetext,
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                color: valueColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
