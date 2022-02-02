import 'package:flutter/material.dart';
import 'package:my_login_app/home_screen.dart';
import 'package:my_login_app/sing_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordlController = TextEditingController();

  late SharedPreferences user_data;

  final FocusNode _email = FocusNode();
  final FocusNode _password = FocusNode();
  final FocusNode _phone = FocusNode();

  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    user_data = await SharedPreferences.getInstance();
    setState(() {
      email = user_data.getString("email");
      password = user_data.getString("password");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 100),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your email";
                    } else if (!value
                        .contains(RegExp("^[a-zA-Z0-9]+@+\.[a-zA-Z]"))) {
                      return "Enter valid email";
                    }
                  },
                  onFieldSubmitted: (text) {
                    FocusScope.of(context).requestFocus(_password);
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    hintText: "Email",
                    contentPadding: const EdgeInsets.only(left: 40),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    labelText: "Enter your email",
                    suffixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  focusNode: _password,
                  controller: passwordlController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your password";
                    } else if (value.length < 4) {
                      return "Enter Minimum 8 character";
                    }
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    hintText: "Password",
                    contentPadding: const EdgeInsets.only(left: 40),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    labelText: "Enter your password",
                    suffixIcon: const Icon(Icons.email),
                  ),
                  onFieldSubmitted: (text) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrange),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 14),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _save();
                    }
                  },
                  child: const Text(
                    "Login",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Create account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        " SingUp",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _save() {
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();

      performLogin();
    }
  }

  void performLogin() {
    if (email != emailController.text || password != passwordlController.text) {
      print("Wrong data");
    } else {
      print("success data");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }
}
