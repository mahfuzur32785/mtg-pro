import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtgpro/app/core/values/strings.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mtgpro/app/bindings/app_bindings.dart';
import 'package:mtgpro/app/core/utils/constants.dart';

import 'app/core/values/colors.dart';
import 'app/modules/login/login_screen.dart';
import 'app/modules/splash/splash_screen.dart';
import 'app/routes/pages.dart';
import 'app/routes/routes.dart';

late final SharedPreferences sharedPreferences;
//flutter build apk --release --target-platform=android-arm64
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );

  //................... Push Notification using onesignal ..................
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId(onesignalAppId);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
  });

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // Will be called whenever a notification is opened/button pressed.
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // Will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
  });

  OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // Will be called whenever the subscription changes
    // (ie. user gets registered with OneSignal and gets a user ID)
  });

  OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
    // Will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
  });

  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor appColor = const MaterialColor(
    0xff09764A,
    <int, Color>{
      900: Color(0xffed6b4d),
      800: Color(0xffed6b4d),
      700: Color(0xffed6b4d),
      600: Color(0xffed6b4d),
      500: Color(0xffed6b4d),
      400: Color(0xffed6b4d),
      300: Color(0xffed6b4d),
      200: Color(0xffed6b4d),
      100: Color(0xffed6b4d),
      50: Color(0xffed6b4d),
    },
  );

  // MaterialColor appColor = const MaterialColor(
  //   0xff09764A,
  //   <int, Color>{
  //     900: Color(0xfff85f6a),
  //   },
  // );

  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.white, //
      statusBarIconBrightness: Brightness.dark// status bar color
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routingCallback: (routing) {
        if(routing?.current == Routes.home){
          if (kDebugMode) {
            print(".................. home ................");
          }
        }
      },
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'vcards',
      theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          primarySwatch: appColor,
          hoverColor: appColor,
          primaryColor: appColor,
          textTheme: TextTheme(
            labelLarge: GoogleFonts.inter(),
            bodyLarge: GoogleFonts.inter(),
            bodyMedium: GoogleFonts.notoSans()
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: appColor,
            textTheme: ButtonTextTheme.normal,
            disabledColor: AppColors.ashTextColor,
          ),
          dividerTheme: const DividerThemeData(
            color: ashColor
          ),
          appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.biryani(textStyle: const TextStyle(fontWeight: FontWeight.w500))
          ),
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
        ),
        // inputDecorationTheme: InputDecorationTheme(
        //   isDense: true,
        //   hintStyle: TextStyle(color: grayColor),
        //   labelStyle: TextStyle(color: grayColor, fontSize: 16),
        //   border: OutlineInputBorder(
        //     borderRadius: borderRadius,
        //     borderSide: const BorderSide(color: ashColor),
        //   ),
        //   focusedBorder: OutlineInputBorder(
        //     borderRadius: borderRadius,
        //     borderSide: const BorderSide(color: ashColor),
        //   ),
        //   enabledBorder: OutlineInputBorder(
        //     borderRadius: borderRadius,
        //     borderSide: const BorderSide(color: ashColor),
        //   ),
        //   errorBorder: OutlineInputBorder(
        //       borderRadius: borderRadius,
        //       borderSide: const BorderSide(color: Colors.red)
        //   ),
        //   fillColor: primaryColor,
        //   filled: true,
        //   focusColor: blackColor,
        // ),
      ),
      initialBinding: AppBindings(),
      transitionDuration: const Duration(milliseconds: 300),
      defaultTransition: Transition.cupertino,
      home: const SplashScreen(),
      // home: const LoginScreen(),
      getPages: Pages.pages,
    );
  }
}

// <key>UISupportsDocumentBrowser</key>
// <true/>
//workmanager 0.5.1