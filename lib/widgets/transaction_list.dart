import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

//  Getting Transaction List~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final List<Transaction> transaction;
  TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //ListView Builder takes two args itemBuilder and itemCount~~~~~~~~~~~~~~~
      child: ListView.builder(
        //itemBuilder takes two args context and indexNumber~~~~~~~~~~~~~~~~~~~~
        itemBuilder: (ctx, indexNumber) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$ ${transaction[indexNumber].amount}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction[indexNumber].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      DateFormat.yMMMd().format(transaction[indexNumber].date),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),

                    ),
                  ],
                )
              ],
            ),
            elevation: 5,
          );
        },

        //Item Count takes length of array~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        itemCount: transaction.length,
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
