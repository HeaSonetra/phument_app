import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String amount;
  final String currency;
  final String date;
  final TransactionType type;
  final IconData? icon;
  final VoidCallback? onTap;

  const TransactionTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.amount,
    required this.currency,
    required this.date,
    required this.type,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCredit = type == TransactionType.credit;
    final amountColor = isCredit ? AppTheme.successColor : AppTheme.errorColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing12,
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getIconBackgroundColor(type, theme),
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                ),
                child: Icon(
                  icon ?? _getDefaultIcon(type),
                  color: _getIconColor(type, theme),
                  size: 24,
                ),
              ),

              const SizedBox(width: AppTheme.spacing12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.bodyMedium.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: AppTheme.fontWeightMedium,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppTheme.spacing4),
                      Text(
                        subtitle!,
                        style: AppTheme.bodySmall.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      date,
                      style: AppTheme.bodySmall.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isCredit ? '+' : '-'}$currency$amount',
                    style: AppTheme.titleSmall.copyWith(
                      color: amountColor,
                      fontWeight: AppTheme.fontWeightSemiBold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: amountColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radius4),
                    ),
                    child: Text(
                      isCredit ? 'Credit' : 'Debit',
                      style: AppTheme.labelSmall.copyWith(
                        color: amountColor,
                        fontWeight: AppTheme.fontWeightMedium,
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

  Color _getIconBackgroundColor(TransactionType type, ThemeData theme) {
    switch (type) {
      case TransactionType.credit:
        return AppTheme.successColor.withOpacity(0.1);
      case TransactionType.debit:
        return AppTheme.errorColor.withOpacity(0.1);
      case TransactionType.transfer:
        return AppTheme.infoColor.withOpacity(0.1);
      case TransactionType.bill:
        return AppTheme.warningColor.withOpacity(0.1);
    }
  }

  Color _getIconColor(TransactionType type, ThemeData theme) {
    switch (type) {
      case TransactionType.credit:
        return AppTheme.successColor;
      case TransactionType.debit:
        return AppTheme.errorColor;
      case TransactionType.transfer:
        return AppTheme.infoColor;
      case TransactionType.bill:
        return AppTheme.warningColor;
    }
  }

  IconData _getDefaultIcon(TransactionType type) {
    switch (type) {
      case TransactionType.credit:
        return Icons.arrow_downward;
      case TransactionType.debit:
        return Icons.arrow_upward;
      case TransactionType.transfer:
        return Icons.swap_horiz;
      case TransactionType.bill:
        return Icons.receipt;
    }
  }
}

enum TransactionType { credit, debit, transfer, bill }
