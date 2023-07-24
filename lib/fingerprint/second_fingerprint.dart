import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintAuthScreen extends StatefulWidget {
  const FingerprintAuthScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FingerprintAuthScreenState createState() => _FingerprintAuthScreenState();
}

class _FingerprintAuthScreenState extends State<FingerprintAuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  String msg = "You are not authorized.";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      alignment: Alignment.center,
      child: Column(
        children: [
          Center(
            child: Text(msg),
          ),
          const Divider(),
          // ElevatedButton(
          //   onPressed: () async {
          //     try {
          //       bool hasBiometrics = await auth.canCheckBiometrics;

          //       if (hasBiometrics) {
          //         List<BiometricType> availableBiometrics =
          //             await auth.getAvailableBiometrics();
          //         if (Platform.isIOS) {
          //           if (availableBiometrics.contains(BiometricType.face)) {
          //             bool pass = await auth.authenticate(
          //               localizedReason: 'Authenticate with fingerprint',
          //             );

          //             if (pass) {
          //               msg = "You are Authenticated.";
          //               setState(() {});
          //             }
          //           }
          //         } else {
          //           if (availableBiometrics
          //               .contains(BiometricType.fingerprint)) {
          //             bool pass = await auth.authenticate(
          //               localizedReason: 'Authenticate with fingerprint/face',
          //             );
          //             if (pass) {
          //               msg = "You are Authenticated.";
          //               setState(() {});
          //             }
          //           }
          //         }
          //       } else {
          //         msg = "You are not allowed to access biometrics.";
          //       }
          //     } on PlatformException catch (e) {
          //       print(e);
          //       msg = "Error while opening fingerprint/face scanner";
          //     }
          //   },
          //   child: Text("Authenticate with Fingerprint/Face Scan"),
          // ),
          ElevatedButton(
            onPressed: () async {
              try {
                bool pass = await auth.authenticate(
                  localizedReason: 'Authenticate with pattern/pin/passcode',
                );
                if (pass) {
                  msg = "You are Authenticated.";
                  setState(() {});
                }
              } on PlatformException catch (e) {
                print(e);
                msg = "Error while opening fingerprint/face scanner";
              }
            },
            child: const Text("Authenticate with Pin/Passcode/Pattern Scan"),
          ),
        ],
      ),
    );
  }
}
