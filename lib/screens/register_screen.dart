import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../utils/validators.dart';
import '../widgets/career_ui.dart';
import '../widgets/form_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _hidePassword = true;
  bool _acceptTerms = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      showError(context, 'Please accept the terms to continue.');
      return;
    }
    setState(() => _loading = true);
    final error = await context.read<AppState>().register(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
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
                const Center(child: CareerLogo()),
                const SizedBox(height: 24),
                const Text(
                  'Create your account',
                  style: TextStyle(
                    color: ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Start exploring careers through real simulations',
                  style: TextStyle(color: mutedInk, fontSize: 14),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  key: const Key('register-name'),
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: careerInputDecoration(
                    label: 'Full name',
                    icon: Icons.person_outline,
                  ),
                  validator: AppValidators.name,
                ),
                const SizedBox(height: 11),
                TextFormField(
                  key: const Key('register-email'),
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
                  key: const Key('register-password'),
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  textInputAction: TextInputAction.next,
                  decoration: careerInputDecoration(
                    label: 'Password',
                    hint: 'At least 6 characters',
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
                const SizedBox(height: 11),
                TextFormField(
                  key: const Key('register-confirm'),
                  controller: _confirmController,
                  obscureText: _hidePassword,
                  onFieldSubmitted: (_) => _register(),
                  decoration: careerInputDecoration(
                    label: 'Confirm password',
                    icon: Icons.lock_reset,
                  ),
                  validator: (value) => value != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                ),
                const SizedBox(height: 6),
                CheckboxListTile(
                  key: const Key('register-terms'),
                  value: _acceptTerms,
                  onChanged: (value) =>
                      setState(() => _acceptTerms = value ?? false),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: purple,
                  title: const Text(
                    'I accept the terms of use and privacy policy',
                    style: TextStyle(color: mutedInk, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 6),
                _loading
                    ? const Center(child: CircularProgressIndicator())
                    : GradientActionButton(
                        label: 'Create account',
                        onPressed: _register,
                        icon: Icons.person_add_alt_1,
                      ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/login'),
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(color: mutedInk, fontSize: 12),
                        children: [
                          TextSpan(text: 'Already have an account?   '),
                          TextSpan(
                            text: 'Log In',
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
