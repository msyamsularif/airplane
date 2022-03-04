import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubits/seat/seat_cubit.dart';
import '../../models/destination_model.dart';
import '../../models/transaction_model.dart';
import '../../models/user_model.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/seat_item.dart';
import 'checkout_page.dart';

class ChooseSeatPage extends StatelessWidget {
  final DestinationModel destination;
  final UserModel user;

  const ChooseSeatPage({
    Key? key,
    required this.destination,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Text(
          'Select your\nFavorite Seat',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget seatStatus() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            // NOTE : AVAILABLE
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(right: 6),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon_available.png'),
                ),
              ),
            ),
            Text(
              'Available',
              style: blackTextStyle.copyWith(
                fontWeight: regular,
              ),
            ),

            // NOTE : SELECTED
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(left: 10, right: 6),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon_selected.png'),
                ),
              ),
            ),
            Text(
              'Selected',
              style: blackTextStyle.copyWith(
                fontWeight: regular,
              ),
            ),

            // NOTE : UNAVAILABLE
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(left: 10, right: 6),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon_unavailable.png'),
                ),
              ),
            ),
            Text(
              'Unavailable',
              style: blackTextStyle.copyWith(
                fontWeight: regular,
              ),
            ),
          ],
        ),
      );
    }

    Widget selectSeat() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          children: [
            // NOTE : SEAT INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Text(
                      'A',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Text(
                      'B',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Text(
                      ' ',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Text(
                      'C',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Text(
                      'D',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // NOTE : SEAT 1
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SeatItem(
                    id: 'A1',
                    isAvailable: false,
                  ),
                  const SeatItem(
                    id: 'B1',
                    isAvailable: false,
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: Text(
                        '1',
                        style: greyTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SeatItem(
                    id: 'C1',
                  ),
                  const SeatItem(
                    id: 'D1',
                  )
                ],
              ),
            ),

            // NOTE : SEAT 2
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SeatItem(
                    id: 'A2',
                  ),
                  const SeatItem(
                    id: 'B2',
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: Text(
                        '2',
                        style: greyTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SeatItem(
                    id: 'C2',
                  ),
                  const SeatItem(
                    id: 'D2',
                  )
                ],
              ),
            ),

            // NOTE : SEAT 3
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SeatItem(
                    id: 'A3',
                  ),
                  const SeatItem(
                    id: 'B3',
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: Text(
                        '3',
                        style: greyTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SeatItem(
                    id: 'C3',
                  ),
                  const SeatItem(
                    id: 'D3',
                  )
                ],
              ),
            ),

            // NOTE : SEAT 4
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SeatItem(
                    id: 'A4',
                  ),
                  const SeatItem(
                    id: 'B4',
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: Text(
                        '4',
                        style: greyTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SeatItem(
                    id: 'C4',
                  ),
                  const SeatItem(
                    id: 'D4',
                  )
                ],
              ),
            ),

            // NOTE : SEAT 5
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SeatItem(
                    id: 'A5',
                  ),
                  const SeatItem(
                    id: 'B5',
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: Text(
                        '5',
                        style: greyTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SeatItem(
                    id: 'C5',
                  ),
                  const SeatItem(
                    id: 'D5',
                  )
                ],
              ),
            ),

            // NOTE : YOUR SEAT
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your seat',
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  ),
                  BlocBuilder<SeatCubit, List<String>>(
                    builder: (context, state) {
                      return Expanded(
                        child: Text(
                          state.isNotEmpty
                              ? state.join(', ')
                              : 'No seat selected',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // NOTE : TOTAL
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  ),
                  BlocBuilder<SeatCubit, List<String>>(
                    builder: (context, state) {
                      return Text(
                        NumberFormat.currency(
                          locale: 'id-ID',
                          symbol: 'IDR ',
                          decimalDigits: 0,
                        ).format(state.length * destination.price),
                        style: purpleTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget checkoutButton() {
      return BlocBuilder<SeatCubit, List<String>>(
        builder: (context, state) {
          int price = destination.price * state.length;
          return CustomBottom(
            title: 'Continue to Checkout',
            margin: const EdgeInsets.only(top: 30, bottom: 46),
            onPressed: state.isNotEmpty
                ? () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return CheckoutPage(
                            transaction: TransactionModel(
                              user: user,
                              destination: destination,
                              amountOfTravelers: state.length,
                              selectedSeats: state.join(', '),
                              insurance: true,
                              refundable: false,
                              vit: 0.45,
                              price: price,
                              grandTotal: price + (price * 0.45).toInt(),
                            ),
                          );
                        },
                      ),
                    )
                : null,
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          title(),
          seatStatus(),
          selectSeat(),
          checkoutButton(),
        ],
      ),
    );
  }
}
