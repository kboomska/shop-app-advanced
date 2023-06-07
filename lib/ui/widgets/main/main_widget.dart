import 'package:flutter/material.dart';

import 'package:shop_app/theme/app_colors.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarGeoTitle(),
        backgroundColor: AppColors.appBackground,
        elevation: 0,
      ),
      backgroundColor: AppColors.appBackground,
    );
  }
}

class AppBarGeoTitle extends StatelessWidget {
  const AppBarGeoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
          width: 24,
          child: Icon(
            Icons.location_on_outlined,
            color: AppColors.textHeadline,
            size: 18,
          ),
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
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
              '12 Августа, 2023',
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
