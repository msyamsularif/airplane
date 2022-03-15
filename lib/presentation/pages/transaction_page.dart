import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/shared/theme.dart';
import '../cubits/transaction/transaction_cubit.dart';
import '../widgets/transaction_card.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;

    context.read<TransactionCubit>().fetchTransactions(userId: user!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        } else if (state is TransactionSuccess) {
          if (state.transaction.isEmpty) {
            return const Center(
              child: Text('No Transaction'),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                top: defaultMargin,
                bottom: 124,
              ),
              itemCount: state.transaction.length,
              itemBuilder: (context, index) => TransactionCard(
                transaction: state.transaction[index],
              ),
            );
          }
        } else if (state is TransactionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: kRedColor,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
