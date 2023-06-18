import 'package:flutter/material.dart';

import 'package:shop_app/ui/widgets/category_screen/category_screen_widget.dart';
import 'package:shop_app/ui/navigation/main_navigation.dart';
import 'package:shop_app/domain/entity/dishes_response.dart';
import 'package:shop_app/domain/entity/dish.dart';
import 'package:shop_app/theme/app_colors.dart';

class DishTag {
  final String name;
  final bool isSelected;
  Color get titleColor => isSelected
      ? AppColors.dishTagTextSelected
      : AppColors.dishTagTextUnselected;

  Color get backgroundColor => isSelected
      ? AppColors.dishTagBackgroundSelected
      : AppColors.dishTagBackgroundUnselected;

  DishTag({
    required this.name,
    required this.isSelected,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DishTag &&
        other.name == name &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return name.hashCode ^ isSelected.hashCode;
  }

  DishTag copyWith({
    String? name,
    bool? isSelected,
  }) {
    return DishTag(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

abstract class CategoryScreenViewModelDishProvider {
  Future<DishesResponse> categoryScreenDishes();
}

class CategoryScreenViewModel extends ChangeNotifier {
  final CategoryScreenViewModelDishProvider dishProvider;
  final CategoryScreenConfiguration configuration;
  final ScreenFactory screenFactory;
  final _dishes = <Dish>[];

  final List<DishTag> _tags = <DishTag>[
    DishTag(name: 'Все меню', isSelected: true),
    DishTag(name: 'Салаты', isSelected: false),
    DishTag(name: 'С рисом', isSelected: false),
    DishTag(name: 'С рыбой', isSelected: false),
  ];

  CategoryScreenViewModel({
    required this.configuration,
    required this.screenFactory,
    required this.dishProvider,
  });

  List<Dish> get dishes => List.unmodifiable(_dishes);
  List<DishTag> get tags => List.unmodifiable(_tags);
  String get title => configuration.name;

  Future<void> setDishTag() async {
    _dishes.clear();
    final index = _tags.indexWhere((tag) => tag.isSelected == true);
    await _loadDishes(_tags[index].name);
  }

  Future<void> _loadDishes(String dishTag) async {
    final dishesResponse = await dishProvider.categoryScreenDishes();
    final filteredDishes = dishesResponse.dishes.where(
      (dish) => dish.tegs.contains(dishTag),
    );
    _dishes.addAll(filteredDishes);

    notifyListeners();
  }

  void onTagTap(int index) {
    for (int i = 0; i < _tags.length; i++) {
      _tags[i] = _tags[i].copyWith(isSelected: i == index);
    }
    notifyListeners();
    setDishTag();
  }

  void onDishTap(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return screenFactory.makeProductScreen(_dishes[index]);
      },
    );
  }
}
