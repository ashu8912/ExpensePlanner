import "package:flutter/material.dart";
import "package:intl/intl.dart";
class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _amountInputController = TextEditingController();

  final TextEditingController _titleInputController = TextEditingController();
    DateTime _selectedDate;
  void submitHandler(){
    if(_titleInputController.text.isEmpty || _amountInputController.text.isEmpty || _selectedDate==null)
    {
      return;
    }
    String title=_titleInputController.text;
   
    double amount=double.parse(_amountInputController.text);  
   
    /* context and widget special property that a class 
    that has extended state gets 
    */
    widget.addNewTransaction(title,amount,_selectedDate);
    Navigator.of(context).pop();
  }
   void _presentDatePicker(){
     showDatePicker(context:context,initialDate: DateTime.now(),
     firstDate: DateTime(2019),
     lastDate: DateTime.now()).then((pickedDate){
           if(pickedDate==null)
           {
             return;
           }
        print(pickedDate);   
        setState(() {
          _selectedDate=pickedDate;
        }); 
     });
   }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
          child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleInputController,
            onSubmitted: (_)=>submitHandler(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountInputController,
            keyboardType: TextInputType.number,
            onSubmitted: (_)=>submitHandler(),
          ),
          Row(children: <Widget>[
            Expanded(
              child: Text(_selectedDate==null?"No Date Chosen":
              'Picked Date ${DateFormat.yMd().format(_selectedDate)}'),
            ),
            FlatButton(textColor: Theme.of(context).primaryColor,child:Text('Choose Date',
            style:TextStyle(
              fontWeight: FontWeight.bold
            )),onPressed: _presentDatePicker,)
          ],),
          RaisedButton(
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
              child: Text("Add Transaction"),
              onPressed: () => submitHandler())
        ]),
        padding: EdgeInsets.only(top:10,right:10,left:10,bottom:MediaQuery.of(context).viewInsets.bottom + 10),
      )),
    );
  }
}
