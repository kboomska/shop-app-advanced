import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shop_app/ui/widgets/shopping_cart_screen/shopping_cart_screen_view_model.dart';
import 'package:shop_app/domain/data_providers/shopping_cart_data_provider.dart';
import 'package:shop_app/theme/app_button_style.dart';
import 'package:shop_app/resources/resources.dart';
import 'package:shop_app/theme/app_colors.dart';

class ShoppingCartScreenWidget extends StatefulWidget {
  const ShoppingCartScreenWidget({super.key});

  @override
  State<ShoppingCartScreenWidget> createState() =>
      _ShoppingCartScreenWidgetState();
}

class _ShoppingCartScreenWidgetState extends State<ShoppingCartScreenWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    Future.microtask(
      () => context.read<ShoppingCartScreenViewModel>().setup(locale),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _ShoppingCartScreenTitle(),
        actions: const [_ShoppingCartScreenProfile()],
        elevation: 0,
      ),
      backgroundColor: AppColors.appBackground,
      body: const _ShoppingCartBodyWidget(),
    );
  }
}

class _ShoppingCartScreenTitle extends StatelessWidget {
  const _ShoppingCartScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final date = context.select(
      (ShoppingCartScreenViewModel model) => model.date,
    );
    final location = context.select(
      (ShoppingCartScreenViewModel model) => model.location,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Image.asset(
            ShopAppIcons.location,
            color: AppColors.appBarIcon,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22,
                child: FittedBox(
                  child: Text(
                    location,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.textHeadline,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      height: 1.2,
                    ),
                  ),
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
        ),
      ],
    );
  }
}

class _ShoppingCartScreenProfile extends StatelessWidget {
  const _ShoppingCartScreenProfile({super.key});

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

class _ShoppingCartBodyWidget extends StatelessWidget {
  const _ShoppingCartBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ShoppingCartListWidget(),
          _ShoppingCartPayButton(),
        ],
      ),
    );
  }
}

class _ShoppingCartPayButton extends StatelessWidget {
  const _ShoppingCartPayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ShoppingCartScreenViewModel>();
    final total = context.select(
      (ShoppingCartScreenViewModel model) => model.total,
    );
    if (total.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: OutlinedButton(
        onPressed: model.pay,
        style: AppButtonStyle.blueButton,
        child: Text(
          total,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.10,
          ),
        ),
      ),
    );
  }
}

class _ShoppingCartListWidget extends StatelessWidget {
  const _ShoppingCartListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount = context.select(
      (ShoppingCartScreenViewModel model) => model.items.length,
    );
    if (itemCount == 0) {
      return const Center(
        child: Text(
          'В корзине пока пусто',
          style: TextStyle(
            color: AppColors.textProductWeight,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.05,
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) => _ShoppingCartItemWidget(index: index),
      ),
    );
  }
}

class _ShoppingCartItemWidget extends StatelessWidget {
  final int index;

  const _ShoppingCartItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ShoppingCartScreenViewModel>();
    final dish = model.items[index];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          _ItemImageWidget(imageUrl: dish.imageUrl),
          _ItemDescriptionWidget(dish: dish),
          const Spacer(),
          _ItemCounterWidget(index: index),
        ],
      ),
    );
  }
}

class _ItemImageWidget extends StatelessWidget {
  final String imageUrl;

  const _ItemImageWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      width: 62,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.dishItemBackground,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _ItemDescriptionWidget extends StatelessWidget {
  final ShoppingCartItem dish;

  const _ItemDescriptionWidget({
    Key? key,
    required this.dish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dish.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textHeadline,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.05,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${dish.price} ₽',
                  style: const TextStyle(
                    color: AppColors.textHeadline,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.05,
                  ),
                ),
                TextSpan(
                  text: ' • ${dish.weight}г',
                  style: const TextStyle(
                    color: AppColors.textProductWeight,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.05,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ItemCounterWidget extends StatelessWidget {
  final int index;

  const _ItemCounterWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ShoppingCartScreenViewModel>();
    final productId = model.items[index].id;
    final int quantity = context.select(
      (ShoppingCartScreenViewModel model) =>
          model.items.length > index ? model.items[index].quantity : 0,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 32,
        minWidth: 99,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.shoppingCartCounterBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => model.onDecreaseQuantity(productId),
                  icon: Image.asset(
                    ShopAppIcons.remove,
                    color: AppColors.appBarIcon,
                  ),
                ),
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  color: AppColors.textHeadline,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.05,
                ),
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => model.onIncreaseQuantity(productId),
                  icon: Image.asset(
                    ShopAppIcons.add,
                    color: AppColors.appBarIcon,
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
