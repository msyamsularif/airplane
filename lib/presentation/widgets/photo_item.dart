import 'package:flutter/material.dart';

import '../../core/shared/theme.dart';

class PhotoItem extends StatelessWidget {
  final String imageUrl;

  const PhotoItem({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imageUrl),
        ),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    );
  }
}
