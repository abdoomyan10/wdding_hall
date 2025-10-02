import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bottom_nav_cubit.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return CurvedNavigationBar(

          index: currentIndex,
          onTap: (index) => context.read<BottomNavCubit>().changeTab(index),
          backgroundColor: AppColors.scaffoldBackground,
          color: AppColors.error,
          buttonBackgroundColor: AppColors.error,
          items: const [
            // الرئيسية
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //FaIcon(FontAwesomeIcons.house,color:AppColors.curvedNavBarActiveColor ,),
                Icon(CupertinoIcons.home, color: AppColors.curvedNavBarActiveColor),
                SizedBox(height: 2),
                Text(
                  'الرئيسية',
                  style: TextStyle(
                    color: AppColors.curvedNavBarActiveColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // القاعات
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.meeting_room, color: AppColors.curvedNavBarActiveColor),
                SizedBox(height: 2),
                Text(
                  'القاعات',
                  style: TextStyle(
                    color: AppColors.curvedNavBarActiveColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // الحجوزات
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, color: AppColors.curvedNavBarActiveColor),
                SizedBox(height: 2),
                Text(
                  'الحجوزات',
                  style: TextStyle(
                    color: AppColors.curvedNavBarActiveColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // العملاء
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.person_3_fill, color: AppColors.curvedNavBarActiveColor),
                SizedBox(height: 2),
                Text(
                  'العملاء',
                  style: TextStyle(
                    color: AppColors.curvedNavBarActiveColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // الإعدادات
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.settings, color: AppColors.curvedNavBarActiveColor),
                SizedBox(height: 2),
                Text(
                  'الإعدادات',
                  style: TextStyle(
                    color: AppColors.curvedNavBarActiveColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
        );
      },
    );
  }
}