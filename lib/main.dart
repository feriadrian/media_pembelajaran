import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_projeck/pages/home_page/component/list_cover_gridview.dart';
import 'package:mini_projeck/pages/home_page/home_page.dart';
import 'package:mini_projeck/pages/login_page/login_page.dart';
import 'package:mini_projeck/pages/spalsh_page/splash_page.dart';
import 'package:mini_projeck/services/auth_services.dart';
import 'package:mini_projeck/provider/provider.dart';
import 'package:mini_projeck/utils/loading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBLoyyGLhfyw2K-kNdIcVluwjDy5mXvIVE", //"apiKey",
        appId: "937130815857", //"appId",
        messagingSenderId: "937130815857", //"messagingSenderId",
        projectId: "mini-project-26683"), //"projectId"),
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthSerices(),
        ),
        ChangeNotifierProvider(
          create: (context) => MateriProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        home: SplashPage(),
      ),
    );
  }
}
