import '../l10n/app_localizations.dart';

class SalaryCountry {
  const SalaryCountry({
    required this.code,
    required this.currencyCode,
    required this.currencySymbol,
    required this.name,
  });

  final String code;
  final String currencyCode;
  final String currencySymbol;
  final String Function(AppLocalizations) name;
}

final salaryCountries = <SalaryCountry>[
  SalaryCountry(
    code: 'TN',
    currencyCode: 'TND',
    currencySymbol: 'DT',
    name: (loc) => loc.countryTunisia,
  ),
  SalaryCountry(
    code: 'DZ',
    currencyCode: 'DZD',
    currencySymbol: 'DA',
    name: (loc) => loc.countryAlgeria,
  ),
  SalaryCountry(
    code: 'MA',
    currencyCode: 'MAD',
    currencySymbol: 'DH',
    name: (loc) => loc.countryMorocco,
  ),
  SalaryCountry(
    code: 'EG',
    currencyCode: 'EGP',
    currencySymbol: 'E£',
    name: (loc) => loc.countryEgypt,
  ),
  SalaryCountry(
    code: 'FR',
    currencyCode: 'EUR',
    currencySymbol: '€',
    name: (loc) => loc.countryFrance,
  ),
  SalaryCountry(
    code: 'DE',
    currencyCode: 'EUR',
    currencySymbol: '€',
    name: (loc) => loc.countryGermany,
  ),
  SalaryCountry(
    code: 'US',
    currencyCode: 'USD',
    currencySymbol: r'$',
    name: (loc) => loc.countryUnitedStates,
  ),
  SalaryCountry(
    code: 'CA',
    currencyCode: 'CAD',
    currencySymbol: r'CA$',
    name: (loc) => loc.countryCanada,
  ),
  SalaryCountry(
    code: 'GB',
    currencyCode: 'GBP',
    currencySymbol: '£',
    name: (loc) => loc.countryUnitedKingdom,
  ),
  SalaryCountry(
    code: 'CH',
    currencyCode: 'CHF',
    currencySymbol: 'CHF',
    name: (loc) => loc.countrySwitzerland,
  ),
  SalaryCountry(
    code: 'AE',
    currencyCode: 'AED',
    currencySymbol: 'د.إ',
    name: (loc) => loc.countryUae,
  ),
  SalaryCountry(
    code: 'SA',
    currencyCode: 'SAR',
    currencySymbol: 'ر.س',
    name: (loc) => loc.countrySaudiArabia,
  ),
  SalaryCountry(
    code: 'IN',
    currencyCode: 'INR',
    currencySymbol: '₹',
    name: (loc) => loc.countryIndia,
  ),
  SalaryCountry(
    code: 'JP',
    currencyCode: 'JPY',
    currencySymbol: '¥',
    name: (loc) => loc.countryJapan,
  ),
  SalaryCountry(
    code: 'AU',
    currencyCode: 'AUD',
    currencySymbol: r'A$',
    name: (loc) => loc.countryAustralia,
  ),
  SalaryCountry(
    code: 'SN',
    currencyCode: 'XOF',
    currencySymbol: 'CFA',
    name: (loc) => loc.countrySenegal,
  ),
];

SalaryCountry? salaryCountryByCode(String? code) {
  if (code == null) return null;
  for (final country in salaryCountries) {
    if (country.code == code) return country;
  }
  return null;
}
