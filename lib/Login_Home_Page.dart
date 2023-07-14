import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final bool _isEmailValid = false;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff03168a),
                    spreadRadius: 6,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  ///EMAIL  CODE............

                  SizedBox(
                    width: 350,
                      ///EMAIL  UI CODE............
                child:TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Please enter your email address",
                  prefixIcon: Icon(Icons.mail, color: Color(0xff03168a)),
                ),
                  ///EMAIL  VALIDATION  CODE............
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!_isEmailValidFormat(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              )
                  ),

                  ///PASSWORD CODE............
                  SizedBox(
                    ///PASSWORD UI CODE............
                    width: 350,
                    child: TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                     // enabled: _isEmailValid,
                      decoration: InputDecoration(
                        hintText: "Please enter your password",
                        prefixIcon: const Icon(Icons.lock, color: Color(0xff03168a)),
                        enabledBorder: _isEmailValid
                            ? null
                            : const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      ///PASSWORD validation CODE............
                      validator: (value) {
                        if (_isEmailValid) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          // Add additional password validation if needed
                        }
                        return null;
                      },
                    ),
                  ),

///LOGIN BUTTON CODE............
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: SizedBox(
                      width: 200,
                      child: RawMaterialButton(
                        fillColor: const Color(0xFF0069FE),
                        elevation: 0.0,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Form is valid, perform login operation
                            // You can access the email and password using _emailController.text and _passwordController.text respectively
                           // await performLogin();
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
      ),
    );
  }
}

bool _isEmailValidFormat(String value) {
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$',
  );
  return emailRegex.hasMatch(value);
}
