import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task/movies/presentation/screens/movies_screen.dart';
import 'auth/screens/login_screen.dart';
import 'core/services/cach_helper.dart';
import 'core/services/services_locator.dart';
import 'core/utilis/app_constance.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  await CacheHelper.init();
  userName = CacheHelper.getData('userId');
  Widget widget;
  if (userName != null) {
    widget = MoviesScreen(name: userName!);
  } else {
    widget = const LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: false,
      builder: (__, _) {
        return GetMaterialApp(
          title: 'Hamo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: Colors.grey.shade900),
          home: startWidget,
        );
      },
    );
  }
}
