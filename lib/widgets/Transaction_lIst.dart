import '../models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  TransactionList({this.transactionList});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      ...transactionList
          .map(
            (e) => Card(
              color: Colors.yellow,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      // e.amount.toString(),
                      '\$${e.amount}',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, top: 10, bottom: 5),
                        child: Text(
                          e.name,
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, top: 5, bottom: 10),
                        child: Text(
                          DateFormat.yMMMd().format(e.date),
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    ]);
  }
}
