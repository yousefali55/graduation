import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/routing/app_router.dart';
import 'package:graduation/routing/routes.dart';
import 'package:graduation/theming/colors_manager.dart';

class RentingApp extends StatelessWidget {
  final AppRouter appRouter;
  const RentingApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: const Size(345, 812),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
          onGenerateRoute: appRouter.generateRoute,
          theme: ThemeData(scaffoldBackgroundColor: ColorsManager.white),
        ),
      ),
    );
  }
}
