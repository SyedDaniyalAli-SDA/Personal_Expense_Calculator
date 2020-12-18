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
      child: ListView.builder(
        itemBuilder: (ctx, indexNumber) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$ ${transaction[indexNumber].amount}',
                    style: TextStyle(
                      color: Colors.purple,
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
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
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
        itemCount: transaction.length,
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
