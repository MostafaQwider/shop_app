import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/assets_manager.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.email, required this.name});
  final String email;
  final String name;
  @override
  Widget build(BuildContext context) {

    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(AssetsManager.profile,width: 50,height: 50,),
          const SizedBox(height: 10),
          Text(
            name, // يمكن استبداله بـ controller.userName.value
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            email, // يمكن استبداله بـ controller.userEmail.value
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],

    );
  }
}
