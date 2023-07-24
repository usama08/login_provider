import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lawinhandap/Provider/providerfile.dart';
import 'package:provider/provider.dart';
import 'View/Apis_integrate/loginApis.dart';
import 'View/DetailsAdd/add_details.dart';
import 'View/LoginScreen/forget_password.dart';
import 'View/LoginScreen/login.dart';
import 'View/LoginScreen/signup_screen.dart';
import 'View/MainPage/components/add_Case.dart';
import 'View/MainPage/components/main_screen.dart';
import 'View/MainPage/components/view_case.dart';
import 'fingerprint/fingerprint.dart';
import 'fingerprint/second_fingerprint.dart';
import 'imagepicker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: multiProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signupscren': (context) => const SignupScreen(),
          '/forgetscreen': (context) => const ForgetPasswordScreen(),
          '/dashboard': (context) => const MainScreen(),
          '/addscreen': (context) => const AddCase(),
          '/imagecapture': (context) => const ImagePickerWidget(),
          '/viewscreen': (context) => const ViewCase(),
          '/clintscreen': (context) => const AddCaseDetails(),
          '/loginapis': (context) => const LoginPage(),
          '/fingerprint': (context) => const FingerPrint(),
          '/auth': (context) => const FingerprintAuthScreen(),
        },
      ),
    );
  }
}
