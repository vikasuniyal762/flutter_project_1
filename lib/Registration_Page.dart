import 'package:flutter/material.dart';

import 'localizedstrings.dart';

void main() {
  runApp(const MaterialApp(
    home: RegistrationHomePage(),
    debugShowCheckedModeBanner: false,
    title: '',
  )
  );
}
class RegistrationHomePage extends StatefulWidget {
  const RegistrationHomePage({Key? key}) : super(key: key);

  @override
  State<RegistrationHomePage> createState() => _RegistrationHomePageState();
}

class _RegistrationHomePageState extends State<RegistrationHomePage> {
  final _formKey = GlobalKey<FormState>();
 final TextEditingController _emailController=TextEditingController();
 final TextEditingController _passwordController=TextEditingController();
 late TextEditingController _userNameController=TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
 bool _doNotRememberPassword = false;
  bool _isEmailValid = false;
  bool _isUsernameValid=false;


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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/imglogo.png'),
                      backgroundColor: Colors.white,
                      radius: 100,
                      //child: Text('its me'),
                    ),
                    const SizedBox(height: 10,),
                    const SizedBox(
                      height: 20,
                      width: 250,
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        ),
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "User Name",
                          prefixIcon: Icon(Icons.account_circle, color: AppStrings.themecolor1),

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the  User name';
                          }
                          // if (!isValidUserName(value)) {
                          //   return 'Please enter a valid username (alphabets only)';
                          // }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   setState(() {
                        //     _isUsernameValid = _formKey.currentState!.validate();
                        //   });
                        //   if (_isUsernameValid) {
                        //     _usernameFocusNode.unfocus(); //for hide the keyboard
                        //     FocusScope.of(context).requestFocus(_emailFocusNode);//for focus on next field
                        //   }
                        // },
                      ),
                    ),

                    //EMAIL FIELD

                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                       enabled: _isUsernameValid,
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


                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

}
bool isValidEmail(String value) {
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$',
  );
  return emailRegex.hasMatch(value);
}

bool isValidUserName (String value){
  final RegExp usenmRegex= RegExp(r'^[a-zA-Z ]{1,20}$');
  return usenmRegex.hasMatch(value);

}


