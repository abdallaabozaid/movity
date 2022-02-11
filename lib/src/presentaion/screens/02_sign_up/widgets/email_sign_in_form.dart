import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/app_theme.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/enums.dart';
import 'package:movity/src/logic/auth/cubit/auth_cubit.dart';
import 'package:movity/src/presentaion/common_widgets/elevated_button.dart';

class EmailSignInForm extends StatefulWidget {
  const EmailSignInForm({
    Key? key,
    required this.fromSignOut,
  }) : super(key: key);
  final bool fromSignOut;
  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  bool _isObscure = true;
  bool _isValidating = false;
  FormType _formType = FormType.signUp;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();

  String get _email => _emailTextController.text;
  String get _password => _passwordTextController.text;
  String get _firstName => _firstNameController.text;
  String get _lastName => _lastNameTextController.text;

  void _submitt(AuthCubit auth) async {
    _isValidating = true;
    final inputValidation = _formKey.currentState!.validate();
    if (inputValidation) {
      await auth.submitt(
        formType: _formType,
        email: _email,
        password: _password,
        firstName: _firstName,
        lastName: _lastName,
      );
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _firstNameController.dispose();
    _lastNameTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //// TODO : user go to sign in page after logging out not to sign up
    // _formType = widget.fromSignOut ? FormType.signIn : FormType.signUp;
    final auth = BlocProvider.of<AuthCubit>(context);
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is FormToggled && previous != current,
      builder: (context, state) {
        return Form(
          autovalidateMode: _isValidating
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          key: _formKey,
          child: Column(
            children: [
              _formType == FormType.signUp
                  ? SizedBox(
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(flex: 6, child: _firstNameField()),
                          const Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(flex: 6, child: _lastNameField()),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 100,
                child: _emailField(),
              ),
              SizedBox(
                height: 100,
                child: _passwordField(),
              ),
              _formType == FormType.signUp
                  ? SizedBox(
                      // color: Colors.green,
                      height: 90,
                      child: _confirmPasswordField(),
                    )
                  : Container(),
              CommonButton(
                  labelText:
                      _formType == FormType.signUp ? 'Sign Up' : 'Sign In',
                  onPressed: () {
                    _submitt(auth);
                  }),
              const SizedBox(height: 10),
              _trailinText(context, auth),
              _buildAuthBlocListener()
            ],
          ),
        );
      },
    );
  }

  Widget _buildAuthBlocListener() {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is FormToggled && previous != current,
      listener: (context, state) {
        if (state is FormToggled) {
          _formType = state.formType;
          _isValidating = false;
        }
      },
      child: Container(),
    );
  }

  Widget _firstNameField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a value';
        }
        return null;
      },
      controller: _firstNameController,
      cursorColor: AppColors.goldenColor,
      cursorRadius: const Radius.circular(20),
      textInputAction: TextInputAction.next,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        focusedBorder: AppTheming.focusedBorder,
        enabledBorder: AppTheming.enabledBorder,
        disabledBorder: AppTheming.disabledBorder,
        errorBorder: AppTheming.errorBorder,
        focusedErrorBorder: AppTheming.errorBorder,
        labelText: 'First name',
        labelStyle: TextStyle(
          color: AppColors.goldenColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _lastNameField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a value';
        }
        return null;
      },
      controller: _lastNameTextController,
      cursorColor: AppColors.goldenColor,
      cursorRadius: const Radius.circular(20),
      keyboardAppearance: Brightness.dark,
      textInputAction: TextInputAction.next,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        focusedBorder: AppTheming.focusedBorder,
        enabledBorder: AppTheming.enabledBorder,
        disabledBorder: AppTheming.disabledBorder,
        errorBorder: AppTheming.errorBorder,
        focusedErrorBorder: AppTheming.errorBorder,
        labelText: 'Last name',
        labelStyle: TextStyle(
          color: AppColors.goldenColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter ypur email adress ..';
        } else if (!value.contains('.com')) {
          return 'Invalid email adress ..';
        }
        return null;
      },
      onChanged: (email) {},
      controller: _emailTextController,
      cursorColor: AppColors.goldenColor,
      cursorRadius: const Radius.circular(20),
      keyboardAppearance: Brightness.dark,
      keyboardType: TextInputType.emailAddress,
      enableSuggestions: true,
      textInputAction: TextInputAction.next,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        focusedBorder: AppTheming.focusedBorder,
        errorBorder: AppTheming.errorBorder,
        enabledBorder: AppTheming.enabledBorder,
        focusedErrorBorder: AppTheming.errorBorder,
        disabledBorder: AppTheming.disabledBorder,
        labelText: 'Email',
        labelStyle: TextStyle(
          color: AppColors.goldenColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter ypur password ..';
        } else if (value.length < 6) {
          return 'Too short password';
        }
        return null;
      },
      controller: _passwordTextController,
      cursorColor: AppColors.goldenColor,
      cursorRadius: const Radius.circular(20),
      keyboardAppearance: Brightness.dark,
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: _isObscure,
      textInputAction: TextInputAction.next,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
            color: AppColors.goldenColor,
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
        focusedBorder: AppTheming.focusedBorder,
        enabledBorder: AppTheming.enabledBorder,
        errorBorder: AppTheming.errorBorder,
        focusedErrorBorder: AppTheming.errorBorder,
        disabledBorder: AppTheming.disabledBorder,
        labelText: 'Password',
        labelStyle: TextStyle(
          color: AppColors.goldenColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _confirmPasswordField() {
    return TextFormField(
      validator: (value) {
        if (value != _password) {
          return 'password doesn\'t match ..';
        } else {
          return null;
        }
      },
      cursorColor: AppColors.goldenColor,
      cursorRadius: const Radius.circular(20),
      keyboardAppearance: Brightness.dark,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: _isObscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        focusedBorder: AppTheming.focusedBorder,
        enabledBorder: AppTheming.enabledBorder,
        disabledBorder: AppTheming.disabledBorder,
        errorBorder: AppTheming.errorBorder,
        focusedErrorBorder: AppTheming.errorBorder,
        labelText: 'Confirm password',
        labelStyle: TextStyle(
          color: AppColors.goldenColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _trailinText(BuildContext context, AuthCubit auth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formType == FormType.signUp
                  ? 'Already have an account ?  '
                  : 'Need an account ? ',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                auth.toggleFormType(_formType);
              },
              child: Text(
                _formType == FormType.signUp ? 'Login' : 'Create Account',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        _formType == FormType.signIn
            ? Text(
                'or',
                style: TextStyle(fontSize: 20, color: AppColors.goldenColor),
              )
            : Container(),
      ],
    );
  }
}
