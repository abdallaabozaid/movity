// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:movit/config/app_theme.dart';
// import 'package:movit/config/colors.dart';
// import 'package:movit/src/data/model/auth_model.dart';
// import 'package:movit/src/logic/platform_exception_alert_dialog.dart';
// import 'package:movit/src/logic/string_validattion.dart';
// import 'package:movit/src/presentation/00_common_widgets/elevated_button.dart';
// import 'package:movit/src/presentation/02_sign_up/sign_up_screen.dart';

// class SignUpForm extends StatefulWidget with EmailAndPasswordValidator {
//   SignUpForm({Key? key, required this.formType, required this.auth})
//       : super(key: key);
//   final FormType formType;
//   final AuthBasics auth;

//   @override
//   State<SignUpForm> createState() => _SignUpFormState();
// }

// class _SignUpFormState extends State<SignUpForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isObscure = true;
//   final TextEditingController _emailTextController = TextEditingController();
//   final TextEditingController _passwordTextController = TextEditingController();

//   String get _email => _emailTextController.text;
//   String get _password => _emailTextController.text;

//   bool _formValidator() {
//     return _formKey.currentState!.validate();
//   }

//   bool _isLoading = false;

//   void _submitt() async {
//     print('submit aclled');

//     if (_formValidator()) {
//       setState(() {
//         _isLoading = true;
//       });
//       _formKey.currentState!.save();
//       try {
//         if (widget.formType == FormType.signUp) {
//           await widget.auth.createAccountWithEmailAndPassword(
//               email: _email, password: _password);
//         } else {
//           await widget.auth
//               .signInWithEmailAndPassword(email: _email, password: _password);
//         }
//       } on PlatformException catch (e) {
//         print(e.toString());
//         PlatformExceptionAlertDialog(
//                 platformE: e, title: 'Something went wrong .. ! ')
//             .show(context, isDissmissible: true);
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } else {
//       print('form not saved coz false validator ');
//     }
//   }

//   @override
//   void dispose() {
//     _emailTextController.dispose();
//     _passwordTextController.dispose();
//     super.dispose();
//   }

//   void _updateState() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool _submitEnabled = widget.emailValidator.isValid(_email) &&
//         widget.passwordValidator.isValid(_password) &&
//         !_isLoading;

//     return Form(
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       key: _formKey,
//       child: Column(
//         children: [
//           widget.formType == FormType.signUp
//               ? Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Expanded(flex: 6, child: _firstNameField()),
//                     const Expanded(
//                       flex: 1,
//                       child: SizedBox(),
//                     ),
//                     Expanded(flex: 6, child: _lastNameField()),
//                   ],
//                 )
//               : Container(),
//           const SizedBox(height: 24),
//           _emailField(),
//           const SizedBox(
//             height: 24,
//           ),
//           _passwordField(),
//           const SizedBox(
//             height: 24,
//           ),
//           widget.formType == FormType.signUp
//               ? _confirmPasswordField()
//               : Container(),
//           const SizedBox(
//             height: 24,
//           ),
//           CommonButton(
//             labelText:
//                 widget.formType == FormType.signUp ? 'Sign Up' : 'Sign In',
//             onPressed: _submitEnabled
//                 ? () {
//                     print('btn tapped');

//                     _submitt();
//                   }
//                 : null,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _firstNameField() {
//     return TextFormField(
//       cursorColor: AppColors.goldenColor,
//       cursorRadius: const Radius.circular(20),
//       textInputAction: TextInputAction.next,
//       style: const TextStyle(color: Colors.white),
//       enabled: _isLoading == false,
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.all(20),
//         focusedBorder: AppTheme.focusedBorder,
//         enabledBorder: AppTheme.enabledBorder,
//         disabledBorder: AppTheme.disabledBorder,
//         labelText: 'First name',
//         labelStyle: TextStyle(
//           color: AppColors.goldenColor,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   Widget _lastNameField() {
//     return TextFormField(
//       onChanged: (value) => _updateState(),
//       textCapitalization: TextCapitalization.words,
//       cursorColor: AppColors.goldenColor,
//       cursorRadius: const Radius.circular(20),
//       keyboardAppearance: Brightness.dark,
//       textInputAction: TextInputAction.next,
//       style: const TextStyle(color: Colors.white),
//       enabled: _isLoading == false,
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.all(20),
//         focusedBorder: AppTheme.focusedBorder,
//         enabledBorder: AppTheme.enabledBorder,
//         disabledBorder: AppTheme.disabledBorder,
//         labelText: 'Last name',
//         labelStyle: TextStyle(
//           color: AppColors.goldenColor,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   Widget _emailField() {
//     bool _validEmail = widget.emailValidator.isValid(_email);

//     return TextFormField(
//       validator: (value) {
//         if (_validEmail) {
//           return null;
//         }
//         print(_validEmail.toString());
//         return widget.inValidEmailErrorText;
//       },
//       onChanged: (value) => _updateState(),
//       controller: _emailTextController,
//       cursorColor: AppColors.goldenColor,
//       cursorRadius: const Radius.circular(20),
//       keyboardAppearance: Brightness.dark,
//       keyboardType: TextInputType.emailAddress,
//       enableSuggestions: true,
//       textInputAction: TextInputAction.next,
//       style: const TextStyle(color: Colors.white),
//       enabled: _isLoading == false,
//       decoration: InputDecoration(
//         // errorText: widget.inValidEmailErrorText,
//         contentPadding: const EdgeInsets.all(20),
//         focusedBorder: AppTheme.focusedBorder,
//         errorBorder: AppTheme.errorBorder,
//         enabledBorder: AppTheme.enabledBorder,
//         focusedErrorBorder: AppTheme.errorBorder,
//         disabledBorder: AppTheme.disabledBorder,
//         labelText: 'Email',
//         labelStyle: TextStyle(
//           color: AppColors.goldenColor,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   Widget _passwordField() {
//     bool _validPassword = widget.passwordValidator.isValid(_password);

//     return TextFormField(
//       validator: (value) {
//         if (_validPassword) {
//           return null;
//         }
//         return 'wrong';
//       },
//       onChanged: (value) => _updateState(),
//       controller: _passwordTextController,
//       cursorColor: AppColors.goldenColor,
//       cursorRadius: const Radius.circular(20),
//       keyboardAppearance: Brightness.dark,
//       keyboardType: TextInputType.visiblePassword,
//       autocorrect: false,
//       enableSuggestions: false,
//       obscureText: _isObscure,
//       textInputAction: TextInputAction.next,
//       style: const TextStyle(color: Colors.white),
//       enabled: _isLoading == false,
//       decoration: InputDecoration(
//         // errorText: widget.inValidPasswordErrorText,
//         suffixIcon: IconButton(
//           onPressed: () {
//             setState(() {
//               _isObscure = !_isObscure;
//             });
//           },
//           icon: Icon(
//             _isObscure ? Icons.visibility : Icons.visibility_off,
//             color: AppColors.goldenColor,
//           ),
//         ),
//         contentPadding: const EdgeInsets.all(20),
//         focusedBorder: AppTheme.focusedBorder,
//         enabledBorder: AppTheme.enabledBorder,
//         errorBorder: AppTheme.errorBorder,
//         focusedErrorBorder: AppTheme.errorBorder,
//         disabledBorder: AppTheme.disabledBorder,

//         labelText: 'Password',
//         labelStyle: TextStyle(
//           color: AppColors.goldenColor,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   Widget _confirmPasswordField() {
//     return TextFormField(
//       cursorColor: AppColors.goldenColor,
//       cursorRadius: const Radius.circular(20),
//       keyboardAppearance: Brightness.dark,
//       textInputAction: TextInputAction.done,
//       keyboardType: TextInputType.visiblePassword,
//       autocorrect: false,
//       enableSuggestions: false,
//       obscureText: true,
//       style: const TextStyle(color: Colors.white),
//       enabled: _isLoading == false,
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.all(20),
//         focusedBorder: AppTheme.focusedBorder,
//         enabledBorder: AppTheme.enabledBorder,
//         disabledBorder: AppTheme.disabledBorder,
//         labelText: 'Confirm password',
//         labelStyle: TextStyle(
//           color: AppColors.goldenColor,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }
// }
