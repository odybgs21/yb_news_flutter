import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'presentation/controllers/network_controller.dart';

import 'data/providers/auth_provider.dart';

import 'data/datasources/db_init_stub.dart'
    if (dart.library.io) 'data/datasources/db_init_native.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkController(), permanent: true);

  initializeDb();

  // Initialize AuthProvider and check session
  final authProvider = await Get.putAsync(() => AuthProvider().init());

  runApp(MyApp(isLoggedIn: authProvider.isLoggedIn.value));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: isLoggedIn ? AppPages.initialHome : AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
