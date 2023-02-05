import 'package:flutter/material.dart';
import 'package:task/auth/screens/register_screen.dart';
import 'package:task/core/utilis/enums.dart';
import '../../core/component/custom_elevated_button.dart';
import '../../core/component/custom_text.dart';
import '../../core/component/custom_text_form_filed.dart';
import '../../core/services/cach_helper.dart';
import '../../core/utilis/app_constance.dart';
import '../../movies/presentation/screens/movies_screen.dart';
import '../data_base_handler/dbhelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DbHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    var loginFormKey = GlobalKey<FormState>();
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/d39a06d979c7e1cac7d58f07ad47d5d6.jpg'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: loginFormKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextFormFiled(
                      controller: userNameController,
                      prefixIcon: const Icon(Icons.person_outline_outlined),
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
                      height: 40,
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
                      hintText: 'password',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    customElevatedButton(
                        text: 'Login',
                        onPressed: () async {
                          if (loginFormKey.currentState!.validate()) {
                            await dbHelper!
                                .getLoginUser(userNameController.text,
                                    passwordController.text)
                                .then((value1) {
                              CacheHelper.saveData(
                                      key: 'userId', value: value1!.userName)
                                  .then((value) {
                                userName = CacheHelper.getData('userId');
                                navigateAndKill(
                                    context,
                                    MoviesScreen(name: value1.userName!,));
                              });
                              print('success');
                            }).catchError((error) {
                              showToast(
                                  state: ToastStates.ERROR,
                                  msg: 'user name or password mistake');
                              print('error');
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
                            text: 'Don`t have an account ?',
                            color: Colors.white),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            navigateTo(context, const RegisterScreen());
                          },
                          child:
                              customText(text: 'sign up', color: Colors.green),
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
