import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/widgets.dart';
import 'cubit/signup_cubit.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  static const String routeName = '/signup';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignUpCubit>(
        create: (context) => SignUpCubit(authRepository: context.read()),
        child: SignUpScreen(),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SignUpCubit>();
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.status == SignUpStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  context: context,
                  content: state.failure.message,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Instagram',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Username'),
                              onChanged: (value) =>
                                  cubit.usernameChanged(value),
                              validator: (value) => value!.trim().isEmpty
                                  ? 'Please enter a valid username.'
                                  : null,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Email'),
                              onChanged: (value) => cubit.emailChanged(value),
                              validator: (value) => !value!.contains('@')
                                  ? 'Please enter a valid email.'
                                  : null,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration:
                                  const InputDecoration(hintText: 'Password'),
                              onChanged: (value) =>
                                  cubit.passwordChanged(value),
                              validator: (value) => value!.length < 6
                                  ? 'Must be at least 6 characters.'
                                  : null,
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            ElevatedButton(
                              onPressed: () => _submitForm(cubit, state.status),
                              child: const Text('Sign Up'),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey.shade200),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Go Back to Log In'),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(SignUpCubit cubit, SignUpStatus state) {
    if (_formKey.currentState!.validate() && state != SignUpStatus.submitting) {
      cubit.signUpWithCredentials();
    }
  }
}
