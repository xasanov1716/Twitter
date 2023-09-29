import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter/cubits/article_add/article_add_cubit.dart';
import 'package:twitter/cubits/article_fetch/article_fetch_cubit.dart';
import 'package:twitter/cubits/profile/profile_cubit.dart';
import 'package:twitter/cubits/tab/tab_box_cubit.dart';
import 'package:twitter/cubits/user_data/user_data_cubit.dart';
import 'package:twitter/cubits/website_add/website_add_cubit.dart';
import 'package:twitter/cubits/website_fetch/website_fetch_cubit.dart';

import 'package:twitter/data/local/storage_repository.dart';
import 'package:twitter/data/network/secure_api_service.dart';
import 'package:twitter/data/repositories/article_repositories.dart';
import 'package:twitter/data/repositories/profile_repository.dart';
import 'package:twitter/data/repositories/website_repository.dart';
import 'package:twitter/presentation/app_routes.dart';

import 'cubits/auth/auth_cubit.dart';
import 'data/repositories/auth_repository.dart';
import 'service/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  getItSetup();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(),
        ),
        RepositoryProvider(
          create: (context) => WebsiteRepository(),
        ),
        RepositoryProvider(
          create: (context) => ArticleRepositories(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(context.read<AuthRepository>())
          ),
          BlocProvider(
              create: (context) => ArticleAddCubit(
                  context.read<ArticleRepositories>())),
          BlocProvider(create: (context) => TabBoxCubit()),
          BlocProvider(create: (context) => UserDataCubit()),
          BlocProvider(
              create: (context) => ProfileCubit(
                  context.read<ProfileRepository>())),
          BlocProvider(
            create: (context) => WebsiteAddCubit(
                context.read<WebsiteRepository>()),
          ),
          BlocProvider(
            create: (context) => WebsiteFetchCubit(
                context.read<WebsiteRepository>()),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: RouteNames.splashScreen,
        );
      },
    );
  }
}
