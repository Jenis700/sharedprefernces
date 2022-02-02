import 'package:flutter/material.dart';
import 'package:my_login_app/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingUpScreen extends StatefulWidget {
  SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  late SharedPreferences loginsetdata;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    loginsetdata = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 150),

// Email..............................................................................

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your email";
                    } else if (!value
                        .contains(RegExp("^[a-zA-Z0-9]+@+\.[a-zA-Z]"))) {
                      return "Enter valid email";
                    }
                  },
                  decoration: buildInputDecoration(
                    hint: "email",
                    icon: Icons.email,
                    lable: 'Enter your email',
                  ),
                ),
                SizedBox(height: 15),

// password..............................................................................

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your password";
                    } else if (value.length < 4) {
                      return "Enter Minimum 8 character";
                    }
                  },
                  decoration: buildInputDecoration(
                    hint: "Password",
                    lable: "Enter your password",
                    icon: Icons.lock,
                  ),
                ),
                SizedBox(height: 15),

// Phone..............................................................................

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your Phone Number";
                    } else if (value.length < 10) {
                      return "Enter valid Phone Number";
                    } else if (value.length > 10) {
                      return "Enter valid Phone Number";
                    }
                  },
                  decoration: buildInputDecoration(
                      hint: "Phone Number",
                      icon: Icons.phone,
                      lable: 'Enter your Phone Number',
                      prefix: "+91 "),
                ),
                SizedBox(height: 15),

// address..............................................................................

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: addressController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your address";
                    }
                  },
                  decoration: buildInputDecoration(
                    hint: "Address",
                    lable: 'Enter your address',
                    help: "Like: Society , landmark, city, state, India",
                    icon: Icons.two_k_plus_outlined,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrange),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 70, vertical: 14),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      performLogin();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Create",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void performLogin() {
    String email = emailController.text;
    String password = passwordController.text;
    String phone = phoneNumberController.text;
    String address = addressController.text;
    loginsetdata.setString("email", email);
    loginsetdata.setString("password", password);
    loginsetdata.setString("phone", phone);
    loginsetdata.setString("address", address);
  }

  InputDecoration buildInputDecoration({
    required String hint,
    required String lable,
    required IconData icon,
    String prefix = "",
    String help = "",
  }) {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      hintText: hint,
      labelText: lable,
      prefixText: prefix,
      helperText: help,
      suffixIcon: Icon(icon),
      contentPadding: EdgeInsets.only(left: 40),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
        borderRadius: BorderRadius.circular(25),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green.shade400),
        borderRadius: BorderRadius.circular(25),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }
}
