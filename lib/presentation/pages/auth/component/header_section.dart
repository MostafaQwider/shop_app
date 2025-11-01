import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/assets_manager.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.height, required this.title});
  final double height;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: SvgPicture.asset(AssetsManager.appIcon),
        ),
         SizedBox(height: height),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
