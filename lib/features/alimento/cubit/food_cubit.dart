import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/food_item.dart';

class FoodCubit extends Cubit<List<FoodItem>> {
  late final Box<FoodItem> _box;

  FoodCubit() : super([]) {
    _box = Hive.box<FoodItem>('foods');
    emit(_box.values.toList());
  }

  void addFood(FoodItem item) {
    _box.add(item);
    emit(_box.values.toList());
  }

  void removeFood(int index) {
    _box.deleteAt(index);
    emit(_box.values.toList());
  }
}
