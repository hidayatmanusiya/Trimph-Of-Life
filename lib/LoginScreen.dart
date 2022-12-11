import 'package:flutter/material.dart';
import 'package:triumph_life_ui/Controller/user_cntroller.dart';
import 'package:triumph_life_ui/widgets/common_widgets.dart/error_message_text.dart';

import 'ForgotPasswordScreen.dart';
import 'package:get/get.dart';

import 'common_widgets/button_widget.dart';
import 'common_widgets/text_field.dart';
import 'common_widgets/spaces_widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//          backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffffd600),
          title: Text(
            'LOG IN',
            style: TextStyle(color: Colors.white),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          elevation: 0,
        ),
        body: GetBuilder<UserController>(
          builder: (_) {
            return Form(
              key: _.formKeyLogin,
              child: Container(
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
//
                        textBox(
                          controller: _.loginemailController,
                          hint: 'Email',
                          keyboardtype: TextInputType.emailAddress,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please Enter a Email';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(input)) {
                              return 'Please Enter a Valid Email';
                            }
                          },
                          onSave: (input) {
                            _.userData.email = input;
                          },
                        ),
                        spc20,
                        textBox(
                            texthide: true,
                            hint: 'Password',
                            validator: (input) {
                              if (input.length < 8) {
                                return 'Password Should be  Contain Atleast 8 digit';
                              }
                            },
                            controller: _.loginpasswordController),
                        spc20,
                        errorMessageText(_.errorMessage),
                        if (_.errorMessage != '') spc20,
                        buttonBox(
                            onTap: () {
                              final FormState formState =
                                  _.formKeyLogin.currentState;
                              if (formState.validate()) {
                                print('Form is validate');
                                _.signIn();
                              } else {
                                print('Form is not Validate');
                              }
                            },
                            txt: 'Login'),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push((context),
                                MaterialPageRoute(builder: (context) {
                              return ForgotPasswordScreen();
                            }));
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 125.0, right: 25.0, top: 8.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Color(0xffffd600)),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        )

    );
  }
}
