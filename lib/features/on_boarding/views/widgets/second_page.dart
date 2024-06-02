import 'package:flutter/material.dart';
import 'package:todo_app/features/on_boarding/views/widgets/round_button.dart';
import '../../../../core/common/widgets/white_space.dart';
import '../../../../core/res/image_res.dart';
import '../../../authentication/views/sign_in_screen.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImagesRes.todo),
          const WhiteSpace(height: 50),
          RoundButton(
            text: 'Login with phone',
            onPressed: () {
              // Your onPressed logic here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SignInScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
