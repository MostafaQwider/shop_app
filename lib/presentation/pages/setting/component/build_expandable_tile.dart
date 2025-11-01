import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopingo/core/constants/colors.dart';

class BuildExpandableTile extends StatelessWidget {
  const BuildExpandableTile({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onTap,
    required this.children, required this.icon,
  });

  final String title;
  final String icon;
  final bool isExpanded;
  final VoidCallback onTap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).cardColor,
      child: Column(
        children: [
          ListTile(
            leading: SvgPicture.asset(icon,color: Theme.of(context).primaryColor,),
            title: Text(title,
                style: Theme.of(context).textTheme.titleMedium),
            trailing: Icon(
              color: Theme.of(context).primaryColor,
                isExpanded
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_forward,
                size: 20),
            onTap: onTap,
          ),
          if (isExpanded)
            Column(
              children: children,
            ),
        ],
      ),
    );
  }
}
