import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubits/auth/auth_cubit.dart';
import '../../shared/theme.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 211,
        padding: EdgeInsets.all(defaultMargin),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/image_card.png'),
          ),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.5),
              blurRadius: 50,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: whiteTextStyle.copyWith(
                                fontWeight: light,
                              ),
                            ),
                            Text(
                              state.user.name,
                              style: whiteTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: medium,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icon_plane.png'),
                          ),
                        ),
                      ),
                      Text(
                        'Pay',
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'Balance',
                    style: whiteTextStyle.copyWith(fontWeight: light),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'id-ID',
                      symbol: 'IDR ',
                      decimalDigits: 0,
                    ).format(
                      state.user.balance,
                    ),
                    style: whiteTextStyle.copyWith(
                      fontSize: 26,
                      fontWeight: medium,
                    ),
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
