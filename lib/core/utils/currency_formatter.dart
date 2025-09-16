import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _usdFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
    locale: 'en_US',
  );

  static final NumberFormat _khrFormat = NumberFormat.currency(
    symbol: '៛',
    decimalDigits: 0,
    locale: 'km_KH',
  );

  static String formatUSD(double amount) {
    return _usdFormat.format(amount);
  }

  static String formatKHR(double amount) {
    return _khrFormat.format(amount);
  }

  static String formatCurrency(double amount, String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return formatUSD(amount);
      case 'KHR':
        return formatKHR(amount);
      default:
        return formatUSD(amount);
    }
  }

  static String formatAmount(String amount, String currency) {
    try {
      final doubleValue = double.parse(amount.replaceAll(',', ''));
      return formatCurrency(doubleValue, currency);
    } catch (e) {
      return amount;
    }
  }

  static String hideAmount(String currency) {
    return '$currency••••••';
  }

  static String formatWithPrivacy(
    String amount,
    String currency,
    bool isHidden,
  ) {
    if (isHidden) {
      return hideAmount(currency);
    }
    return formatAmount(amount, currency);
  }
}
