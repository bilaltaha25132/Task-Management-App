import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/features/on_boarding/views/on_boarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/authentication/app/user_provider.dart';
import 'features/todo/views/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(392.7, 856.7),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Todo App',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
            useMaterial3: true,
            scaffoldBackgroundColor: Colours.darkBackground,
          ),
          home: ref.watch(userProvider).when(
            data: (userExists) {
              if (userExists) return const HomeScreen();
              return OnBoardingScreen();
            },
            error: (error, stackTrace) {
              debugPrint('ERROR: $error');
              debugPrint(stackTrace.toString());
              return OnBoardingScreen();
            },
            loading: () {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ); // Scaffold
            },
          ),
        );
      },
    );
  }
}
