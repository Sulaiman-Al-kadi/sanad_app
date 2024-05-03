// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:sanad_app/screans/forget_passwprd.dart';
// // import 'package:sanad_app/screans/signup.dart';
// // import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';

// // class Login extends StatefulWidget {
// //   const Login({super.key});

// //   @override
// //   State<Login> createState() => _LoginState();
// // }

// // class _LoginState extends State<Login> {
// //   final _auth = FirebaseAuth.instance;

// //   late String email;
// //   late String password;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         padding: const EdgeInsets.symmetric(
// //           horizontal: 20,
// //         ),
// //         width: MediaQuery.of(context).size.width,
// //         child: SingleChildScrollView(
// //           scrollDirection: Axis.vertical,
// //           child: Column(
// //             children: <Widget>[
// //               const SizedBox(height: 100),
// //               Image.asset(
// //                 'images/login_icon.jpeg',
// //                 width: 170,
// //                 height: 170,
// //               ),
// //               const SizedBox(
// //                 height: 70,
// //               ),
// //               TextField(
// //                 onChanged: (value) {
// //                   email = value;
// //                 },
// //                 decoration: InputDecoration(
// //                   hintText: 'Email',
// //                   prefixIcon: const Icon(Icons.email),
// //                   enabledBorder: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(200),
// //                       borderSide: const BorderSide(
// //                         color: Colors.blue,
// //                         width: 1.0,
// //                       )),
// //                   disabledBorder: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(200),
// //                       borderSide: const BorderSide(
// //                         color: Colors.blue,
// //                         width: 1.0,
// //                       )),
// //                   focusedBorder: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(200),
// //                       borderSide: const BorderSide(
// //                         color: Colors.blue,
// //                         width: 1.0,
// //                       )),
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 30,
// //               ),
// //               TextField(
// //                 onChanged: (value) {
// //                   password = value;
// //                 },
// //                 decoration: InputDecoration(
// //                   hintText: 'password',
// //                   prefixIcon: const Icon(Icons.password),
// //                   enabledBorder: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(200),
// //                       borderSide: const BorderSide(
// //                         color: Colors.blue,
// //                         width: 1.0,
// //                       )),
// //                   disabledBorder: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(200),
// //                       borderSide: const BorderSide(
// //                         color: Colors.blue,
// //                         width: 1.0,
// //                       )),
// //                   focusedBorder: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(200),
// //                       borderSide: const BorderSide(
// //                         color: Colors.blue,
// //                         width: 1.0,
// //                       )),
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 50,
// //               ),
// //               MaterialButton(
// //                 elevation: 5.0,
// //                 color: const Color.fromARGB(255, 4, 131, 234),
// //                 padding:
// //                     const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
// //                 // ignore: sort_child_properties_last
// //                 child: const Text(
// //                   'تسجيل الدخول',
// //                   style: TextStyle(
// //                     color: Color.fromARGB(255, 254, 254, 254),
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 shape: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(50),
// //                   borderSide: BorderSide.none,
// //                 ),
// //                 onPressed: () async {
// //                   final user = await _auth.signInWithEmailAndPassword(
// //                       email: email, password: password);

// //                   try {
// //                     if (user != null) {
// //                       Navigator.of(context).pushNamed("/admin_homepage");
// //                     }
// //                   } catch (e) {
// //                     print(e);
// //                   }
// //                 },
// //               ),
// //               const SizedBox(
// //                 height: 20,
// //               ),
// //               GestureDetector(
// //                 onTap: () {
// //                       Navigator.of(context).pushNamed("/forget_ password");

// //                 },
// //                 child: const Text(
// //                   'نسيت كلمة المرور؟',
// //                   style: TextStyle(
// //                     color: Colors.blue,
// //                     fontSize: 20,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 15,
// //               ),
// //               GestureDetector(
// //                 onTap: () {
// //                       Navigator.of(context).pushNamed("/signup");

// //                 },
// //                 child: const Text(
// //                   'إنشاء حساب جديد',
// //                   style: TextStyle(
// //                     color: Colors.blue,
// //                     fontSize: 20,
// //                   ),
// //                 ),
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sanad_app/screans/forget_passwprd.dart';
import 'package:sanad_app/screans/signup.dart';
import 'package:sanad_app/screans/admin-ui/admin_home_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              Image.asset(
                'images/login_icon.jpeg',
                width: 170,
                height: 170,
              ),
              SizedBox(height: 70),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.password),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              MaterialButton(
                elevation: 5.0,
                color: Color.fromARGB(255, 4, 131, 234),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: Color.fromARGB(255, 254, 254, 254),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                onPressed: () async {
                  try {
                    final userCredential =
                        await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (userCredential.user != null) {
                      final userDoc = await _firestore
                          .collection('users')
                          .doc(userCredential.user!.uid)
                          .get();
                      final userType = userDoc['userType'];

                      // Navigate to appropriate page based on user type
                      switch (userType) {
                        case 'Admin':
                          Navigator.of(context)
                              .pushReplacementNamed("/admin_homepage");
                          break;
                        case 'User':
                          Navigator.of(context)
                              .pushReplacementNamed("/user_homepage");
                          // Redirect user to user page
                          break;
                        case 'Manager':
                          Navigator.of(context)
                              .pushReplacementNamed("/manager_homepage");
                          // Redirect user to manager page
                          break;
                        case 'Maintenance Personnel':
                          Navigator.of(context)
                              .pushReplacementNamed("/mp_homepage");
                          // Redirect user to maintenance page
                          break;
                        default:
                          // Handle unknown user type
                          break;
                      }
                    }
                  } catch (e) {
                    print(e);
                    // Handle login error
                  }
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/forget_password");
                },
                child: Text(
                  'نسيت كلمة المرور؟',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/signup");
                },
                child: Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../../core/app_export.dart';
// import '../../core/utils/validation_functions.dart';
// import '../../widgets/custom_outlined_button.dart';
// import '../../widgets/custom_text_form_field.dart';
// import 'bloc/sign_in_page_bloc.dart';
// import 'models/sign_in_page_model.dart'; // ignore_for_file: must_be_immutable

// // ignore_for_file: must_be_immutable
// class SignInPageScreen extends StatelessWidget {
//   SignInPageScreen({Key? key})
//       : super(
//           key: key,
//         );

//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   static Widget builder(BuildContext context) {
//     return BlocProvider<SignInPageBloc>(
//       create: (context) => SignInPageBloc(SignInPageState(
//         signInPageModelObj: SignInPageModel(),
//       ))
//         ..add(SignInPageInitialEvent()),
//       child: SignInPageScreen(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: SingleChildScrollView(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: Form(
//             key: _formKey,
//             child: Container(
//               width: double.maxFinite,
//               padding: EdgeInsets.only(
//                 left: 50.h,
//                 top: 65.v,
//                 right: 50.h,
//               ),
//               child: Column(
//                 children: [
//                   CustomImageView(
//                     imagePath: ImageConstant.imgGroup3,
//                     height: 164.adaptSize,
//                     width: 164.adaptSize,
//                   ),
//                   SizedBox(height: 44.v),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 2.h),
//                     child: BlocSelector<SignInPageBloc, SignInPageState,
//                         TextEditingController?>(
//                       selector: (state) => state.emailController,
//                       builder: (context, emailController) {
//                         return CustomTextFormField(
//                           controller: emailController,
//                           hintText: "lbl_email".tr,
//                           textInputType: TextInputType.emailAddress,
//                           prefix: Container(
//                             margin: EdgeInsets.symmetric(
//                               horizontal: 11.h,
//                               vertical: 15.v,
//                             ),
//                             child: CustomImageView(
//                               imagePath: ImageConstant.imgUserGray70002,
//                               height: 24.adaptSize,
//                               width: 24.adaptSize,
//                             ),
//                           ),
//                           prefixConstraints: BoxConstraints(
//                             maxHeight: 54.v,
//                           ),
//                           validator: (value) {
//                             if (value == null ||
//                                 (!isValidEmail(value, isRequired: true))) {
//                               return "err_msg_please_enter_valid_email".tr;
//                             }
//                             return null;
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 30.v),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 2.h),
//                     child: BlocSelector<SignInPageBloc, SignInPageState,
//                         TextEditingController?>(
//                       selector: (state) => state.passwordController,
//                       builder: (context, passwordController) {
//                         return CustomTextFormField(
//                           controller: passwordController,
//                           hintText: "lbl_password".tr,
//                           textInputAction: TextInputAction.done,
//                           textInputType: TextInputType.visiblePassword,
//                           prefix: Container(
//                             margin: EdgeInsets.fromLTRB(15.h, 17.v, 11.h, 18.v),
//                             child: CustomImageView(
//                               imagePath: ImageConstant.imgTrophy,
//                               height: 20.v,
//                               width: 16.h,
//                             ),
//                           ),
//                           prefixConstraints: BoxConstraints(
//                             maxHeight: 55.v,
//                           ),
//                           validator: (value) {
//                             if (value == null ||
//                                 (!isValidPassword(value, isRequired: true))) {
//                               return "err_msg_please_enter_valid_password".tr;
//                             }
//                             return null;
//                           },
//                           obscureText: true,
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 10.v),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       "msg_forgot_password".tr,
//                       style: CustomTextStyles.bodySmallBlue900_1,
//                     ),
//                   ),
//                   SizedBox(height: 25.v),
//                   CustomOutlinedButton(
//                     text: "lbl_sign_in".tr,
//                     margin: EdgeInsets.symmetric(horizontal: 2.h),
//                   ),
//                   SizedBox(height: 34.v),
//                   Divider(
//                     color: theme.colorScheme.secondaryContainer,
//                     indent: 2.h,
//                     endIndent: 2.h,
//                   ),
//                   SizedBox(height: 50.v),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         left: 64.h,
//                         right: 15.h,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             "msg_don_t_have_an_account".tr,
//                             style: CustomTextStyles.bodySmallGray800,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               onTapTxtCreatenewone(context);
//                             },
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 8.h),
//                               child: Text(
//                                 "lbl_create_new_one".tr,
//                                 style: CustomTextStyles.bodySmallBlue900,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5.v)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

