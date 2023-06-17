import 'package:e_commerce/src/core/routes/routes.dart';
import 'package:e_commerce/src/core/services/appbindings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ECommerce());
}

class ECommerce extends StatefulWidget {
  const ECommerce({Key? key}) : super(key: key);

  @override
  State<ECommerce> createState() => _ECommerceState();
}

class _ECommerceState extends State<ECommerce> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        canvasColor: const Color(0xFFECF8F9),
        primaryColor: const Color(0xFF7E1717),
        cardColor: const Color(0xFFE55807),
        highlightColor: const Color(0xFF068DA9),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Fredoka',
            color: Color(0xFF004346),
          ),
        ),
        
      ),
      onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
      initialRoute: AppRoutes.splash,
      initialBinding: AppBindings(),
    );
  }
}
