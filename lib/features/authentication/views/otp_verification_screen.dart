import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/res/image_res.dart';
import 'package:todo_app/features/authentication/controllers/authentication_controller.dart';

import '../../../core/utils/core_utils.dart';

class OTPVerificationScreen extends ConsumerWidget {
  const OTPVerificationScreen({required this.verificationId, super.key});

  final String verificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImagesRes.todo),
              const WhiteSpace(height: 26),
              Pinput(
                length: 6,
                onCompleted: (pin) async {
                  final navigator = Navigator.of(context);
                  CoreUtils.showLoader(context);
                  // TODO: Verify OTP: Send OTP to Firebase for verification
                  await ref.read(authControllerProvider).verifyOTP(
                        context: context,
                        verificationId: verificationId,
                        otp: pin,
                      );
                },
                defaultPinTheme: PinTheme(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colours.light,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
