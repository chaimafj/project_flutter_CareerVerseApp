import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
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
      showError(context, context.l10n.acceptTermsError);
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
      showError(context, context.l10n.authError(error));
      return;
    }
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
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
                Text(
                  loc.createYourAccount,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  loc.registerSubtitle,
                  style: const TextStyle(color: mutedInk, fontSize: 14),
                ),
                const SizedBox(height: 22),
                TextFormField(
                  key: const Key('register-name'),
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: careerInputDecoration(
                    label: loc.fullName,
                    icon: Icons.person_outline,
                  ),
                  validator: AppValidators.name(loc),
                ),
                const SizedBox(height: 11),
                TextFormField(
                  key: const Key('register-email'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: careerInputDecoration(
                    label: loc.emailAddress,
                    hint: 'you@example.com',
                    icon: Icons.mail_outline,
                  ),
                  validator: AppValidators.email(loc),
                ),
                const SizedBox(height: 11),
                TextFormField(
                  key: const Key('register-password'),
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  textInputAction: TextInputAction.next,
                  decoration: careerInputDecoration(
                    label: loc.password,
                    hint: loc.passwordHint,
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
                  validator: AppValidators.password(loc),
                ),
                const SizedBox(height: 11),
                TextFormField(
                  key: const Key('register-confirm'),
                  controller: _confirmController,
                  obscureText: _hidePassword,
                  onFieldSubmitted: (_) => _register(),
                  decoration: careerInputDecoration(
                    label: loc.confirmPassword,
                    icon: Icons.lock_reset,
                  ),
                  validator: (value) => value != _passwordController.text
                      ? loc.passwordsDoNotMatch
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
                  title: Text(
                    loc.acceptTerms,
                    style: const TextStyle(color: mutedInk, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 6),
                _loading
                    ? const Center(child: CircularProgressIndicator())
                    : GradientActionButton(
                        key: const Key('register-submit'),
                        label: loc.createAccount,
                        onPressed: _register,
                        icon: Icons.person_add_alt_1,
                      ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/login'),
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(color: mutedInk, fontSize: 12),
                        children: [
                          TextSpan(text: '${loc.haveAccount}   '),
                          TextSpan(
                            text: loc.logIn,
                            style: const TextStyle(
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
