import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shop_app/ui/widgets/shopping_cart_screen/shopping_cart_screen_view_model.dart';
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
      () => context.read<ShoppingCartScreenViewModel>().getDate(locale),
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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: OutlinedButton(
        onPressed: model.pay,
        style: AppButtonStyle.blueButton,
        child: const Text(
          'Оплатить',
          style: TextStyle(
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

    return Expanded(
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) => const _ShoppingCartItemWidget(),
      ),
    );
  }
}

class _ShoppingCartItemWidget extends StatelessWidget {
  const _ShoppingCartItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          _ItemImageWidget(),
          _ItemDescriptionWidget(),
          Spacer(),
          _ItemCounterWidget(),
        ],
      ),
    );
  }
}

class _ItemImageWidget extends StatelessWidget {
  const _ItemImageWidget({
    super.key,
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
        child: const Padding(
          padding: EdgeInsets.all(6),
          // child: Image.network(
          //   dish.imageUrl,
          //   fit: BoxFit.contain,
          // ),
        ),
      ),
    );
  }
}

class _ItemDescriptionWidget extends StatelessWidget {
  const _ItemDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Зеленый салат',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textHeadline,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.05,
            ),
          ),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: '390 ₽',
                  style: TextStyle(
                    color: AppColors.textHeadline,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.05,
                  ),
                ),
                TextSpan(
                  text: ' • 420г',
                  style: TextStyle(
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
  const _ItemCounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    print('-');
                  },
                  icon: const Icon(Icons.remove),
                  // iconSize: 10,
                ),
              ),
              const Text(
                '1',
                style: TextStyle(
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
                  onPressed: () {
                    print('+');
                  },
                  icon: const Icon(Icons.add),
                  // iconSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
