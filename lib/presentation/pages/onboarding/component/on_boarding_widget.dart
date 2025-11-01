import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 4 / 2,
          child: SizedBox(
            height: Get.height * 0.3,
            child: SvgPicture.asset(image),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyLarge?.color, // 🔸 يتغير مع الثيم
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            color: theme.hintColor.withOpacity(0.7), // 🔸 لون خافت يعتمد على الثيم
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
