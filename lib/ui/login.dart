import 'package:flutter/material.dart';
import 'beranda.dart';
import '../service/login_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login Admin",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 50),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          _usernameTextField(),
                          SizedBox(height: 20),
                          _passwordTextField(),
                          SizedBox(height: 40),
                          _tombolLogin(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Username"),
      controller: _usernameCtrl,
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Password"),
      obscureText: true,
      controller: _passwordCtrl,
    );
  }

  Widget _tombolLogin() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text("Login"),
        onPressed: () async {
          String username = _usernameCtrl.text;
          String password = _passwordCtrl.text;
          bool isSuccess = await LoginService().login(username, password);

          if (isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Beranda()),
            );
          } else {
            AlertDialog alertDialog = AlertDialog(
              content: const Text("Username atau Password Tidak Valid"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                )
              ],
            );
            showDialog(
              context: context,
              builder: (context) => alertDialog,
            );
          }
        },
      ),
    );
  }
}
