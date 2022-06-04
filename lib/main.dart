import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'models/transaction.dart';
import './widgets/add_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple,
        errorColor: Colors.red,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.amber),
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(titleMedium: const TextStyle(
          // color: Colors.purple,
          fontWeight: FontWeight.bold,
          fontSize: 18,

        )),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              )
          )
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> transList = [
    // Transaction(
    //     id: '102', title: "Ice Cream-3", amount: 299, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransaction{
    return transList.where((tx){
      return tx.date.isAfter(
          DateTime.now().subtract(
              const Duration(days: 7)
          )
      );
    }).toList();
  }

  void addTransaction(String title,double amount,DateTime date){
    var uuid = Uuid();
    Transaction newTran = Transaction(id: uuid.v1(), title: title, amount: amount, date: date);
    setState((){
      transList.add(newTran);
    });
  }
  void _startAddNewTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: AddTransaction(clickHandler: addTransaction),
      ),
    );
  }

  void _deleteTransaction(String id){
    setState((){
      transList.removeWhere((tran) => tran.id == id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense manager'),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: ListView(
        children:[
          // AddTransaction(clickHandler: addTransaction),
          Chart(recentTransaction: _recentTransaction),
          TransactionList(transList: transList,deleteTransaction: _deleteTransaction,),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(),
      ),
    );
  }
}
