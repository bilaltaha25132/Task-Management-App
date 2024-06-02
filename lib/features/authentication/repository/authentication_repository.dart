import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/features/todo/views/home_screen.dart';

import '../../../core/helper/db_helper.dart';
import '../../../core/utils/core_utils.dart';
import '../views/otp_verification_screen.dart';

final authRepoProvider =
    Provider((ref) => AuthenticationRepository(auth: FirebaseAuth.instance));

class AuthenticationRepository {
  const AuthenticationRepository({
    required this.auth,
  });

  final FirebaseAuth auth;

  Future<void> sendOTP({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (exception) {
        CoreUtils.showSnackBar(
          context: context,
          message: '${exception.code}: ${exception.message}',
        );
      },
      codeSent: (verificationId, _) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OTPVerificationScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String otp,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      void showSnack(String message) {
        CoreUtils.showSnackBar(context: context, message: message);
      }

      final userCredential = await auth.signInWithCredential(credential);
      final navigator = Navigator.of(context);

      if (userCredential.user != null) {
        // TODO: Save User Data to the Device
        await DBHelper.createUser(isVerified: true);
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(), // Scaffold
          ), // MaterialPageRoute
          (route) => false,
        );
      } else {
        showSnack('Error Occurred, Failed to Sign up User');
      }
    } on FirebaseException catch (e) {
      // TODO
      CoreUtils.showSnackBar(
        context: context,
        message: '${e.code}: ${e.message}',
      );
    } catch (e) {
      CoreUtils.showSnackBar(
        context: context,
        message: 'Error Occurred, Failed to Sign Up User',
      );
    }
  }
}
