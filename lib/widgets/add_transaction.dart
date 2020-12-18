import 'package:flutter/material.dart';

class AddTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final Function _addTransaction;

  AddTransaction(this._addTransaction);


  //Add Transaction Method~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  void _addNewTransaction() {
    String txTitle = titleController.text;
    double txAmount = double.parse(amountController.text);

    if (txTitle.isEmpty ||
        txAmount <= 0) {
      return;
    }
    _addTransaction(txTitle, txAmount);
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
                style: TextStyle(color: Colors.purple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
