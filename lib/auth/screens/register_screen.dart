import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/movies/presentation/screens/movies_screen.dart';

import '../../core/component/custom_elevated_button.dart';
import '../../core/component/custom_text.dart';
import '../../core/component/custom_text_form_filed.dart';
import '../../core/services/cach_helper.dart';
import '../../core/utilis/app_constance.dart';
import '../../core/utilis/enums.dart';
import '../data_base_handler/dbhelper.dart';
import '../model/user_model.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  DbHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    var registerFormKey = GlobalKey<FormState>();

    TextEditingController userIdController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/f15df26ddd980df8937dd4d01a07e913.jpg'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customText(
                        text: 'REGISTER', color: Colors.white, fontSize: 28.sp),
                    const SizedBox(
                      height: 50,
                    ),
                    // CustomTextFormFiled(
                    //   controller: userIdController,
                    //   prefixIcon: const Icon(Icons.person_outline_rounded),
                    //   obscureText: false,
                    //   textInputType: TextInputType.text,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'User Id must be filled';
                    //     }
                    //     return null;
                    //   },
                    //   hintText: 'User Id',
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    CustomTextFormFiled(
                      controller: userNameController,
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      obscureText: false,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'User Name must be filled';
                        }
                        return null;
                      },
                      hintText: 'User Name',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormFiled(
                      controller: emailController,
                      prefixIcon: const Icon(Icons.email_outlined),
                      obscureText: false,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!RegExp(validationEmail).hasMatch(value)) {
                          return 'Invalid email';
                        } else {
                          return null;
                        }
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormFiled(
                      controller: passwordController,
                      prefixIcon: const Icon(Icons.lock_open_sharp),
                      obscureText: true,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must be filled';
                        }
                        return null;
                      },
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormFiled(
                      controller: confirmPasswordController,
                      prefixIcon: const Icon(Icons.lock_open_sharp),
                      obscureText: true,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Password must be filled';
                        } else if (value != passwordController.text) {
                          return 'Password mismatch';
                        }
                        return null;
                      },
                      hintText: 'Confirm Password',
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    customElevatedButton(
                        text: 'REGISTER',
                        onPressed: () async {
                          if (registerFormKey.currentState!.validate()) {
                            UserModel user = UserModel(
                                // userId: userIdController.text,
                                userName: userNameController.text,
                                email: emailController.text,
                                password: passwordController.text);
                            await dbHelper!.saveData(user).then((value) {
                              CacheHelper.saveData(
                                  key: 'userId', value: userNameController.text).then((value) {
                                userName = CacheHelper.getData('userId');
                                navigateAndKill(
                                    context,
                                    MoviesScreen(
                                      name: userNameController.text,
                                    ));
                              });

                              // print('success');
                            }).catchError((error) {
                              showToast(
                                  state: ToastStates.ERROR,
                                  msg: 'user name already used');
                              print(error.toString());
                            });
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customText(
                            text: 'have an account ?', color: Colors.white),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: () {
                            navigateAndKill(context, const LoginScreen());
                          },
                          child:
                              customText(text: 'log in', color: Colors.green),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
