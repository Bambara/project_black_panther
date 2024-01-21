import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:json_theme/json_theme.dart';
import 'package:json_theme/json_theme_schemas.dart';

import 'controllers/init_controller.dart';
import 'core/app_export.dart';
import 'firebase_options.dart';

void main() async {
  // runApp(const MyApp());
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SchemaValidator.enabled = false;

  final lightThemeStr = await rootBundle.loadString('assets/theme_data/light.json');
  final lightThemeJson = jsonDecode(lightThemeStr);
  final lightTheme = ThemeDecoder.decodeThemeData(lightThemeJson, validate: true) ?? ThemeData();

  final darkThemeStr = await rootBundle.loadString('assets/theme_data/dark.json');
  final darkThemeJson = jsonDecode(darkThemeStr);
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson, validate: true) ?? ThemeData();

  Log.init(kReleaseMode ? LogMode.live : LogMode.debug);

  await GetStorage.init();

  runApp(MyApp(
    lightTheme: lightTheme,
    darkTheme: darkTheme,
  ));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  MyApp({Key? key, required this.lightTheme, required this.darkTheme}) : super(key: key);

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evenatus Platform ',
      // theme: ThemeData(primaryColor: AppColors.black, dividerTheme: const DividerThemeData(thickness: 1.3, color: Colors.white, indent: 60)),
      // home: const IntroScreen(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      translations: AppLocalization(),
      locale: Get.deviceLocale,
      //for setting localization strings
      fallbackLocale: const Locale('en', 'US'),
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
      /*getPages: [
        GetPage(name: "/", page: () => IntroScreen()),
        //User
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(name: FreeSignupScreen.routeName, page: () => FreeSignupScreen()),
        GetPage(name: PremiumSignupScreen.routeName, page: () => PremiumSignupScreen()),
        GetPage(name: AccountSelectionScreen.routeName, page: () => AccountSelectionScreen()),
        GetPage(name: SignUpSelectionScreen.routeName, page: () => SignUpSelectionScreen(userType: '')),
        //
        GetPage(name: EventsListScreen.routeName, page: () => EventsListScreen()),
        GetPage(name: EventScreen.routeName, page: () => EventScreen(openDrawer: () {})),
        GetPage(name: SoloListScreen.routeName, page: () => const SoloListScreen()),
        GetPage(name: SoloPlayerAddScreen.routeName, page: () => const SoloPlayerAddScreen()),
        GetPage(name: PlayerDrawerScreen.routeName, page: () => const PlayerDrawerScreen()),
        GetPage(name: AdminDrawerScreen.routeName, page: () => const AdminDrawerScreen()),
        GetPage(name: DuoInfoScreen.routeName, page: () => const DuoInfoScreen()),
        GetPage(name: SquadInfoScreen.routeName, page: () => const SquadInfoScreen()),
        GetPage(name: DuoListScreen.routeName, page: () => const DuoListScreen()),
        GetPage(name: SquadListScreen.routeName, page: () => const SquadListScreen()),
        GetPage(name: RefListScreen.routeName, page: () => const RefListScreen()),
        //Organizer
        GetPage(name: OAScreen.routeName, page: () => OAScreen()),
        GetPage(name: OrganizerDrawerScreen.routeName, page: () => OrganizerDrawerScreen()),
        GetPage(name: OrganizerTournamentScreen.routeName, page: () => OrganizerTournamentScreen()),
        GetPage(name: TournamentAddScreen.routeName, page: () => TournamentAddScreen()),
        GetPage(name: TournamentListScreen.routeName, page: () => TournamentListScreen(openDrawer: () {})),
      ],*/
    );
  }
}
