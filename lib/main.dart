import 'package:flutter/material.dart';
import "./transaction.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Transaction> transactions = [
    Transaction(
        id: "1", title: "New Shoes", amount: 21.5, date: DateTime.now()),
    Transaction(
        id: "2", title: "Vegetables", amount: 34.1, date: DateTime.now())
  ];
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
          Column(children: transactions.map((tx){
            return Card(child:Text(tx.title));
          }).toList())
        ],
      ),
    ));
  }
}
