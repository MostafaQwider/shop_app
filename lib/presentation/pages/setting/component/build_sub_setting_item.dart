import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildSubSettingItem extends StatelessWidget {
  const BuildSubSettingItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  final String title;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          margin: EdgeInsets.zero,
          surfaceTintColor: Theme.of(context).cardColor,

          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                SvgPicture.asset(icon),
                const SizedBox(width: 10),
                Text(title,
                    style:Theme.of(context).textTheme.bodyMedium),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
