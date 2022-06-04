import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transList;
  final Function deleteTransaction;

  const TransactionList({Key? key, required this.transList,required this.deleteTransaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transList.isEmpty
        ? Column(
            children: [
              Text(
                'Hey Add Some Expenses',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  )),
            ],
          )
        : ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(child : Text('${transList[index].amount.toStringAsFixed(0)}Rs',)),
                    ),
                  ),
                  title: Text(
                    transList[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transList[index].date),
                  ),
                  trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => deleteTransaction(transList[index].id),color: Theme.of(context).errorColor,),
                ),
              );
            },
            itemCount: transList.length,
          );
  }
}
