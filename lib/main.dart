import 'package:elomia_test/blocs/bloc_provider.dart';
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
    BlocProvider.instance.processingBloc.processingResult.listen((msg) {
      if (hasOnScreenDialog) {
        final outterContext = navKey.currentState!.overlay!.context;
        Navigator.of(outterContext).canPop();
      }
    });

    BlocProvider.instance.processingBloc.isLoading.listen((status) {
      if (hasOnScreenDialog) {
        final outterContext = navKey.currentState!.overlay!.context;
        Navigator.of(outterContext).canPop();
      }
    });
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

