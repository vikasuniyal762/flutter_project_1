import 'package:flutter/material.dart';

import 'localizedstrings.dart';

void main() {
  runApp(const MaterialApp(
    home: RegistrationPage(),
    debugShowCheckedModeBanner: false,
    title: '',
  ));
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  bool _isEmailValid = false;
  bool _isUserNameValid = false;
  bool _isMobileValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  bool _validateUserName(String value) {
    if (value.isEmpty) {
      return false;
    }
    if (!isUserNameValid(value)) {
      return false;
    }
    return true;
  }

  bool _validateEmail(String value) {
    if (value.isEmpty) {
      return false;
    }
    if (!isValidEmail(value)) {
      return false;
    }
    return true;
  }

  bool _validateMobileNum(String value) {
    if (value.isEmpty) {
      return false;
    }
    if (!isMobileNumValid(value)) {
      return false;
    }
    return true;
  }

  bool _validatePassword(String value) {
    if (value.isEmpty) {
      return false;
    }
    final RegExp passwordRegex =
    RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(value);
  }

  bool _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return false;
    }
    return value == _passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/imglogo.png'),
                  backgroundColor: Colors.white,
                  radius: 100,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "User Name",
                          prefixIcon: Icon(Icons.account_circle,color: AppStrings.themecolor1,),
                        ),
                        validator: (value) {
                          if (!_validateUserName(value ?? "")) {
                            return 'Please enter a valid user name';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _formKey.currentState!.validate();
                          setState(() {
                            _isUserNameValid =
                                _validateUserName(_userNameController.text);
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        enabled: _isUserNameValid,
                        decoration: const InputDecoration(
                          hintText: "Please enter your email address",
                          prefixIcon: Icon(Icons.mail,color: AppStrings.themecolor1,),
                        ),
                        validator: (value) {
                          if (!_validateEmail(value ?? "")) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _formKey.currentState!.validate();
                          setState(() {
                            _isEmailValid = _validateEmail(_emailController.text);
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        enabled: _isEmailValid,
                        decoration: const InputDecoration(
                          hintText: "Please enter your mobile number",
                          prefixIcon: Icon(Icons.phone,color: AppStrings.themecolor1,),
                        ),
                        validator: (value) {
                          if (!_validateMobileNum(value ?? "")) {
                            return 'Please enter a valid mobile number';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _formKey.currentState!.validate();
                          setState(() {
                            _isMobileValid =
                                _validateMobileNum(_mobileController.text);
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enabled: _isMobileValid,
                        decoration: InputDecoration(
                          hintText: "Please enter your password",
                          prefixIcon: const Icon(Icons.lock,color: AppStrings.themecolor1,),
                        ),
                        validator: (value) {
                          if (_isMobileValid) {
                            if (!_validatePassword(value ?? "")) {
                              return 'Please enter a valid password';
                            }
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _formKey.currentState!.validate();
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enabled: _isMobileValid,
                        decoration: InputDecoration(
                          hintText: "Please confirm your password",
                          prefixIcon: const Icon(Icons.lock,color: AppStrings.themecolor1,),
                        ),
                        validator: (value) {
                          if (_isMobileValid) {
                            if (!_validateConfirmPassword(value ?? "")) {
                              return 'Passwords do not match';
                            }
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _formKey.currentState!.validate();
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: RawMaterialButton(
                          fillColor: AppStrings.themecolor1,
                          onPressed: () {
                            _formKey.currentState!.validate();
                            if (_isMobileValid &&
                                _isEmailValid &&
                                _isUserNameValid) {
                              _performRegistration();
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _performRegistration() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Perform the registration operation using the email and password
  }

  bool isValidEmail(String value) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$',
    );
    return emailRegex.hasMatch(value);
  }

  bool isUserNameValid(String input) {
    final RegExp userRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    return userRegex.hasMatch(input);
  }

  bool isMobileNumValid(String value) {
    final RegExp mobileRegex = RegExp(r'^\d{10}$');
    return mobileRegex.hasMatch(value);
  }
}
