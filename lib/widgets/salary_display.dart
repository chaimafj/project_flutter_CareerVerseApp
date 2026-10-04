import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../providers/app_state.dart';
import '../providers/salary_currency_provider.dart';

class SalaryDisplay extends StatelessWidget {
  const SalaryDisplay({super.key, required this.euroSalary});

  final String euroSalary;

  @override
  Widget build(BuildContext context) {
    final countryCode = context.watch<AppState>().profile.countryCode;
    final currency = context.watch<SalaryCurrencyProvider>();
    final loc = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currency.formatSalary(
            euroSalary,
            countryCode,
            loc,
            localeCode: Localizations.localeOf(context).toLanguageTag(),
          ),
        ),
        if (currency.hasLocalCurrency(countryCode))
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              loc.salaryConvertedNote,
              style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
            ),
          ),
      ],
    );
  }
}
