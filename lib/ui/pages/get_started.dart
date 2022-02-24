import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image_get_started.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Fly Like a Bird',
                  style: whiteTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Explore new word with us and let\nyour self get an amazing experiences',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: light,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 80),
                  width: 220,
                  height: 55,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Get Started',
                      style: whiteTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
