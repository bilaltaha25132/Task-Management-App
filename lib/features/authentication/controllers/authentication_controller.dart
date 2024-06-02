import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/authentication_repository.dart';

final authControllerProvider = Provider((ref) {
  return AuthenticationController(ref.watch(authRepoProvider));
});

class AuthenticationController {
  const AuthenticationController(this.repository);

  final AuthenticationRepository repository;

  Future<void> sendOTP({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    return repository.sendOTP(context: context, phoneNumber: phoneNumber);
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String otp,
  }) async =>
      repository.verifyOTP(
        context: context,
        verificationId: verificationId,
        otp: otp,
      );
}
