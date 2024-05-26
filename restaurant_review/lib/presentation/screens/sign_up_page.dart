import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/screens/login_in_page.dart';
import 'package:restaurant_review/presentation/widgets/auth_field.dart';
import 'package:restaurant_review/presentation/widgets/auth_gradient_button.dart';
import 'package:restaurant_review/presentation/screens/Profile_page.dart';
import 'package:restaurant_review/presentation/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:restaurant_review/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/presentation/bloc/sign_up_bloc/sign_up_events.dart';
import 'package:restaurant_review/infrastructure/repository/sign_up_repository.dart';
import 'package:restaurant_review/domain/usecase/signup_usecase.dart';

class SignUpPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );

  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository();
    final signUpUseCase = SignUpUseCase(authRepository: authRepository);

    return BlocProvider(
      create: (context) => SignUpBloc(signUpUseCase: signUpUseCase),
      child: SignUpForm(),
    );
  }
}

class SignUpForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfilePage(),
              ),
            );
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 100),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up.',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthField(
                    hintText: 'Username',
                    controller: usernameController,
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: "Email",
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: "Password",
                    controller: passwordController,
                    isObscure: true,
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      UserType? selectedUserType;
                      if (state is UserTypeUpdated) {
                        selectedUserType = state.userType;
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Owner'),
                          Radio<UserType>(
                            activeColor: AppPallete.gradient3,
                            value: UserType.owner,
                            groupValue: selectedUserType,
                            onChanged: (UserType? value) {
                              BlocProvider.of<SignUpBloc>(context).add(
                                UserTypeSelected(userType: value!),
                              );
                            },
                          ),
                          const SizedBox(width: 20),
                          const Text('Customer'),
                          Radio<UserType>(
                            activeColor: AppPallete.gradient3,
                            value: UserType.customer,
                            groupValue: selectedUserType,
                            onChanged: (UserType? value) {
                              BlocProvider.of<SignUpBloc>(context).add(
                                UserTypeSelected(userType: value!),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    buttonText: "Sign Up",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final username = usernameController.text;
                        final email = emailController.text;
                        final password = passwordController.text;

                        final userType = (BlocProvider.of<SignUpBloc>(context)
                                .state as UserTypeUpdated)
                            .userType;
                        print('SignUpButtonPressed event dispatched');

                        BlocProvider.of<SignUpBloc>(context).add(
                          SignUpButtonPressed(
                            username: username,
                            email: email,
                            password: password,
                            userType: userType,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, LogInPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account?',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: ' Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPallete.gradient3,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
