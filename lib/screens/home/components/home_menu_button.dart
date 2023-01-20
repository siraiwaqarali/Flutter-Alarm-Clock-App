import 'package:clockapp/models/menu_info.dart';
import 'package:clockapp/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMenuButton extends StatelessWidget {
  final MenuInfo currentMenuInfo;
  const HomeMenuButton({super.key, required this.currentMenuInfo});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuInfo>(
        builder: (BuildContext context, MenuInfo value, Widget? child) {
      return MaterialButton(
        onPressed: () {
          MenuInfo menuInfo = Provider.of<MenuInfo>(context, listen: false);
          menuInfo.updateMenu(currentMenuInfo);
        },
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(32)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
        color: currentMenuInfo.menuType == value.menuType
            ? AppColors.menuBackgroundColor
            : AppColors.pageBackgroundColor,
        child: Column(
          children: <Widget>[
            Image.asset(
              currentMenuInfo.imageSource!,
              scale: 1.5,
            ),
            const SizedBox(height: 16),
            Text(
              currentMenuInfo.title ?? '',
              style: const TextStyle(
                fontFamily: 'avenir',
                color: AppColors.primaryTextColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    });
  }
}
