import 'package:expense_calculator/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
//  Getting Transaction List~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final List<Transaction> transaction;
  final Function _deletedTransactionFunc;

  TransactionList(this.transaction, this._deletedTransactionFunc);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      //ListView Builder takes two args itemBuilder and itemCount~~~~~~~~~~~~~~~
      child: transaction.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    "No Transactions added yet!",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.06,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              //itemBuilder takes two args context and indexNumber~~~~~~~~~~~~~~~~~~~~
              itemBuilder: (ctx, indexNumber) {
                return TransactionItem(transaction: transaction[indexNumber], deletedTransactionFunc: _deletedTransactionFunc,);
              },

              //Item Count takes length of array~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              itemCount: transaction.length,
            ),
    );
  }
}
