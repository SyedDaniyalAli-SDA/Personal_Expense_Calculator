import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {

  //  Getting Transaction Function into StateFul Widget~~~~~~~~~~~~~~~~~~~~~~~~~
  final Function _addTransaction;
  AddTransaction(this._addTransaction);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  //Declaring Controllers of TextFields~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  //Method to Pass New Transaction to transaction Function~~~~~~~~~~~~~~~~~~~~~~
  void _addNewTransaction() {

    //Initializing Controllers of TextFields~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    String txTitle = titleController.text;
    double txAmount = double.parse(amountController.text);

    //Validating Data
    if (txTitle.isEmpty || txAmount <= 0) {
      return;
    }

    //Passing Arguments
    widget._addTransaction(txTitle, txAmount);

    //Closing BottomSheet
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
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
            FlatButton(
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
