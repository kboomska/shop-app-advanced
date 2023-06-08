import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shop_app/ui/widgets/category_screen/category_screen_view_model.dart';
import 'package:shop_app/theme/app_colors.dart';

class CategoryScreenWidget extends StatefulWidget {
  const CategoryScreenWidget({super.key});

  @override
  State<CategoryScreenWidget> createState() => _CategoryScreenWidgetState();
}

class _CategoryScreenWidgetState extends State<CategoryScreenWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CategoryScreenViewModel>().loadDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const _AppBarTitle(),
        iconTheme: const IconThemeData(color: AppColors.appBarIcon),
        elevation: 0,
      ),
      backgroundColor: AppColors.appBackground,
      body: const _DishesGridWidget(),
    );
  }
}

class _DishesGridWidget extends StatelessWidget {
  const _DishesGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dishCount = context.select(
      (CategoryScreenViewModel model) => model.dishes.length,
    );

    return GridView.builder(
      itemCount: dishCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) => _DishItemWidget(index: index),
    );
  }
}

class _DishItemWidget extends StatelessWidget {
  final int index;

  const _DishItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.read<CategoryScreenViewModel>();
    final dish = model.dishes[index];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        // onTap: () => model.onCategoryTap(context, index),
        child: Stack(
          children: [
            Image.network(dish.imageUrl),
            Positioned(
              top: 12,
              left: 16,
              child: ConstrainedBox(
                constraints: BoxConstraints.loose(
                  const Size.fromWidth(191),
                ),
                child: const Text(
                  '',
                  style: TextStyle(
                    color: AppColors.textHeadline,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    height: 1.25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
