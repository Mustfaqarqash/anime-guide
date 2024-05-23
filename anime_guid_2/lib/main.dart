import 'package:anime_guid_2/config/theme/app_colors.dart';
import 'package:anime_guid_2/screens/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeMode = ref.watch(themeProvider);

    var themeData = ThemeData(
      cardTheme: const CardTheme(
        color: Color(0xff181A20),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.dark1,
          iconTheme: IconThemeData(color: AppColors.white),
          elevation: 0),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: const Color(0xff181A20).withOpacity(0.8),
        unselectedLabelStyle:
            GoogleFonts.urbanist(fontSize: 10, fontWeight: FontWeight.w500),
        selectedLabelStyle:
            GoogleFonts.urbanist(fontSize: 10, fontWeight: FontWeight.w700),
      ),
      scaffoldBackgroundColor: const Color(0xff181A20),
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
    );
    var themeData2 = ThemeData(
      scaffoldBackgroundColor: const Color(0xffFFFFFF),
      brightness: Brightness.light,
      primaryColor: const Color(0xffE21221),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: themeData,
      theme: themeData2,
      home: const BaseScreen(),
    );
  }
}
