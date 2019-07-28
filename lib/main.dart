import "dart:io";
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import "./widgets/new_transaction.dart";
import "./widgets/transaction_list.dart";
import "./models/transaction.dart";
import "./widgets/chart.dart";

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   //DeviceOrientation.portraitUp
  // ]);
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
              button:TextStyle(color:Colors.white),           
              title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: "OpenSans", fontSize: 20)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String titleInput;
  String amountInput;
  final List<Transaction> _userTransactions = [
    //   Transaction(
    //       id: "1", title: "New Shoes", amount: 21.5, date: DateTime.now()),
    //   Transaction(
    //       id: "2", title: "Vegetables", amount: 34.1, date: DateTime.now())
    //
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  void _deleteTransaction(String id){
        setState(() {
          _userTransactions.removeWhere((tx){
            return tx.id==id;
          });
        });
  }
  void _addNewTransaction(String title, double amount,DateTime chosenDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }
  bool _showChart=false;
  @override
  Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    final appBar=AppBar(
          title: Text("Expense Planner App"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            )
          ],
        );
    final txListWidget=Container(
                height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
                child: TransactionList(_userTransactions,_deleteTransaction));
    
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape) Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                Text("Show Chart"),
                Switch(onChanged: (value){
                  setState(() {
                    _showChart=value;
                  });
                },value:_showChart)
              ],),
              if(!isLandscape)
                Container(width: double.infinity,
               height:(MediaQuery.of(context).size.height - appBar.preferredSize.height-MediaQuery.of(context).padding.top) *0.4,  
               child: Chart(_recentTransactions)),
              if(!isLandscape)
                  txListWidget,
              if(isLandscape)     
              _showChart?Container(width: double.infinity,
               height:(MediaQuery.of(context).size.height - appBar.preferredSize.height-MediaQuery.of(context).padding.top) *0.7,  
               child: Chart(_recentTransactions)):
                  txListWidget
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:Platform.isIOS?Container(): FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ));
  }
}
