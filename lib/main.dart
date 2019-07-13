import 'package:flutter/material.dart';
import "./widgets/user_transaction.dart";
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String titleInput;
  String amountInput;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Expense Planner App"),
      ),
      body: Column(
        children: <Widget>[
          Card(child: Container(width: double.infinity, child: Text("CHART!"))),
          UserTransactions()
        ],
      ),
    ));
  }
}
