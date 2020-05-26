import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
            ? LayoutBuilder(builder: (ctx,constraints){
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraints.maxHeight*0.6,
                      child: Image.asset(
                        'assets/images/image/ed2.jpg',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            })
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: FittedBox(
                              child: Text(
                                transactions[index].title,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          )),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  return showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                'price: \$${transactions[index].amount.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              Text(
                                                  'ID: ${transactions[index].id}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30,
                                                      color:
                                                          Colors.deepOrange)),
                                              Text(
                                                  'Date: ${DateFormat.yMMMd().format(transactions[index].date)}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30,
                                                    color: Colors.grey,
                                                  )),
                                            ]);
                                      });
                                },
                                child: Text(
                                  'More Information',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.deepOrange),
                                )),
                          ]),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTx(transactions[index].id)),
                    ),
                  );
                },
                itemCount: transactions.length,
              );
  }
}
