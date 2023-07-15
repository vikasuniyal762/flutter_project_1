
import 'package:flutter/material.dart';
import 'package:flutter_project_1/localizedstrings.dart';

void main() {
  runApp(const MaterialApp(
    home: RegestrationPage(),
    debugShowCheckedModeBanner: false,
    title: '',
  )
  );
}

class RegestrationPage extends StatefulWidget {
  const RegestrationPage({Key? key}) : super(key: key);

  @override
  State<RegestrationPage> createState() => _RegestrationPageState();
}

class _RegestrationPageState extends State<RegestrationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController= TextEditingController();
  TextEditingController _userNameController= TextEditingController();
  bool _doNotRememberPassword = false;
  bool _isEmailValid = false;
  bool _isUserNameValid=false;
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _userNameFocusNode=FocusNode();


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _userNameFocusNode.dispose();
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
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/imglogo.png'),
                      backgroundColor: Colors.white,
                      radius: 100,
                      //child: Text('its me'),
                    ),
                    const SizedBox(height: 10),

                    ///USER NAME FIELD
                    // SizedBox(
                    //   width: 350,
                    //   child: TextFormField(
                    //     controller: _userNameController,
                    //     focusNode: _userNameFocusNode,
                    //     keyboardType: TextInputType.text,
                    //     decoration: const InputDecoration(
                    //       hintText: "User Name ",
                    //       prefixIcon: Icon(Icons.account_circle, color: AppStrings.themecolor1),
                    //       suffixIcon: Tooltip(triggerMode: TooltipTriggerMode.tap,
                    //       message: '''Username must be between 3 and 20 characters long
                    //                    and can only contain letters, numbers, and
                    //                    underscores.''',
                    //         padding: EdgeInsets.all(10),
                    //         preferBelow: true,
                    //         verticalOffset: 300,
                    //         child: Icon(Icons.info_outline,
                    //         // color: _isUserNameValid ? Colors.grey : Colors.red,
                    //       ),
                    //     ),
                    //     ),
                    //     validator: (value) {
                    //       if (_isUserNameValid) {
                    //         if (value == null || value.isEmpty) {
                    //           return 'Please enter your username';
                    //         }
                    //         // Add additional username validation if needed
                    //       } else {
                    //         return 'Please enter a valid username';
                    //       }
                    //       return null;
                    //     },
                    //     textInputAction: TextInputAction.next,
                    //     onFieldSubmitted: (_) {
                    //       setState(() {
                    //         _isUserNameValid = _formKey.currentState!.validate();
                    //       });
                    //       if (_isUserNameValid) {
                    //         _userNameFocusNode.unfocus(); //for hide the keyboard
                    //         FocusScope.of(context).requestFocus(_emailFocusNode); //for focus on next field
                    //       }
                    //     },
                    //   ),
                    // ),

                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: _userNameController,
                        focusNode: _userNameFocusNode,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "User Name",
                          prefixIcon: Icon(Icons.account_circle, color: AppStrings.themecolor1),
                          suffixIcon: Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            message: '''Username must be between 3 and 20 characters long 
                     and can only contain letters, numbers, and 
                     underscores.''',
                            padding: EdgeInsets.all(10),
                            preferBelow: true,
                            verticalOffset: 300,
                            child: Icon(Icons.info_outline),
                          ),
                        ),
                        validator: (value) {
                          if (_isUserNameValid) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            // Add additional username validation if needed
                          } else {
                            return 'Please enter a valid username';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          setState(() {
                            _isUserNameValid = _formKey.currentState!.validate();
                          });
                          if (_isUserNameValid) {
                            _userNameFocusNode.unfocus(); //for hide the keyboard
                            FocusScope.of(context).requestFocus(_emailFocusNode); //for focus on next field
                          }
                        },
                      ),
                    ),
                    ///EMAIL FIELD
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                       obscureText: true,
                        enabled: _isUserNameValid,
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
                          if (_isEmailValid && _isUserNameValid ) {
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

                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enabled: _isEmailValid,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
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

bool isUserNameValid(String input) {
  final RegExp userRegex = RegExp(r'^[a-zA-Z0-9]+$');
  return userRegex.hasMatch(input);
}


