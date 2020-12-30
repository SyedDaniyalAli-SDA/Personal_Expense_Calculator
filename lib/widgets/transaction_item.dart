import 'dart:math';

import 'package:expense_calculator/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deletedTransactionFunc;

  const TransactionItem(
      {Key key, this.transaction, this.deletedTransactionFunc})
      : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const randomColorChooser = [
      Colors.purple,
      Colors.black,
      Colors.blue,
      Colors.red
    ];
    _bgColor = randomColorChooser[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                "\$${widget.transaction.amount}",
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: Theme.of(context).textTheme.caption,
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: () =>
                    widget.deletedTransactionFunc(widget.transaction.id))
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  widget.deletedTransactionFunc(widget.transaction.id);
                },
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
