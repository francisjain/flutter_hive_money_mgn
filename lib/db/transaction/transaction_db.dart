import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_money_mgn/models/transaction/transaction_model.dart';

const TRANSACTIONDB = "transaction_db";

abstract class TransactionDbFunction {
  Future<void> addTransaction(TransactionModels value);
  Future<void> deleteTransaction(String value);
  Future<List<TransactionModels>> getTransactions();
}

class TransactionDb implements TransactionDbFunction {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() => instance;

  ValueNotifier<List<TransactionModels>> TransactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModels value) async{
    final _transactionDb = Hive.box<TransactionModels>(TRANSACTIONDB);
    await _transactionDb.put(value.id, value);
    refreshTransactionUI();
  }

  Future<void> refreshTransactionUI() async {
    final _list = await getTransactions();
    _list.sort((a, b) => b.date.compareTo(a.date));
    TransactionListNotifier.value.clear();
    TransactionListNotifier.value.addAll(_list);
    TransactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModels>> getTransactions() async {
    final _transactiondb = await Hive.openBox<TransactionModels>(TRANSACTIONDB);
    return _transactiondb.values.toList();
  }
  
  @override
  Future<void> deleteTransaction(String value) async{
    final _transactiondb = Hive.box<TransactionModels>(TRANSACTIONDB);
    await _transactiondb.delete(value);
    refreshTransactionUI();
  }
}
