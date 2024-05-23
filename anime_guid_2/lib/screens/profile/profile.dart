import 'package:anime_guid_2/config/constants/image_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset(AppImagesRoute.appLogo, height: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 200,
                width: 200,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/abuQarqash.jpg'),
                ),
              ),
              // const Spacer(),
              const SizedBox(height: 20),
              const Center(
                child: Text('mustafa qarqash \n mostfakarkah@gmail.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              const SizedBox(height: 90),
              rowInprofile(AppImagesRoute.iconProfile,
                  AppImagesRoute.iconArrowRight, 'Edit Profile'),
              const SizedBox(height: 20),
              rowInprofile(AppImagesRoute.iconProfile,
                  AppImagesRoute.iconArrowRight, 'notification'),
              const SizedBox(height: 20),
              rowInprofile(AppImagesRoute.iconDownload,
                  AppImagesRoute.iconArrowRight, 'Download'),
              const SizedBox(height: 20),
              rowInprofile(AppImagesRoute.iconLanguage,
                  AppImagesRoute.iconArrowRight, 'language'),
              const SizedBox(height: 20),
              rowInprofile(AppImagesRoute.iconHelp,
                  AppImagesRoute.iconArrowRight, 'Help Center'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Row rowInprofile(String startImage, String endImage, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          startImage,
        ),
        const SizedBox(width: 15),
        Text(text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            )),
        const Spacer(),
        SvgPicture.asset(endImage),
      ],
    );
  }
}
