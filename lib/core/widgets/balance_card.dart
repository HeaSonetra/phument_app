import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BalanceCard extends StatelessWidget {
  final String accountNumber;
  final String balance;
  final String currency;
  final bool isHidden;
  final VoidCallback? onToggleVisibility;
  final VoidCallback? onTap;
  final Color? gradientStart;
  final Color? gradientEnd;

  const BalanceCard({
    super.key,
    required this.accountNumber,
    required this.balance,
    required this.currency,
    this.isHidden = false,
    this.onToggleVisibility,
    this.onTap,
    this.gradientStart,
    this.gradientEnd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradientStart ?? AppTheme.primaryColor,
              gradientEnd ?? AppTheme.primaryVariant,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radius20),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Account Balance',
                    style: AppTheme.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  if (onToggleVisibility != null)
                    GestureDetector(
                      onTap: onToggleVisibility,
                      child: Icon(
                        isHidden ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white.withOpacity(0.9),
                        size: 24,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: AppTheme.spacing16),

              // Account Number
              Text(
                '****${accountNumber.substring(accountNumber.length - 4)}',
                style: AppTheme.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: AppTheme.spacing8),

              // Balance
              Row(
                children: [
                  Text(
                    currency,
                    style: AppTheme.titleLarge.copyWith(
                      color: Colors.white,
                      fontWeight: AppTheme.fontWeightMedium,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Expanded(
                    child: Text(
                      isHidden ? '••••••' : balance,
                      style: AppTheme.headlineMedium.copyWith(
                        color: Colors.white,
                        fontWeight: AppTheme.fontWeightBold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
