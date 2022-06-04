import 'package:exp_manager/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  const Chart({Key? key, required this.recentTransaction}) : super(key: key);

  List<Map<String,Object>> get groupTransactionValue{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      var sumAmount =0.0;
      for(int i =0;i<recentTransaction.length;i++){
        bool day = recentTransaction[i].date.day == weekDay.day;
        bool month = recentTransaction[i].date.month==weekDay.month;
        bool year = recentTransaction[i].date.year==weekDay.year;
        if(day && month && year){
          sumAmount+=recentTransaction[i].amount;
        }
      }

      return{
        'day': DateFormat.E().format(weekDay),
        'amount': sumAmount,
      };
    }).reversed.toList();
  }

  double get totalSpending{
    return groupTransactionValue.fold(0.0, (sum, item) {
      return (sum + (item['amount'] as double));
    });
  }
  @override
  Widget build(BuildContext context) {
    print(groupTransactionValue);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),

      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            children: groupTransactionValue.map((data){
              return Flexible(
                fit: FlexFit.tight,
                  child: ChartBar(
                      label:(data['day'] as String),
                      spendingAmount: (data['amount'] as double),
                      spendingPtcOfTotal: totalSpending>0? ((data['amount'] as double)/totalSpending):0.0)
              );
            }).toList(),
        ),
      ),
    );
  }
}

