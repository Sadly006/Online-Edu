import 'package:flutter/material.dart';
import 'package:online_edu/src/screen_sizes/screen_size_page.dart';
import 'package:online_edu/src/screens/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late var token;
  final email = TextEditingController();
  final password = TextEditingController();
  bool _obscureText = true;


  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  _validator() async {

    Navigator.pushReplacementNamed(context, '/dashboard');

    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // var response = await authProvider.signInWithEmailAndPassword(email.text.toString(), password.text.toString());

    // if (response == 1) {
    //   Navigator.pushReplacementNamed(context, '/dashboard');
    // } else {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text("Alert!!"),
    //         content: const Text("Email or Password incorrect"),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () => Navigator.pop(context, 'OK'),
    //             child: const Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 50)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 3),
                    child: Text(
                      "HI THERE,",
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 3, 0, 10),
                    child: Text(
                      "WELCOME!!",
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 3, 0, 10),
                    child: Text(
                      "If you are new, ",
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 10),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          onSurface: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: Text(
                          'Sign Up!',
                          style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Center(
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: email,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Center(
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    obscureText: _obscureText,
                    controller: password,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Password",
                      suffixIcon: InkWell(
                        onTap: _toggle,
                        child: Icon(
                          _obscureText
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye_outlined,
                          size: 20.0,
                          color: _obscureText
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: GestureDetector(
                  child: SizedBox(
                    width: displayHeight(context) * 0.45,
                    height: displayHeight(context) * 0.07,
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      child: const Center(
                        child: Text("Sign In"),
                      ),
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Row(
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Text("  Signing-In...")
                        ],
                      ),
                    ));
                    _validator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
