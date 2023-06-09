import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shop_app/ui/widgets/main_screen/main_screen_view_model.dart';
import 'package:shop_app/resources/resources.dart';
import 'package:shop_app/theme/app_colors.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    Future.microtask(
      () => context.read<MainScreenViewModel>().setupLocale(locale),
    );
    context.read<MainScreenViewModel>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _MainScreenTitle(),
        actions: const [_MainScreenProfile()],
        elevation: 0,
      ),
      backgroundColor: AppColors.appBackground,
      body: const _CategoryListWidget(),
    );
  }
}

class _MainScreenTitle extends StatelessWidget {
  const _MainScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final date = context.select(
      (MainScreenViewModel model) => model.date,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
          width: 24,
          child: Icon(
            Icons.location_on_outlined,
            color: AppColors.appBarIcon,
            size: 18,
          ),
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Санкт-Петербург',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.textHeadline,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: const TextStyle(
                color: AppColors.textSubhead,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MainScreenProfile extends StatelessWidget {
  const _MainScreenProfile({super.key});

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

class _CategoryListWidget extends StatelessWidget {
  const _CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCount = context.select(
      (MainScreenViewModel model) => model.categories.length,
    );

    return ListView.separated(
      itemCount: categoryCount,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => _CategoryItemWidget(index: index),
    );
  }
}

class _CategoryItemWidget extends StatelessWidget {
  final int index;

  const _CategoryItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenViewModel>();
    final category = model.categories[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => model.onCategoryTap(context, index),
          child: Stack(
            children: [
              Image.network(category.imageUrl),
              Positioned(
                top: 12,
                left: 16,
                child: ConstrainedBox(
                  constraints: BoxConstraints.loose(
                    const Size.fromWidth(191),
                  ),
                  child: Text(
                    category.name,
                    style: const TextStyle(
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
      ),
    );
  }
}
