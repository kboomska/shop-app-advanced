import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/resources/resources.dart';
import 'package:shop_app/theme/app_colors.dart';
import 'package:shop_app/ui/widgets/category_screen/category_screen_view_model.dart';

class CategoryScreenConfiguration {
  final int id;
  final String name;

  CategoryScreenConfiguration({
    required this.id,
    required this.name,
  });
}

class CategoryScreenWidget extends StatefulWidget {
  const CategoryScreenWidget({super.key});

  @override
  State<CategoryScreenWidget> createState() => _CategoryScreenWidgetState();
}

class _CategoryScreenWidgetState extends State<CategoryScreenWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CategoryScreenViewModel>().setDishTag();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const _CategoryScreenTitle(),
        actions: const [_CategoryScreenProfile()],
        iconTheme: const IconThemeData(color: AppColors.appBarIcon),
        elevation: 0,
      ),
      backgroundColor: AppColors.appBackground,
      body: const Column(
        children: [
          _DishFilter(),
          _DishesGridWidget(),
        ],
      ),
    );
  }
}

class _CategoryScreenTitle extends StatelessWidget {
  const _CategoryScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<CategoryScreenViewModel>();
    return Text(
      model.title,
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
        color: AppColors.textHeadline,
        fontWeight: FontWeight.w500,
        fontSize: 18,
        height: 1.2,
      ),
    );
  }
}

class _CategoryScreenProfile extends StatelessWidget {
  const _CategoryScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CircleAvatar(
        radius: 22,
        foregroundImage: AssetImage(ShopAppImages.profileAvatar),
      ),
    );
  }
}

class _DishFilter extends StatelessWidget {
  const _DishFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<CategoryScreenViewModel>();
    final tags = context.select((CategoryScreenViewModel model) => model.tags);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: SizedBox(
        height: 35,
        child: ListView.separated(
          itemCount: tags.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => model.onTagTap(index),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: tags[index].backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Text(
                    tags[index].name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: tags[index].titleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.05,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
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
    var size = MediaQuery.of(context).size;
    final double itemWidth = (size.width / 3) - 16;

    return Expanded(
      child: GridView.builder(
        itemCount: dishCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 14,
          mainAxisExtent: itemWidth + 40,
        ),
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
        itemBuilder: (context, index) => _DishItemWidget(
          index: index,
          itemWidth: itemWidth,
        ),
      ),
    );
  }
}

class _DishItemWidget extends StatelessWidget {
  final double itemWidth;
  final int index;

  const _DishItemWidget(
      {super.key, required this.index, required this.itemWidth});

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
        onTap: () => model.onDishTap(context, index),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: itemWidth,
              width: itemWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.dishItemBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    dish.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                dish.name,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: AppColors.textHeadline,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
