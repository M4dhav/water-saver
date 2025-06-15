import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/firebase_options.dart';
import 'package:water_saver/widgets/nav_bar.dart';


final sharedPreferencesProvider = Provider<SharedPreferencesAsync>((ref) {
  return SharedPreferencesAsync();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool loggedIn = false;
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    loggedIn = true;
  }
  runApp(MainApp(
    loggedIn: loggedIn,
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({
    super.key,
    required this.loggedIn,
  });
  final bool loggedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Water Saver',
          // home: loggedIn ? const HomeScreen() : const SignUpScreen(),
          home: BottomNavBar(),
        );
      }),
    );
  }
}
