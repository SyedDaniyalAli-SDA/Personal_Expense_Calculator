import 'package:expense_calculator/models/transaction.dart';
import 'package:expense_calculator/widgets/add_transaction.dart';
import 'package:expense_calculator/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  static List<Transaction> _userTransaction = [
    Transaction(id: "1", title: "SDA", amount: 2.3, date: DateTime.now()),
    // Transaction(id: "2", title: "SDA2", amount: 2.4, date: DateTime.now()),
    // Transaction(id: "1", title: "SDA", amount: 2.3, date: DateTime.now()),
    // Transaction(id: "2", title: "SDA2", amount: 2.4, date: DateTime.now()),
    // Transaction(id: "1", title: "SDA", amount: 2.3, date: DateTime.now()),
    // Transaction(id: "2", title: "SDA2", amount: 2.4, date: DateTime.now()),
    // Transaction(id: "2", title: "SDA2", amount: 2.4, date: DateTime.now()),
    // Transaction(id: "1", title: "SDA", amount: 2.3, date: DateTime.now()),
    Transaction(id: "2", title: "SDA2", amount: 2.4, date: DateTime.now())
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    setState(() {
      _userTransaction.add(new Transaction(
          id: DateTime.now().toString(),
          title: txTitle,
          amount: txAmount,
          date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AddTransaction(_addNewTransaction),
          TransactionList(_userTransaction),
        ],
      ),
    );
  }
}
