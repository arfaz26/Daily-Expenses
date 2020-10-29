import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  final amountController = TextEditingController();
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                contentPadding: EdgeInsets.only(left: 10),
              ),
              controller: titleController,
              // onChanged: (value) => nameInput = value,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                contentPadding: EdgeInsets.only(left: 10),
              ),
              keyboardType: TextInputType.number,
              controller: amountController,
              // onChanged: (value) => nameInput = value,
            ),
            FlatButton(
              onPressed: () {
                addTransaction(
                  titleController.text,
                  double.parse(amountController.text),
                );
              },
              child: Text("Add Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
