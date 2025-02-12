import 'package:flutter/material.dart';
import 'package:hive_money_mgn/db/transaction/transaction_db.dart';
import 'package:hive_money_mgn/models/category/category_models.dart';
import 'package:hive_money_mgn/models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refreshTransactionUI();

    return ValueListenableBuilder(
      valueListenable: TransactionDb().TransactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModels> newvalue, Widget? _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final transaction = newvalue[index];

            return Dismissible(
              key: ValueKey(transaction.id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                // Remove from database and update UI
                TransactionDb().deleteTransaction(transaction.id!);
              },
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: transaction.type == CategoryType.income
                        ? Colors.green
                        : Colors.red,
                    radius: 50,
                    child: Text(
                      '${transaction.date.day}\n${transaction.date.month}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  title: Text(transaction.amount.toString()),
                  subtitle: Text(
                    transaction.purpose,
                    style: TextStyle(
                        color: transaction.type == CategoryType.income
                            ? Colors.green
                            : Colors.red),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, ind) => const SizedBox(height: 10),
          itemCount: newvalue.length,
        );
      },
    );
  }
}
