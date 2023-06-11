import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shop_app/ui/widgets/product_screen/product_screen_view_model.dart';
import 'package:shop_app/theme/app_button_style.dart';
import 'package:shop_app/theme/app_colors.dart';

class ProductScreenWidget extends StatelessWidget {
  const ProductScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: AppColors.appBackground,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ProductImageWidget(),
            _ProductDescriptionWidget(),
            _ProductAddToCartButton(),
          ],
        ),
      ),
    );
  }
}

class _ProductImageWidget extends StatelessWidget {
  const _ProductImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dish = context.read<ProductScreenViewModel>().dish;

    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.dishItemBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 56,
              vertical: 14,
            ),
            child: Image.network(
              dish.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const _ProductImageActionsWidget(),
      ],
    );
  }
}

class _ProductImageActionsWidget extends StatelessWidget {
  const _ProductImageActionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 8,
      top: 8,
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.appBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_outlined),
                // iconSize: 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 40,
            width: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.appBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
                // iconSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDescriptionWidget extends StatelessWidget {
  const _ProductDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dish = context.read<ProductScreenViewModel>().dish;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            dish.name,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: AppColors.textHeadline,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1.05,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: RichText(
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            dish.description,
            maxLines: 4,
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              color: AppColors.textProductDescription,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.10,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductAddToCartButton extends StatelessWidget {
  const _ProductAddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProductScreenViewModel>();

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: OutlinedButton(
        onPressed: model.addToCart,
        style: AppButtonStyle.blueButton,
        child: const Text(
          'Добавить в корзину',
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
