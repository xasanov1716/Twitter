import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter/data/models/articles/articles_model.dart';
import 'package:twitter/data/models/user/user_model.dart';
import 'package:twitter/data/models/websites/website_model.dart';
import 'package:twitter/presentation/auth/gmail_confirm/gmail_confirm_screen.dart';
import 'package:twitter/presentation/auth/pages/login_screen.dart';
import 'package:twitter/presentation/auth/pages/register_screen.dart';
import 'package:twitter/presentation/tab/articles/article_detail.dart';
import 'package:twitter/presentation/tab/articles/sub_screen/add_article_screen.dart';
import 'package:twitter/presentation/tab/website/sub_screen/add_website.dart';
import 'package:twitter/presentation/tab/website/website_detail_screen.dart';

import 'splash/splash_screen.dart';
import 'tab/tab_box.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String loginScreen = "/auth_screen";
  static const String registerScreen = "/register_screen";
  static const String tabBox = "/tab_box";
  static const String confirmGmail = "/confirm_gmail";
  static const String articleDetail = "/article_detail";
  static const String addWebSite = "/add_web_site";
  static const String webSiteDetail = "/web_site_detail";
  static const String addArticle = "/article_add";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.addArticle:
        return MaterialPageRoute(builder: (context)=>const AddArticleScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) {
          return LoginScreen();
        });

      case RouteNames.registerScreen:
        return MaterialPageRoute(builder: (context) {
          return RegisterScreen();
        });

        case RouteNames.webSiteDetail:
          return CupertinoPageRoute(builder: (context) {
            return const WebsiteDetailScreen();
          });

      case RouteNames.addWebSite:
        return MaterialPageRoute(builder: (context) {
          return AddWebSiteScreen();
        });

      case RouteNames.articleDetail:
        return MaterialPageRoute(builder: (context) {
          var a = settings.arguments as Map;
          ArticleModel articleModel = a["article"];
          int i = a["index"];
          return ArticleDetailScreen(articleModel:articleModel,index: i, );
        });

      case RouteNames.tabBox:
        return MaterialPageRoute(builder: (context) => TabBox());

      case RouteNames.confirmGmail:
        return MaterialPageRoute(
            builder: (context) => GmailConfirmScreen(
                  userModel: settings.arguments as UserModel,
                ));

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route mavjud emas"),
            ),
          ),
        );
    }
  }
}
