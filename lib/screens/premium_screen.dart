import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../models/payment_transaction.dart';
import '../providers/app_state.dart';
import '../providers/theme_provider.dart';
import '../services/payment_service.dart';
import '../widgets/career_ui.dart';
import '../widgets/form_fields.dart';

/// Premium subscription (Stripe test mode) and transaction history.
/// Pops with `true` after a successful payment.
class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool _paying = false;

  Future<void> _subscribe() async {
    final loc = context.l10n;
    final state = context.read<AppState>();
    final payments = context.read<PaymentService>();
    final style = context.read<ThemeProvider>().themeMode;
    setState(() => _paying = true);
    try {
      final transaction = await state.buyPremium(payments, style: style);
      if (!mounted) return;
      showInfo(
        context,
        loc.premiumSuccess(loc.shortDate(transaction.premiumUntil)),
      );
      Navigator.of(context).pop(true);
    } on PaymentException catch (e) {
      if (!mounted) return;
      final message = loc.paymentError(e.error, e.message);
      e.error == PaymentError.cancelled
          ? showInfo(context, message)
          : showError(context, message);
    } finally {
      if (mounted) setState(() => _paying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    final state = context.watch<AppState>();
    final configured = context.read<PaymentService>().isConfigured;
    final until = state.premiumUntil;
    final plan = PremiumPlan.monthly;
    final status = state.isPremium
        ? loc.premiumActiveUntil(loc.shortDate(until!))
        : until != null
        ? loc.premiumExpired(loc.shortDate(until))
        : loc.premiumFree;

    return Scaffold(
      appBar: AppBar(title: Text(loc.premium)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [navy, purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.workspace_premium,
                      color: Color(0xFFFFC94D),
                      size: 34,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        loc.premiumTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  loc.premiumSubtitle,
                  style: const TextStyle(color: Color(0xFFD9E2FF)),
                ),
                const SizedBox(height: 14),
                Container(
                  key: const Key('premium-status'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final (icon, text) in [
            (Icons.science_outlined, loc.premiumBenefitLabs),
            (Icons.insights_outlined, loc.premiumBenefitSkills),
            (Icons.devices_outlined, loc.premiumBenefitSync),
          ])
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: purple.withValues(alpha: 0.12),
                child: Icon(icon, color: purple),
              ),
              title: Text(text),
            ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              loc.premiumPrice(plan.price, plan.days),
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 12),
          if (_paying)
            const Center(child: CircularProgressIndicator())
          else
            GradientActionButton(
              key: const Key('premium-buy'),
              label: state.isPremium
                  ? loc.premiumExtend(plan.price)
                  : loc.premiumBuy(plan.price),
              icon: Icons.lock_open_rounded,
              onPressed: _subscribe,
            ),
          const SizedBox(height: 12),
          _Hint(
            icon: Icons.science_outlined,
            text: configured
                ? '${loc.premiumTestMode}\n${loc.premiumTestCard}'
                : '${loc.premiumTestMode}\n${loc.paymentNotConfigured}',
          ),
          const SizedBox(height: 20),
          SectionTitle(loc.transactionHistory),
          const SizedBox(height: 8),
          if (state.transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                loc.noTransactions,
                textAlign: TextAlign.center,
                style: const TextStyle(color: mutedInk),
              ),
            )
          else
            for (final t in state.transactions) _TransactionTile(t),
        ],
      ),
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.amber.shade800, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile(this.transaction);

  final PaymentTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    final card = transaction.cardLast4 == null
        ? ''
        : ' · ${transaction.cardBrand ?? ''} •••• ${transaction.cardLast4}';
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.receipt_long_outlined, color: purple),
        title: Text('${loc.premium} · ${transaction.price}'),
        subtitle: Text(
          '${loc.shortDate(transaction.createdAt)}$card\n'
          '${loc.premiumActiveUntil(loc.shortDate(transaction.premiumUntil))}',
        ),
        isThreeLine: true,
        trailing: Text(
          transaction.testMode ? 'TEST' : transaction.status,
          style: TextStyle(
            color: Colors.amber.shade800,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
