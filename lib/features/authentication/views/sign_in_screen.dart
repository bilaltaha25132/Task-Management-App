import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/core/common/widgets/filled_field.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/res/image_res.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/features/authentication/app/country_code_provider.dart';

import '../../on_boarding/views/widgets/round_button.dart';
import '../controllers/authentication_controller.dart';
import '../repository/authentication_repository.dart';
import 'otp_verification_screen.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final code = ref.watch(countryCodeProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            physics: const PageScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            children: [
              Image.asset(ImagesRes.todo),
              const WhiteSpace(height: 20),
              Text(
                'Please enter your number to get the verification code',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  color: Colours.light,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const WhiteSpace(height: 20),
              FilledField(
                controller: phoneController,
                readOnly: code == null,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 14,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (code) {
                          ref
                              .read(countryCodeProvider.notifier)
                              .changeCountry(code);
                        },
                        countryListTheme: CountryListThemeData(
                          backgroundColor: Colours.darkBackground,
                          bottomSheetHeight:
                              MediaQuery.of(context).size.height * .6,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          textStyle: GoogleFonts.poppins(
                            color: Colours.light,
                          ),
                          searchTextStyle: GoogleFonts.poppins(
                            color: Colours.light,
                          ),
                          inputDecoration: InputDecoration(
                            labelText: 'Search',
                            labelStyle: GoogleFonts.poppins(),
                            hintStyle: GoogleFonts.poppins(
                              color: Colours.lightGrey,
                            ),
                            border: const OutlineInputBorder(),
                            hintText: 'Search',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: code == null ? 10.h : 12.h,
                          left: code == null ? 10.h : 5.h),
                      child: Text(
                        code == null
                            ? 'Pick Country'
                            : '${code.flagEmoji} +${code.phoneCode} ',
                        style: GoogleFonts.poppins(
                          fontSize: code == null ? 13 : 18,
                          color: code == null
                              ? Colours.darkGrey
                              : Colours.darkBackground,
                          fontWeight:
                              code == null ? FontWeight.w500 : FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const WhiteSpace(
                height: 30,
              ),
              RoundButton(
                text: 'Send Code',
                onPressed: () async {
                  if (code == null) return;
                  final navigator = Navigator.of(context);
                  CoreUtils.showLoader(context);
                  await ref.read(authControllerProvider).sendOTP(
                        context: context,
                        phoneNumber:
                            '+${code.phoneCode}${phoneController.text}',
                      );
                  navigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
