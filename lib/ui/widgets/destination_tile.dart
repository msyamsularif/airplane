import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class DestinaitonTile extends StatelessWidget {
  final String name;
  final String city;
  final String imageUrl;
  final double rating;

  const DestinaitonTile({
    Key? key,
    required this.name,
    required this.city,
    required this.imageUrl,
    this.rating = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail-destination'),
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Row(
          children: [
            Container(
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
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    city,
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icon_star.png'),
                    ),
                  ),
                ),
                Text(
                  rating.toString(),
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
