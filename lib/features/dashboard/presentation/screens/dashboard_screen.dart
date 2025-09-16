import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/widgets/balance_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../../../core/mock/account_repository.dart';
import '../../../../core/mock/transaction_repository.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/greeting_header.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isBalanceHidden = false;
  bool _isLoading = true;
  List<Account> _accounts = [];
  List<Transaction> _recentTransactions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final accounts = await AccountRepository.getActiveAccounts();
      final transactions = await TransactionRepository.getRecentTransactions(
        limit: 5,
      );

      setState(() {
        _accounts = accounts;
        _recentTransactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceHidden = !_isBalanceHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          // App bar with greeting
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: theme.colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: GreetingHeader(
                onProfileTap: () => context.go(AppRouter.profile),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account cards
                  if (_isLoading)
                    _buildLoadingShimmer()
                  else
                    _buildAccountCards(),

                  const SizedBox(height: AppTheme.spacing24),

                  // Quick actions
                  SectionHeader(
                    title: 'Quick Actions',
                    action: TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: AppTheme.bodyMedium.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacing16),

                  _buildQuickActions(),

                  const SizedBox(height: AppTheme.spacing24),

                  // Recent transactions
                  SectionHeader(
                    title: 'Recent Transactions',
                    action: TextButton(
                      onPressed: () => context.go(AppRouter.accounts),
                      child: Text(
                        'View All',
                        style: AppTheme.bodyMedium.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacing16),

                  _buildRecentTransactions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Column(
      children: List.generate(
        2,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(AppTheme.radius20),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountCards() {
    if (_accounts.isEmpty) {
      return const Center(child: Text('No accounts found'));
    }

    return Column(
      children: _accounts.map((account) {
        return BalanceCard(
          accountNumber: account.accountNumber,
          balance: _isBalanceHidden
              ? '••••••'
              : CurrencyFormatter.formatAmount(
                  account.balance,
                  account.currency,
                ),
          currency: account.currency,
          isHidden: _isBalanceHidden,
          onToggleVisibility: _toggleBalanceVisibility,
          onTap: () => context.go('${AppRouter.accountDetail}/${account.id}'),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      QuickActionData(
        icon: Icons.swap_horiz,
        label: 'Transfer',
        onTap: () => context.go(AppRouter.transfers),
      ),
      QuickActionData(
        icon: Icons.receipt,
        label: 'Pay Bills',
        onTap: () => context.go(AppRouter.billPay),
      ),
      QuickActionData(
        icon: Icons.phone_android,
        label: 'Top Up',
        onTap: () => context.go(AppRouter.topUp),
      ),
      QuickActionData(
        icon: Icons.qr_code,
        label: 'Scan QR',
        onTap: () => context.go(AppRouter.qrPay),
      ),
      QuickActionData(
        icon: Icons.request_quote,
        label: 'Request',
        onTap: () {},
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 0.8,
        crossAxisSpacing: AppTheme.spacing8,
        mainAxisSpacing: AppTheme.spacing8,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return QuickActionButton(data: actions[index]);
      },
    );
  }

  Widget _buildRecentTransactions() {
    if (_isLoading) {
      return Column(
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(AppTheme.radius12),
            ),
          ),
        ),
      );
    }

    if (_recentTransactions.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppTheme.spacing32),
        child: Column(
          children: [
            Icon(Icons.receipt_long, size: 64, color: Colors.grey[400]),
            const SizedBox(height: AppTheme.spacing16),
            Text(
              'No recent transactions',
              style: AppTheme.bodyLarge.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return Column(
      children: _recentTransactions.map((transaction) {
        return TransactionTile(
          title: transaction.title,
          subtitle: transaction.subtitle,
          amount: transaction.amount,
          currency: transaction.currency,
          date: DateFormatter.formatTransactionDate(transaction.date),
          type: transaction.type,
          icon: transaction.icon != null
              ? _getIconFromString(transaction.icon!)
              : null,
          onTap: () {},
        );
      }).toList(),
    );
  }

  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'arrow_downward':
        return Icons.arrow_downward;
      case 'arrow_upward':
        return Icons.arrow_upward;
      case 'swap_horiz':
        return Icons.swap_horiz;
      case 'receipt':
        return Icons.receipt;
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'atm':
        return Icons.atm;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'trending_up':
        return Icons.trending_up;
      case 'phone_android':
        return Icons.phone_android;
      default:
        return Icons.receipt;
    }
  }
}

class QuickActionData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  QuickActionData({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
