import 'package:college_page/screens/auth/login_screen.dart';
import 'package:college_page/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/route/app_route.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      appId: "1:421876097880:web:5d268f6d36786b517e3b2d",
      apiKey: "AIzaSyC9QUUxm7BT9_EMiQDUVtqlcNNw5NFrRv0",
      projectId: "collegepage-52557",
      messagingSenderId: "421876097880",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "College Page...",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // Set themeMode here
      themeMode: ThemeMode.light,
      // initialRoute: AppRouteName.home,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking the authentication state
            return CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data != null) {
            // User is logged in
            return HomeScreen();
          } else {
            // User is not logged in
            return LoginScreen();
          }
        },
      ),
      // home: CollegeDataForm(),
      onGenerateRoute: AppRoute.generate,
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          child,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.resize(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.resize(2460, name: "4K"),
          ],
        );
      },
    );
  }
}
