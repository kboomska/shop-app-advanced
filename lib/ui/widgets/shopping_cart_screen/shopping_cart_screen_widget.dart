import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shop_app/ui/widgets/shopping_cart_screen/shopping_cart_screen_view_model.dart';
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
      body: const _ShoppingCartListWidget(),
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

class _ShoppingCartListWidget extends StatelessWidget {
  const _ShoppingCartListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
