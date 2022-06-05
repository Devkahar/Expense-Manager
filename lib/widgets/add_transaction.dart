import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function clickHandler;

  const AddTransaction({Key? key, required this.clickHandler})
      : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState(clickHandler);
}

class _AddTransactionState extends State<AddTransaction> {
  final Function clickHandler;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _selectdate = DateTime.now();
  _AddTransactionState(this.clickHandler);

  void _presentDatePicker() async {
    final date = await showDatePicker(
        context: context,
        initialDate: _selectdate,
        firstDate: DateTime(2022),
        lastDate: DateTime.now()

    );

    if (date == null) return;
    print(date);
    setState(() {
      _selectdate = date;
    });
  }

  String formatDate() {
    final formattedDate = DateFormat.yMd().format(_selectdate);
    print('formattedDate: $formattedDate');
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Card(
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              // bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title of Expense';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  validator: (value) {
                    if (double.tryParse(value.toString()) == null) {
                      return 'Please Enter valid amount';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      Text(formatDate()),
                      TextButton(
                        onPressed: _presentDatePicker,
                        child: const Text('Choose Date'),
                        style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        clickHandler(titleController.text,
                            double.tryParse(amountController.text) ?? 0.0, _selectdate);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Add Transaction"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
