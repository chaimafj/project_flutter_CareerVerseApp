import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../utils/app_localizations.dart';
import '../utils/validators.dart';
import '../widgets/career_ui.dart';
import '../widgets/form_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final error = await context.read<AppState>().login(
      _emailController.text,
      _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _loading = false);
    if (error != null) {
      showError(context, error);
      return;
    }
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 22),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back, color: ink),
                ),
                const SizedBox(height: 7),
                const Center(child: CareerLogo()),
                const SizedBox(height: 35),
                Text(
                  loc.welcomeBack,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Sign in to continue your journey',
                  style: TextStyle(color: mutedInk, fontSize: 14),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  key: const Key('login-email'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: careerInputDecoration(
                    label: 'Email address',
                    hint: 'you@example.com',
                    icon: Icons.mail_outline,
                  ),
                  validator: AppValidators.email,
                ),
                const SizedBox(height: 11),
                TextFormField(
                  key: const Key('login-password'),
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  onFieldSubmitted: (_) => _login(),
                  decoration: careerInputDecoration(
                    label: loc.password,
                    icon: Icons.lock_outline,
                    suffix: IconButton(
                      onPressed: () =>
                          setState(() => _hidePassword = !_hidePassword),
                      icon: Icon(
                        _hidePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: mutedInk,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: AppValidators.password,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => showInfo(
                      context,
                      'Accounts are stored on this device. Create a new '
                      'account if you forgot your password.',
                    ),
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: blue, fontSize: 11),
                    ),
                  ),
                ),
                _loading
                    ? const Center(child: CircularProgressIndicator())
                    : GradientActionButton(
                        label: 'Log In',
                        onPressed: _login,
                        icon: Icons.login_rounded,
                      ),
                const SizedBox(height: 19),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xFFDDE5F3))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or',
                        style: TextStyle(color: mutedInk, fontSize: 12),
                      ),
                    ),
                    Expanded(child: Divider(color: Color(0xFFDDE5F3))),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton.icon(
                    onPressed: () => showInfo(
                      context,
                      'Google Sign-In requires a Firebase project '
                      '(google-services.json). Use email sign-in for now.',
                    ),
                    icon: const Icon(
                      Icons.g_mobiledata,
                      color: Color(0xFF4285F4),
                      size: 24,
                    ),
                    label: Text(
                      loc.continueWithGoogle,
                      style: const TextStyle(color: ink, fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFE1EAF8),
                        width: 1.4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/register'),
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(color: mutedInk, fontSize: 12),
                        children: [
                          TextSpan(text: "Don't have an account?   "),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: blue,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
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
