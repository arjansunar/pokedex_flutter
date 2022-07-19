import 'package:flutter/material.dart';
import 'package:pokedex/auth/auth_service.dart';
import 'package:pokedex/screen/sign_up.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          const SizedBox(height: 50),
          const Icon(
            Icons.catching_pokemon,
            size: 200,
            color: Colors.redAccent,
          ),
          const Center(
              child: Text(
            'Welcome back!',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 29, 21, 21),
            ),
          )),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<AuthService>(context, listen: false).signInWithEmailAndPassword(_emailController.text.trim(),_passwordController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                  child: const Text('Sign in'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            onPrimary: Colors.blueAccent,
                            primary: Colors.transparent,
                            elevation: 0),
                        child: const Text('Sign up'))
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
