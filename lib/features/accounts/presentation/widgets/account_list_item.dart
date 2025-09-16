import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/mock/account_repository.dart';
import '../../../../core/utils/currency_formatter.dart';

class AccountListItem extends StatelessWidget {
  final Account account;
  final VoidCallback? onTap;

  const AccountListItem({super.key, required this.account, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radius16),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Row(
            children: [
              // Account type icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getAccountTypeColor(
                    account.accountType,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                ),
                child: Icon(
                  _getAccountTypeIcon(account.accountType),
                  color: _getAccountTypeColor(account.accountType),
                  size: 24,
                ),
              ),

              const SizedBox(width: AppTheme.spacing16),

              // Account details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.accountName,
                      style: AppTheme.titleSmall.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: AppTheme.fontWeightSemiBold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      '****${account.accountNumber.substring(account.accountNumber.length - 4)}',
                      style: AppTheme.bodySmall.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getAccountTypeColor(
                          account.accountType,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radius4),
                      ),
                      child: Text(
                        _getAccountTypeLabel(account.accountType),
                        style: AppTheme.labelSmall.copyWith(
                          color: _getAccountTypeColor(account.accountType),
                          fontWeight: AppTheme.fontWeightMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Balance
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyFormatter.formatAmount(
                      account.balance,
                      account.currency,
                    ),
                    style: AppTheme.titleMedium.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: AppTheme.fontWeightSemiBold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    account.currency,
                    style: AppTheme.bodySmall.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
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

  Color _getAccountTypeColor(String accountType) {
    switch (accountType.toLowerCase()) {
      case 'savings':
        return AppTheme.successColor;
      case 'checking':
        return AppTheme.infoColor;
      case 'business':
        return AppTheme.warningColor;
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getAccountTypeIcon(String accountType) {
    switch (accountType.toLowerCase()) {
      case 'savings':
        return Icons.savings;
      case 'checking':
        return Icons.account_balance;
      case 'business':
        return Icons.business;
      default:
        return Icons.account_balance_wallet;
    }
  }

  String _getAccountTypeLabel(String accountType) {
    switch (accountType.toLowerCase()) {
      case 'savings':
        return 'Savings';
      case 'checking':
        return 'Checking';
      case 'business':
        return 'Business';
      default:
        return 'Account';
    }
  }
}
