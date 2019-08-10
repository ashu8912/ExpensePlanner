import "dart:io";
import 'package:flutter/cupertino.dart';
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
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
  List<Widget> _buildLandscapeContent(var appBar,Widget txListWidget){
       return [Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                Text("Show Chart",style: Theme.of(context).textTheme.title,),
                Switch.adaptive(onChanged: (value){
                  setState(() {
                    _showChart=value;
                  });
                },
                activeColor: Theme.of(context).accentColor,
                value:_showChart)
              ],),_showChart?Container(width: double.infinity,
               height:(MediaQuery.of(context).size.height - appBar.preferredSize.height-MediaQuery.of(context).padding.top) *0.7,  
               child: Chart(_recentTransactions)):
                  txListWidget];
  }
  List<Widget> _buildPortraitContent(var appBar,Widget txListWidget){
      return   [Container(width: double.infinity,
               height:(MediaQuery.of(context).size.height - appBar.preferredSize.height-MediaQuery.of(context).padding.top) *0.4,  
               child: Chart(_recentTransactions)),txListWidget];
  }
  Widget _buildAppBar(){
      return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
  }
  @override
   void initState(){
     WidgetsBinding.instance.addObserver(this);
     super.initState();
   }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  bool _showChart=false;
  @override
  Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    final PreferredSizeWidget appBar=_buildAppBar();
    final txListWidget=Container(
                height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.55,
                child: TransactionList(_userTransactions,_deleteTransaction));
    final pageBody=SafeArea(child:SingleChildScrollView(
          child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape) ..._buildLandscapeContent(appBar,txListWidget),
              if(!isLandscape) ..._buildPortraitContent(appBar,txListWidget),
              
            ],
          ),
        ));
    return Platform.isIOS?CupertinoPageScaffold(
      child:pageBody,
      navigationBar: appBar,
    ):Scaffold(
        appBar: appBar,
        body:pageBody,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:Platform.isIOS?Container(): FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ));
  }
}
