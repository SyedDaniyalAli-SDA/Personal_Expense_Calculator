import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/add_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Making MaterialApp as a Root Widget~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    return MaterialApp(
      home: MyHomePage(),
      title: "Personal Expense",
      //Applying Themes~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
              headline6: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  //InitializingArray of Transaction~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final List<Transaction> _userTransaction = [
    Transaction(id: "1", title: "SDA", amount: 2.3, date: DateTime.now()),
    Transaction(id: "2", title: "SDA2", amount: 2.4, date: DateTime.now())
  ];

  //Method to add New Transaction to array~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  void _addNewTransaction(String txTitle, double txAmount) {
    setState(() {
      _userTransaction.add(new Transaction(
          id: DateTime.now().toString(),
          title: txTitle,
          amount: txAmount,
          date: DateTime.now()));
    });
  }

  //Show Bottom Sheet~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  void _showTransactionModalSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expense"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_chart),
            onPressed: () => _showTransactionModalSheet(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Theme.of(context).accentColor,
              child: Text(
                "CHART!",
                textAlign: TextAlign.center,
              ),
              elevation: 5,
            ),
          ),
          TransactionList(_userTransaction),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showTransactionModalSheet(context),
      ),
    );
  }
}
