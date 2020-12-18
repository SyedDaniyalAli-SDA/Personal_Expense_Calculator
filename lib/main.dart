import 'package:expense_calculator/widgets/user_transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // static List<Transaction> _transaction = [
  //   Transaction(id: "1", title: "SDA", amount: 2.3, date: DateTime.now()),
  //   Transaction(id: "2", title: "SDA2", amount: 2.4, date: DateTime.now())
  // ];

  // String titleInput;
  // String amountInput;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SDA"),
          backgroundColor: Colors.lightGreen,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: double.infinity,
              color: Colors.lightGreenAccent,
              child: Card(
                child: Text(
                  "CHART!",
                  textAlign: TextAlign.center,
                ),
                elevation: 5,
              ),
            ),
            UserTransaction(),
          ]),
        ),
      ),
    );
  }
}
