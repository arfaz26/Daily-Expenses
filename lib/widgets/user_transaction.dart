import 'package:flutter/material.dart';
import './Transaction_lIst.dart';
import './new_transaction.dart';
import '../models/Transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transactionList = [
    Transaction(
      name: "socks",
      amount: 19.99,
      date: DateTime.now(),
    ),
    Transaction(
      name: "vegetables",
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      name: "Shirts",
      amount: 200.50,
      date: DateTime.now(),
    ),
    Transaction(
      name: "Trousers",
      amount: 500.9,
      date: DateTime.now(),
    ),
  ];

  void _addTransaction(String title, double amount) {
    final txn = Transaction(name: title, amount: amount, date: DateTime.now());
    setState(() {
      _transactionList.add(txn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addTransaction),
        TransactionList(transactionList: _transactionList),
      ],
    );
  }
}
