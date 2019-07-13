import "package:flutter/material.dart";

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);
  @override
  Widget build(BuildContext context) {
    TextEditingController amountInputController = TextEditingController();
    TextEditingController titleInputController = TextEditingController();
    return Card(
        child: Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        TextField(
          decoration: InputDecoration(labelText: 'Title'),
          controller: titleInputController,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Amount'),
          controller: amountInputController,
        ),
        FlatButton(
            textColor: Colors.purple,
            child: Text("Add Transaction"),
            onPressed: () => addNewTransaction(titleInputController.text,
                double.parse(amountInputController.text)))
      ]),
      padding: EdgeInsets.all(10),
    ));
  }
}
