import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/auth/auth_service.dart';
import 'package:pokedex/screen/app_router.dart';
import 'package:pokedex/screen/login_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (context) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: ((context) => context.read<AuthService>().user),
            initialData: null),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: GoogleFonts.roboto().fontFamily),
        home: const AuthRouter(),
      ),
    );
  }
}

class AuthRouter extends StatelessWidget {
  const AuthRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const AppRouter();
    }

    return const LoginScreen();
  }
}
