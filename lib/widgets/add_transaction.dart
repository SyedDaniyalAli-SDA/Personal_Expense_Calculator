import 'package:expense_calculator/custom_widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  //  Getting Transaction Function into StateFul Widget~~~~~~~~~~~~~~~~~~~~~~~~~
  final Function _addTransaction;

  AddTransaction(this._addTransaction) {
    print('Constructor AddTransaction Widget');
  }

  @override
  _AddTransactionState createState() {
    print('createState AddTransaction Widget');
    return _AddTransactionState();
  }
}

class _AddTransactionState extends State<AddTransaction> {
  _AddTransactionState() {
    print('Constructor AddTransaction State');
  }

  @override
  void initState() {
    print('initState AddTransaction Widget');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AddTransaction oldWidget) {
    print('didUpdateWidget AddTransaction Widget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose AddTransaction Widget');
    super.dispose();
  }

  //Declaring Controllers of TextFields~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  //Method to Pass New Transaction to transaction Function~~~~~~~~~~~~~~~~~~~~~~
  void _addNewTransaction() {
    if (amountController.text.isEmpty) {
      return;
    }
    //Initializing Controllers of TextFields~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    String txTitle = titleController.text;
    double txAmount = double.parse(amountController.text);

    //Validating Data
    if (txTitle.isEmpty || txAmount <= 0 || _selectedDate == null) {
      return;
    }

    //Passing Arguments
    widget._addTransaction(txTitle, txAmount, _selectedDate);

    //Closing BottomSheet
    Navigator.of(context).pop();
  }

  //Function to Show Date Picker~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  void _displayDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).padding.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              // onChanged: (value) {
              //   titleInput = value;
              // },
              onSubmitted: (_) => _addNewTransaction(),
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              onSubmitted: (_) => _addNewTransaction(),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Amount",
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No date chosen!"
                          : "Selected Date: ${DateFormat.yMd().format(_selectedDate)}",
                    ),
                  ),
                  AdaptiveFlatButton(
                    text: "Chose Date",
                    handler: _displayDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _addNewTransaction,
              child: Text(
                "Add Transaction",
              ),
            )
          ],
        ),
      ),
    );
  }
}
