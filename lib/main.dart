import 'package:daily_expenses/widgets/Transaction_lIst.dart';
import 'package:daily_expenses/widgets/chart.dart';
import 'package:daily_expenses/widgets/new_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/Transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(fontFamily: 'ArchitectsDaughter'),
            button: TextStyle(color: Colors.white)),
        primarySwatch: Colors.teal,
        errorColor: Colors.red,
        accentColor: Colors.amber,
        fontFamily: 'ArchitectsDaughter',
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactionList = [
    // Transaction(
    //   name: "socks",
    //   amount: 19.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   name: "vegetables",
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   name: "Shirts",
    //   amount: 200.50,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   name: "Trousers",
    //   amount: 500.9,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransaction {
    return _transactionList.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final txn = Transaction(
      name: title,
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
    );
    setState(() {
      _transactionList.add(txn);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactionList.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  bool _switchChart = false;

  @override
  Widget build(BuildContext context) {
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'AnticSlab',
              fontSize: 22,
            ),
          ),
      title: Text("Daily Expense"),
    );

    final txList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        deleteTransaction: _deleteTransaction,
        transactionList: _transactionList,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                      value: _switchChart,
                      onChanged: (val) {
                        setState(() {
                          _switchChart = val;
                        });
                      }),
                ],
              ),
            if (!_isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransaction),
              ),
            if (!_isLandscape) txList,
            if (_isLandscape)
              _switchChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTransaction),
                    )
                  : txList,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddTransaction(context),
      ),
      // _startAddTransaction(context),
    );
  }
}
