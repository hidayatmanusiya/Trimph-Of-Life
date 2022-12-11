import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triumph_life_ui/common_widgets/button_widget.dart';
import 'package:triumph_life_ui/common_widgets/text_field.dart';
import 'package:triumph_life_ui/widgets/common_widgets.dart/error_message_text.dart';

import 'Controller/user_cntroller.dart';
import 'common_widgets/spaces_widgets.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  UserController userController = Get.put(UserController());
// ArsProgressDialog progressDialog;
  @override
  Widget build(BuildContext context) {
    // progressDialog = ArsProgressDialog(context,
    //       blur: 2,
    //       backgroundColor: Color(0x33000000),
    //       animationDuration: Duration(milliseconds: 500));

    //   ArsProgressDialog customProgressDialog = ArsProgressDialog(context,
    //       blur: 2,
    //       backgroundColor: Color(0x33000000),
    //       loadingWidget: Container(
    //         width: 150,
    //         height: 150,
    //         color: Colors.red,
    //         child: CircularProgressIndicator(),
    //       ));

    return Scaffold(
//          backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffffd600),
          title: Text(
            'SIGN UP',
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
            return Container(
              child: SingleChildScrollView(
                child: Form(
                  key: _.formKeySignUp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
/* ------------------------------- new ui data ------------------------------ */
                      textBox(
                        controller: _.firstNameController,
                        hint: 'First Name',
                        validator: (input) {
                          if (input.length < 4) {
                            return 'First name Should be contain atleast 4 letter';
                          }
                        },
                        onSave: (input) {
                          _.userData.firstName = input;
                        },
                      ),
                      spc20,
                      textBox(
                        controller: _.lastNameController,
                        hint: 'Last Name',
                        // validator: (input) {
                        //   if (input.length < 4) {
                        //     return 'First name Should be contain atleast 4 letter';
                        //   }
                        // },
                        onSave: (input) {
                          _.userData.lastName = input;
                        },
                      ),
                      spc20,
                      textBox(
                        controller: _.signUpemailController,
                        hint: 'Email',
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
                          hint: 'Password',
                          texthide: true,
                          validator: (input) {
                            if (input.length < 8) {
                              return 'Password Should be  Contain Atleast 8 digit';
                            }
                          },
                          controller: _.signUppasswordController),
                      spc20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Date Of Birth (opt)'),
                              Text(
                                _.userData.dob ?? 'Select Date',
                                style: TextStyle(
                                  color: _.userData.dob == null
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.calendar_today_rounded),
                                  onPressed: () {
                                    selectDate(context);
                                  })
                            ],
                          ),
                        ),
                      ),
                      spc20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Gender (opt)'),
                              Text(_.gender),
                              DropdownButton(
                                iconSize: 30,
                                items: <String>['Male', 'Female', 'Other']
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (selectedVal) {
                                  _.gender = selectedVal;
                                  _.update();
                                  _.userData.gender = selectedVal;
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      spc20,
                      textBox(
                        controller: _.countryController,
                        hint: 'Country (opt)',
                        validator: (input) {
                          /* if (input == '') {
                            return 'Please Enter Country Name';
                          }*/
                        },
                        onSave: (input) {
                          _.userData.country = input;
                        },
                      ),
                      spc20,
                      textBox(
                        controller: _.stateController,
                        hint: 'State (opt)',
                        validator: (input) {
                          /* if (input == '') {
                            return 'Please Enter State';
                          }*/
                        },
                        onSave: (input) {
                          _.userData.state = input;
                        },
                      ),
                      spc20,
                      textBox(
                        hint: 'Profession (opt)',
                        controller: _.professionController,
                        validator: (input) {
                          // if (input == '') {
                          //   return 'Enter Your Profession';
                          // }
                        },
                        onSave: (input) {
                          _.userData.profession = input;
                        },
                      ),
                      spc20,
                      errorMessageText(_.errorMessage),
                      if (_.errorMessage != '') spc20,
                      buttonBox(
                        txt: 'Sign Up',
                        onTap: () async {
                          final FormState formState =
                              _.formKeySignUp.currentState;
                          if (formState.validate()) {
                            print('Form is validate');
                            // if (_.userData.dob != null) {
                            _.signUp();
                            // } else {
                            //    Get.snackbar('Date Of Birth',
                            //        'Please Select Date of Birth',
                            //        colorText: Colors.black,
                            //        backgroundColor: Colors.red);
                            //}
                          } else {
                            print('Form is not Validate');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }, // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: userController.selectedDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != userController.selectedDate)
      setState(() {
        userController.selectedDate = picked;
      });
    userController.userData.dob =
        DateFormat("dd MMMM,yyyy").format(userController.selectedDate);
  }
}
