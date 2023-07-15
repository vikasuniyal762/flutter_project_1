import 'package:flutter/material.dart';
import 'package:flutter_project_1/localizedstrings.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _doNotRememberPassword = false;
  bool _isEmailValid = false;
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(70),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff03168a),
                  spreadRadius: 4,
                  blurRadius: 30,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
      child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                 backgroundImage: AssetImage('assets/imglogo.png'),
                 backgroundColor: Colors.white,
                 radius: 120,
                  //child: Text('its me'),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Please enter your email address",
                      prefixIcon: Icon(Icons.mail, color: AppStrings.themecolor1),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!isValidEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      setState(() {
                        _isEmailValid = _formKey.currentState!.validate();
                      });
                      if (_isEmailValid) {
                        _emailFocusNode.unfocus(); //for hide the keyboard
                        FocusScope.of(context).requestFocus(_passwordFocusNode);//for focus on next field
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    enabled: _isEmailValid,
                    decoration: InputDecoration(
                      hintText: "Please enter your password",
                      prefixIcon: const Icon(Icons.lock, color: AppStrings.themecolor1),
                      enabledBorder: _isEmailValid
                          ? null
                          : const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (_isEmailValid) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        // Add additional password validation if needed
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      // Hide the keyboard
                      _passwordFocusNode.unfocus();
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: SizedBox(
                    width: 200,
                    child: RawMaterialButton(
                      fillColor: AppStrings.themecolor1,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, perform login operation
                          // You can access the email and password using _emailController.text and _passwordController.text respectively
                          await performLogin();
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
      ),
        ),
      )
    );
  }

  Future<void> performLogin() async {
    // Your login logic goes here
    final email = _emailController.text;
    final password = _passwordController.text;

    // Perform the login operation using the email and password
  }
}

bool isValidEmail(String value) {
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$',
  );
  return emailRegex.hasMatch(value);
}
