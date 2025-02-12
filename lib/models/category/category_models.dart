import 'package:hive_flutter/hive_flutter.dart';
part 'category_models.g.dart';

@HiveType(typeId: 1)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 0)
class CategoryModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final CategoryType type;

  CategoryModels({
    required this.id,
    required this.name,
    this.isDeleted = false,
    required this.type,
  });

  @override
  String toString() {
    return 'CategoryModels{$id name: $name, isDeleted: $isDeleted, type: $type}';
  }
}
