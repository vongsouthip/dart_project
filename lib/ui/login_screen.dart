import 'package:api_5/ui/api_test.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future<bool> loginFuture;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> loginFunction(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return username == 'admin' && password == '1234';
  }

  void tryLogin() {
    setState(() {
      loginFuture = loginFunction(
        usernameController.text,
        passwordController.text,
      );

      loginFuture.then((success) {
        if (success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ApiTest()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator:
                      (value) => value!.isEmpty ? 'Enter Username' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator:
                      (value) => value!.isEmpty ? 'Enter Password' : null,

                  obscureText: true,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    tryLogin();
                  },
                  child: Text("Login"),
                ),
                SizedBox(height: 20),
                loginFuture == null
                    ? Container()
                    : FutureBuilder(
                      future: loginFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            "Error",
                            style: TextStyle(color: Colors.red),
                          );
                        } else if (snapshot.hasData && snapshot.data == true) {
                          return Text(
                            "Success!",
                            style: TextStyle(color: Colors.green),
                          );
                        } else {
                          return Text(
                            "Username or Password incorrect",
                            style: TextStyle(color: Colors.red),
                          );
                        }
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
