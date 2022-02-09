import 'package:elomia_test/routes.dart';
import 'package:elomia_test/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasOnScreenDialog = false;
  static final navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ElomiaTheme.mainTheme,
      initialRoute: Routes.auth,
      onGenerateRoute: onGenerateRoute,
      // home: AuthScreen(),
      navigatorKey: navKey,
    );
  }

  
  
}

