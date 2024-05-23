import 'dart:ui';

import 'package:anime_guid_2/config/theme/app_colors.dart';
import 'package:anime_guid_2/config/constants/image_route.dart';
import 'package:anime_guid_2/screens/explor/explor_anime.dart';
import 'package:anime_guid_2/screens/home/home_screen.dart';
import 'package:anime_guid_2/screens/my_list/my_list_screen.dart';
import 'package:anime_guid_2/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedBottomNavIndex,
        children: _getLayout(),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(192, 39, 37, 37),
                spreadRadius: 0,
                blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BottomNavigationBar(
              currentIndex: _selectedBottomNavIndex,
              onTap: (value) {
                setState(() {
                  _selectedBottomNavIndex = value;
                });
              },
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.grey500,
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: SvgPicture.asset(AppImagesRoute.iconHome),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: SvgPicture.asset(AppImagesRoute.iconHomeSelected),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: SvgPicture.asset(AppImagesRoute.iconExplore),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child:
                          SvgPicture.asset(AppImagesRoute.iconExploreSelected),
                    ),
                    label: 'Explore'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: SvgPicture.asset(AppImagesRoute.iconMyList),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child:
                          SvgPicture.asset(AppImagesRoute.iconMyListSelected),
                    ),
                    label: 'My List'),
                // BottomNavigationBarItem(
                //     icon: Padding(
                //       padding: const EdgeInsets.only(bottom: 4),
                //       child: SvgPicture.asset(AppImagesRoute.iconDownload),
                //     ),
                //     activeIcon: Padding(
                //       padding: const EdgeInsets.only(bottom: 4),
                //       child:
                //           SvgPicture.asset(AppImagesRoute.iconDownloadSelected),
                //     ),
                //     label: 'Download'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: SvgPicture.asset(AppImagesRoute.iconProfile),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child:
                          SvgPicture.asset(AppImagesRoute.iconProfileSelected),
                    ),
                    label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _getLayout() => [
      const HomeScreen(),
      const SearchAnimePage(),
      const MyListScreen(),
      const ProfilePage()
    ];
