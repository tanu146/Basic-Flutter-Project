import 'package:flutter/material.dart';
import 'package:PoetryPalette/login_page.dart';
import 'package:PoetryPalette/pages/poemScreen.dart';
import 'package:PoetryPalette/pages/saved_item_detail_screen.dart';
import 'package:PoetryPalette/pages/user_profile_screen.dart';
import 'package:PoetryPalette/save_file.dart';
import 'package:provider/provider.dart';
import 'package:PoetryPalette/styles/app_colors.dart';
import 'package:PoetryPalette/pages/saved_item_detail_screen.dart';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SavedItemsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poem & Image App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/savedItems': (context) => SavedItemsScreen(),
        '/main': (context) => PoemScreen(),
        '/userProfile': (context) => UserProfileScreen(),
        '/savedItemDetails': (context) => SavedItemDetailsScreen(),
      },
    );
  }
}

