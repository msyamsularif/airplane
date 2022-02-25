import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../widgets/destination_card.dart';
import '../widgets/destination_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 30,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Howdy,\nM Syamsul Arif',
                    style: blackTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Where to fly today?',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: light,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/image_profile.png'),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget pupularDestination() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              DestinationCard(
                name: 'Lake Ciliwung',
                city: 'Tanggerang',
                imageUrl: 'assets/image_destination1.png',
                rating: 4.8,
              ),
              DestinationCard(
                name: 'White Houses',
                city: 'Spain',
                imageUrl: 'assets/image_destination2.png',
                rating: 4.7,
              ),
              DestinationCard(
                name: 'Hill Heyo',
                city: 'Monaco',
                imageUrl: 'assets/image_destination3.png',
                rating: 4.8,
              ),
              DestinationCard(
                name: 'Menarra',
                city: 'Japan',
                imageUrl: 'assets/image_destination4.png',
                rating: 5.0,
              ),
              DestinationCard(
                name: 'Payung Teduh',
                city: 'Singapore',
                imageUrl: 'assets/image_destination5.png',
                rating: 4.8,
              ),
            ],
          ),
        ),
      );
    }

    Widget newDestinations() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          bottom: 110,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New This Year',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            const DestinaitonTile(
              name: 'Danau Beratan',
              city: 'Singaraja',
              imageUrl: 'assets/image_destination6.png',
              rating: 4.5,
            ),
            const DestinaitonTile(
              name: 'Sydney Operan',
              city: 'Australia',
              imageUrl: 'assets/image_destination7.png',
              rating: 4.7,
            ),
            const DestinaitonTile(
              name: 'Roma',
              city: 'Italy',
              imageUrl: 'assets/image_destination8.png',
              rating: 4.8,
            ),
            const DestinaitonTile(
              name: 'Payung Teduh',
              city: 'Singapore',
              imageUrl: 'assets/image_destination9.png',
              rating: 4.5,
            ),
            const DestinaitonTile(
              name: 'Hill Hey',
              city: 'Monaco',
              imageUrl: 'assets/image_destination10.png',
              rating: 4.7,
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        header(),
        pupularDestination(),
        newDestinations(),
      ],
    );
  }
}
