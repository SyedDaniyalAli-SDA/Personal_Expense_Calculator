import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/add_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Making MaterialApp as a Root ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
              button: TextStyle(color: Colors.white),
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
  bool _showChartSwitchBtn = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //InitializingArray of Transaction~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final List<Transaction> _userTransaction = [];

  //Method to add New Transaction to array~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    setState(() {
      _userTransaction.add(new Transaction(
          id: DateTime.now().toString(),
          title: txTitle,
          amount: txAmount,
          date: chosenDate));
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((listData) => listData.id == id);
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
    final _mediaQueryObject = MediaQuery.of(context);
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("Personal Expense"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_chart),
          onPressed: () => _showTransactionModalSheet(context),
        )
      ],
    );
    final txListWidget = Container(
      height: (_mediaQueryObject.size.height -
              appBar.preferredSize.height -
          _mediaQueryObject.padding.top) *
          0.7,
      child: TransactionList(_userTransaction, _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(children: [
          if (islandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Show Chart",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch(
                    value: _showChartSwitchBtn,
                    onChanged: (takeBool) {
                      setState(() {
                        _showChartSwitchBtn = takeBool;
                      });
                    })
              ],
            ),
          if (!islandscape)
            Container(
                height: (_mediaQueryObject.size.height -
                        appBar.preferredSize.height -
                    _mediaQueryObject.padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
          if (!islandscape) txListWidget,
          _showChartSwitchBtn
              ? Container(
                  height: (_mediaQueryObject.size.height -
                          appBar.preferredSize.height -
                      _mediaQueryObject.padding.top) *
                      0.7,
                  child: Chart(_recentTransactions))
              : txListWidget
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
