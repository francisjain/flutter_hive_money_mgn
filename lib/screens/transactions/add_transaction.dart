import 'package:flutter/material.dart';
import 'package:hive_money_mgn/db/category/category_db.dart';
import 'package:hive_money_mgn/db/transaction/transaction_db.dart';
import 'package:hive_money_mgn/models/transaction/transaction_model.dart';
import 'package:hive_money_mgn/models/category/category_models.dart';

class AddTransaction extends StatefulWidget {
  static const routeName = 'add-tranction';
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModels? _selectedCategoryModel;
  String? _selectedCategoryId;

  final _purposeController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDb.instance.refreashUI();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            TextFormField(
              controller: _purposeController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Pupose',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 30)),
                  lastDate: DateTime.now(),
                );
                setState(() {
                  _selectedDate = _selectedDateTemp ?? _selectedDate;
                });
              },
              label: Text(_selectedDate == null
                  ? 'Select Date'
                  : _selectedDate.toString()),
              icon: const Icon(Icons.calendar_month_outlined),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = CategoryType.income;
                          _selectedCategoryId = null;
                        });
                      },
                    ),
                    Text('Income')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = CategoryType.expense;
                          _selectedCategoryId = null;
                        });
                      },
                    ),
                    Text('Expance')
                  ],
                ),
              ],
            ),
            DropdownButton<String>(
              hint: Text('Select Category'),
              value: _selectedCategoryId,
              isExpanded: true,
              items: (_selectedCategoryType == CategoryType.income
                      ? CategoryDb().IncomeCategoryListNotifier
                      : CategoryDb().ExpenseCategoryListNotifier)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  child: Text(e.name),
                  value: e.id,
                  onTap: () => _selectedCategoryModel = e,
                );
              }).toList(),
              onChanged: (id) {
                setState(() {
                  _selectedCategoryId = id;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                addTransaction();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purpose = _purposeController.text;
    final _amount = double.tryParse(_amountController.text) ?? 0.0;

    if (_purpose.isEmpty ||
        _amount.isNaN ||
        _selectedDate == null ||
        _selectedCategoryModel == null) {
      return;
    }

    TransactionModels newTransaction = TransactionModels(
      purpose: _purpose,
      amount: _amount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );
    await TransactionDb.instance.addTransaction(newTransaction);
    Navigator.of(context).pop();
    //TransactionDb.instance.refreshTransactionUI();
  }
}
