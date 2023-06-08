import 'package:shop_app/domain/entity/category.dart';

class MainScreenViewModel {
  final _categories = <Category>[];

  List<Category> get categories => List.unmodifiable(_categories);
}
