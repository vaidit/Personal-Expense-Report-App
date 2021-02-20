import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function delTx;

  TransactionList(this.transactions, this.delTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No Transactions Added Yet!!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/Images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 35,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: FittedBox(
                      child: Text(
                        '\$${transactions[index].amount}',
                      ),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date),
                ),
                trailing: MediaQuery.of(context).size.width > 460
                    ? FlatButton.icon(
                        icon: Icon(Icons.delete),
                        textColor: Theme.of(context).errorColor,
                        onPressed: () => delTx(transactions[index].id),
                        label: Text('Delete'),
                      )
                    : IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => delTx(transactions[index].id),
                      ),
              );
            },
          );
  }
}
