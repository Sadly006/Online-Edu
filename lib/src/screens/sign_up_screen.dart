import 'package:flutter/material.dart';
import 'package:online_edu/src/providers/auth_provider.dart';
import 'package:online_edu/src/screen_sizes/screen_size_page.dart';
import 'package:online_edu/src/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  _validator() async {
    if (password.text.toString() == confirmPassword.text.toString()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var response = await authProvider.signUpWithEmailAndPassword(email.text.toString(), password.text.toString());

    if (response == 1) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Alert!!"),
            content: const Text("Somthing Went Wrong!"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Alert!!"),
            content: Text("Passwords must match"),
          );
        },
      );
    }
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
                    padding: const EdgeInsets.fromLTRB(20, 3, 0, 10),
                    child: Text(
                      "JOIN US NOW!!",
                      style: TextStyle(
                        fontSize: 23,
                        color: Theme.of(context).highlightColor,
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
                      "Already have an account? ",
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
                          onSurface: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Text(
                          'Sign In!',
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
                  child: TextFormField(
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
                    controller: password,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Password',
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Center(
                  child: TextFormField(
                    obscureText: true,
                    controller: confirmPassword,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Confirm Password',
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
                child: SizedBox(
                  width: displayHeight(context) * 0.45,
                  height: displayHeight(context) * 0.07,
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Row(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Text("  Signing-Up...")
                          ],
                        ),
                      ));
                      _validator();
                    },
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      child: const Center(
                        child: Text("Sign Up"),
                      ),
                    ),
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
