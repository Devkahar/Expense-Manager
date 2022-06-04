

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPtcOfTotal;
  const ChartBar({Key? key,required this.label, required this.spendingAmount, required this.spendingPtcOfTotal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
            child: FittedBox(child: Text('${spendingAmount.toStringAsFixed(0)} Rs'))
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1 ),
                color: const Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(500),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPtcOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            ),
          ],)
        ),
        const SizedBox(height: 4,),
        Text(label),
      ],
    );
  }
}
