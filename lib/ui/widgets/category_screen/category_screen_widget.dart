import 'package:flutter/material.dart';

import 'package:shop_app/theme/app_colors.dart';

class CategoryScreenWidget extends StatelessWidget {
  const CategoryScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const _AppBarTitle(),
        iconTheme: const IconThemeData(color: AppColors.appBarIcon),
        elevation: 0,
      ),
      backgroundColor: AppColors.appBackground,
      // body: const _CategoryListWidget(),
    );
  }
}
