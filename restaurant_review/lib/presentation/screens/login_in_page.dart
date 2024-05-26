import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import 'package:restaurant_review/presentation/widgets/auth_field.dart';
import 'package:restaurant_review/presentation/widgets/auth_gradient_button.dart';
import 'package:restaurant_review/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:restaurant_review/presentation/bloc/login_bloc/login_events.dart';
import 'package:restaurant_review/presentation/bloc/login_bloc/login_state.dart';
import 'package:restaurant_review/infrastructure/repository/login_repository.dart';
import 'package:restaurant_review/domain/usecase/login_usecase.dart';

class LogInPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LogInPage(),
      );

  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = LoginAuthRepository();
    final logInUseCase = LogInUseCase(loginAuthRepository: authRepository);

    return BlocProvider(
      create: (context) => LoginBloc(logInUseCase: logInUseCase),
      child: LogInForm(),
    );
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LogInState>(
        listener: (context, state) {
          if (state is LogInSuccess) {
            Navigator.pushNamed(context, '/entry');
          } else if (state is LogInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In.',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 20),
                BlocBuilder<LoginBloc, LogInState>(
                  builder: (context, state) {
                    if (state is LogInLoading) {
                      return CircularProgressIndicator();
                    }
                    return AuthGradientButton(
                      buttonText: "Sign In",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginBloc>(context).add(
                            LogInButtonPressed(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      SignUpPage.route(),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account?",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: ' Sign Up',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPallete.gradient3,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
