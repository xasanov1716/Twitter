import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/cubits/auth/auth_cubit.dart';
import 'package:twitter/presentation/app_routes.dart';
import 'package:twitter/presentation/tab/articles/articles_screen.dart';
import 'package:twitter/presentation/tab/website/website_screen.dart';
import 'package:twitter/utils/colors/app_colors.dart';

import 'profile/profile_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      WebsiteScreen(),
      ArticleScreen(),
      ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        child: IndexedStack(
          index: currentIndex,children: screens,
        ),
        listener: (context, state) {
          if (state is AuthUnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.c_0C1A30,
        unselectedItemColor: AppColors.passiveTextColor,
        selectedItemColor: AppColors.c_3A9B7A,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "WebSite"),
          BottomNavigationBarItem(icon: Icon(Icons.web), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
