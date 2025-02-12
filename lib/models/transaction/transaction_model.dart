import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_money_mgn/models/category/category_models.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModels {

  @HiveField(0)
  String? id;
  @HiveField(1)
  final String purpose;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final CategoryType type;
  @HiveField(5)
  final CategoryModels category;

  TransactionModels({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  }){
    id = DateTime.now().toString();
  }
}
