import 'dart:io';

import 'package:flutter/cupertino.dart';
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showChartSwitchBtn = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didAppChangeLifeCycleState(AppLifecycleState appLifecycleState){
    print(appLifecycleState);
  }

  @override
  dispose()
  {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  List<Transaction> get _recentTransactions {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //InitializingArray of Transaction~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final List<Transaction> _userTransaction = [
    Transaction(id: '1', title: 'Record 1', amount: 12, date: DateTime.now()),
    Transaction(id: '2', title: 'Record 2', amount: 13, date: DateTime.now()),
    Transaction(id: '3', title: 'Record 3', amount: 14, date: DateTime.now()),
    Transaction(id: '4', title: 'Record 4', amount: 15, date: DateTime.now()),
    Transaction(id: '5', title: 'Record 5', amount: 16, date: DateTime.now()),
    Transaction(id: '6', title: 'Record 6', amount: 17, date: DateTime.now())
  ];

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

  List<Widget> _buildLandscapeContent(
      {MediaQueryData mediaQueryObject,
      AppBar appBar,
      Widget transactionListWidget}) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Show Chart",
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).primaryColor,
              value: _showChartSwitchBtn,
              onChanged: (takeBool) {
                setState(() {
                  _showChartSwitchBtn = takeBool;
                });
              })
        ],
      ),
      _showChartSwitchBtn
          ? Container(
              height: (mediaQueryObject.size.height -
                      appBar.preferredSize.height -
                      mediaQueryObject.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : transactionListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      {MediaQueryData mediaQueryObject,
      AppBar appBar,
      Widget transactionListWidget}) {
    return [
      Container(
        height: (mediaQueryObject.size.height -
                appBar.preferredSize.height -
                mediaQueryObject.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      transactionListWidget
    ];
  }

  Widget _buildAppBarContent() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Personal Expense"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onDoubleTap: () => _showTransactionModalSheet(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text("Personal Expense"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add_chart),
                onPressed: () => _showTransactionModalSheet(context),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQueryObject = MediaQuery.of(context);
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Variables of Widgets~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    final PreferredSizeWidget appBar = _buildAppBarContent();

    final _transactionListWidget = Container(
      height: (_mediaQueryObject.size.height -
              appBar.preferredSize.height -
              _mediaQueryObject.padding.top) *
          0.7,
      child: TransactionList(_userTransaction, _deleteTransaction),
    );

    //Page Body~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    final _pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          if (_isLandscape)
            ..._buildLandscapeContent(
                appBar: appBar,
                transactionListWidget: _transactionListWidget,
                mediaQueryObject: _mediaQueryObject),
          if (!_isLandscape)
            ..._buildPortraitContent(
                appBar: appBar,
                mediaQueryObject: _mediaQueryObject,
                transactionListWidget: _transactionListWidget),
        ]),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: _pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showTransactionModalSheet(context),
                  ),
          );
  }
}
