import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final amountController = TextEditingController();
  final titleController = TextEditingController();
  DateTime _selectedDate;

  void submitForm() {
    if (amountController.text.isEmpty) {
      return;
    }
    final String titleValue = titleController.text;
    final double amountValue = double.parse(amountController.text);
    if (titleValue.isEmpty || amountValue <= 0 || _selectedDate == null) {
      return;
    } else {
      widget.addTransaction(
        titleValue,
        amountValue,
        _selectedDate,
      );
      Navigator.of(context).pop();
    }
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  // contentPadding: EdgeInsets.only(left: 10),
                ),
                controller: titleController,
                onSubmitted: (_) => submitForm(),
                // onChanged: (value) => nameInput = value,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  // contentPadding: EdgeInsets.only(left: 10),
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitForm(),
                controller: amountController,

                // onChanged: (value) => nameInput = value,
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Choosen!'
                            : 'Date picked: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    FlatButton(
                      onPressed: _datePicker,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitForm,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button.color),
                ),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
