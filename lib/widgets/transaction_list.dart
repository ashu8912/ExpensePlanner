import "package:flutter/material.dart";
import "./transacion_item.dart";
import "../models/transaction.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty
            ? LayoutBuilder(builder:(context,constraints){
              return Column(
                children: <Widget>[
                  Text("No transactions added yet",
                      style: Theme.of(context).textTheme.title),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      height: constraints.maxHeight*0.6,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ))
                ],
              );}): ListView(
                children:transactions.map(
                  (transaction)=>TransactionItem(key:ValueKey(transaction.id),transaction: transaction, deleteTx: deleteTx)).toList()
                
                ));
              
  }
}



// Card(
//                 child: Row(children: [
//               Container(
//                   padding: EdgeInsets.all(10),
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Theme.of(context).primaryColor)),
//                   child: Text(
//                     '\u20B9 ${transactions[index].amount}',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: Theme.of(context).primaryColor),
//                   )),
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Text(
//                   transactions[index].title,
//                   style: Theme.of(context).textTheme.title,
//                 ),
//                 Text(DateFormat("yyyy-MM-dd").format(transactions[index].date),
//                     style: TextStyle(color: Colors.grey))
//               ])
//             ]));
