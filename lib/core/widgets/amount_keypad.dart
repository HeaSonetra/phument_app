import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AmountKeypad extends StatelessWidget {
  final String amount;
  final Function(String) onAmountChanged;
  final VoidCallback? onBackspace;
  final VoidCallback? onDone;
  final bool showDecimal;

  const AmountKeypad({
    super.key,
    required this.amount,
    required this.onAmountChanged,
    this.onBackspace,
    this.onDone,
    this.showDecimal = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppTheme.radius20),
          topRight: Radius.circular(AppTheme.radius20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Amount display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing20,
              vertical: AppTheme.spacing16,
            ),
            margin: const EdgeInsets.only(bottom: AppTheme.spacing20),
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
            child: Text(
              amount.isEmpty ? '0.00' : amount,
              style: AppTheme.headlineMedium.copyWith(
                color: theme.colorScheme.onBackground,
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Keypad
          _buildKeypad(theme),
        ],
      ),
    );
  }

  Widget _buildKeypad(ThemeData theme) {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['.', '0', 'backspace'],
    ];

    return Column(
      children: keys.map((row) => _buildKeyRow(row, theme)).toList(),
    );
  }

  Widget _buildKeyRow(List<String> row, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing4),
      child: Row(children: row.map((key) => _buildKey(key, theme)).toList()),
    );
  }

  Widget _buildKey(String key, ThemeData theme) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing4),
        child: _KeyButton(
          keyValue: key,
          onTap: () => _onKeyPressed(key),
          theme: theme,
        ),
      ),
    );
  }

  void _onKeyPressed(String key) {
    if (key == 'backspace') {
      if (amount.isNotEmpty) {
        onBackspace?.call();
      }
    } else if (key == '.' && showDecimal) {
      if (!amount.contains('.')) {
        onAmountChanged(amount + key);
      }
    } else if (key != '.') {
      onAmountChanged(amount + key);
    }
  }
}

class _KeyButton extends StatelessWidget {
  final String keyValue;
  final VoidCallback onTap;
  final ThemeData theme;

  const _KeyButton({
    required this.keyValue,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final isBackspace = keyValue == 'backspace';
    final isDecimal = keyValue == '.';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.circular(AppTheme.radius12),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Center(
            child: isBackspace
                ? Icon(
                    Icons.backspace_outlined,
                    color: theme.colorScheme.onBackground,
                    size: 24,
                  )
                : Text(
                    keyValue,
                    style: AppTheme.titleLarge.copyWith(
                      color: theme.colorScheme.onBackground,
                      fontFamily: isDecimal ? null : 'monospace',
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
