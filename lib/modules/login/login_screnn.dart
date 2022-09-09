import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp2/lay_out/Shop_Layout.dart';
import 'package:shopapp2/modules/Register/Register_Screen.dart';
import 'package:shopapp2/modules/login/login_cubit.dart';
import 'package:shopapp2/modules/login/login_state.dart';
import 'package:shopapp2/shared/components/components.dart';
import 'package:shopapp2/shared/components/constant.dart';
import 'package:shopapp2/shared/network/local/cash_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, MainLoginClass>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            if (state.modelLogin!.status!) {
              CashHelper.saveData(
                key: "token",
                val: state.modelLogin!.data!.token,
              ).then((value) => {
                    token = state.modelLogin!.data!.token,
                    userName = state.modelLogin!.data!.name,
                    image = state.modelLogin!.data!.image,
                    print(token),
                    showToast(
                      toastState: ToastStates.SUCCESS,
                      message: state.modelLogin!.message.toString(),
                    ),
                    navigateAndFinish(context, ShopLayout()),
                  });
            } else {
              showToast(
                toastState: ToastStates.ERROR,
                message: state.modelLogin!.message.toString(),
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Login'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Login Now to browser our hot offers',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      defaultTextFormFeild(
                        lapel: "Email Address",
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.toString().isEmpty) {
                            return "Email address must not empty ";
                          }
                          return null;
                        },
                        submitted: (val) {
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextFormFeild(
                        lapel: "Password",
                        controller: passwordController,
                        keyboardType: TextInputType.number,
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                        ),
                        validator: (val) {
                          if (val == null || val.toString().isEmpty) {
                            return "Email address must not empty ";
                          }
                          return null;
                        },
                        submitted: (val) {
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                          condition: state is! LoadingLoginState,
                          builder: (context) => defaultMaterialButton(
                                onPressed: () {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                },
                                text: "LOGIN",
                              ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator())),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account ?',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          defaultTextButton(
                              text: 'Register',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
