import 'package:flutter/material.dart';

import 'package:shop_app/resources/resources.dart';
import 'package:shop_app/theme/app_colors.dart';

class ShoppingCartScreenWidget extends StatelessWidget {
  const ShoppingCartScreenWidget({super.key});

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
    // final date = context.select(
    //   (MainScreenViewModel model) => model.date,
    // );

    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Icon(
            Icons.location_on_outlined,
            color: AppColors.appBarIcon,
            size: 18,
          ),
        ),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Санкт-Петербург',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.textHeadline,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                height: 1.2,
              ),
            ),
            SizedBox(height: 4),
            Text(
              // date,
              'Сегодня',
              style: TextStyle(
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
