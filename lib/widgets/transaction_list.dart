import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
//  Getting Transaction List~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final List<Transaction> transaction;
  final Function _deletedTransactionFunc;

  TransactionList(this.transaction, this._deletedTransactionFunc);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //ListView Builder takes two args itemBuilder and itemCount~~~~~~~~~~~~~~~
      child: transaction.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No Transactions added yet!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              //itemBuilder takes two args context and indexNumber~~~~~~~~~~~~~~~~~~~~
              itemBuilder: (ctx, indexNumber) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            "\$${transaction[indexNumber].amount}",
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction[indexNumber].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transaction[indexNumber].date),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deletedTransactionFunc(transaction[indexNumber].id);
                      },
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },

              //Item Count takes length of array~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              itemCount: transaction.length,
            ),
    );
  }
}
