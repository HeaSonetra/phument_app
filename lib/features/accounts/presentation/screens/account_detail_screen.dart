import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/balance_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../../../core/widgets/chip_filter.dart';
import '../../../../core/mock/account_repository.dart';
import '../../../../core/mock/transaction_repository.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';

class AccountDetailScreen extends ConsumerStatefulWidget {
  final String accountId;

  const AccountDetailScreen({super.key, required this.accountId});

  @override
  ConsumerState<AccountDetailScreen> createState() =>
      _AccountDetailScreenState();
}

class _AccountDetailScreenState extends ConsumerState<AccountDetailScreen> {
  bool _isLoading = true;
  bool _isBalanceHidden = false;
  Account? _account;
  List<Transaction> _transactions = [];
  String _selectedFilter = 'all';
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _loadAccountData();
  }

  Future<void> _loadAccountData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final account = await AccountRepository.getAccountById(widget.accountId);
      final transactions = await TransactionRepository.getTransactionsByAccount(
        widget.accountId,
      );

      setState(() {
        _account = account;
        _transactions = transactions;
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

  List<Transaction> get _filteredTransactions {
    var filtered = _transactions;

    // Filter by type
    switch (_selectedFilter) {
      case 'credit':
        filtered = filtered
            .where((t) => t.type == TransactionType.credit)
            .toList();
        break;
      case 'debit':
        filtered = filtered
            .where((t) => t.type == TransactionType.debit)
            .toList();
        break;
      case 'transfer':
        filtered = filtered
            .where((t) => t.type == TransactionType.transfer)
            .toList();
        break;
      case 'bill':
        filtered = filtered
            .where((t) => t.type == TransactionType.bill)
            .toList();
        break;
    }

    // Filter by date range
    if (_selectedDateRange != null) {
      filtered = filtered.where((t) {
        return t.date.isAfter(_selectedDateRange!.start) &&
            t.date.isBefore(
              _selectedDateRange!.end.add(const Duration(days: 1)),
            );
      }).toList();
    }

    // Sort by date (newest first)
    filtered.sort((a, b) => b.date.compareTo(a.date));

    return filtered;
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Account Details'),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_account == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Account Details'),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: Text('Account not found')),
      );
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(_account!.accountName),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAccountData,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Account balance card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: BalanceCard(
                accountNumber: _account!.accountNumber,
                balance: _isBalanceHidden
                    ? '••••••'
                    : CurrencyFormatter.formatAmount(
                        _account!.balance,
                        _account!.currency,
                      ),
                currency: _account!.currency,
                isHidden: _isBalanceHidden,
                onToggleVisibility: _toggleBalanceVisibility,
              ),
            ),
          ),

          // Filters
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Transaction type filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ChipFilter(
                          label: 'All',
                          isSelected: _selectedFilter == 'all',
                          onTap: () => setState(() => _selectedFilter = 'all'),
                        ),
                        const SizedBox(width: AppTheme.spacing8),
                        ChipFilter(
                          label: 'Credit',
                          isSelected: _selectedFilter == 'credit',
                          onTap: () =>
                              setState(() => _selectedFilter = 'credit'),
                        ),
                        const SizedBox(width: AppTheme.spacing8),
                        ChipFilter(
                          label: 'Debit',
                          isSelected: _selectedFilter == 'debit',
                          onTap: () =>
                              setState(() => _selectedFilter = 'debit'),
                        ),
                        const SizedBox(width: AppTheme.spacing8),
                        ChipFilter(
                          label: 'Transfer',
                          isSelected: _selectedFilter == 'transfer',
                          onTap: () =>
                              setState(() => _selectedFilter = 'transfer'),
                        ),
                        const SizedBox(width: AppTheme.spacing8),
                        ChipFilter(
                          label: 'Bills',
                          isSelected: _selectedFilter == 'bill',
                          onTap: () => setState(() => _selectedFilter = 'bill'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacing16),

                  // Date range picker
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _selectDateRange,
                          icon: const Icon(Icons.calendar_today),
                          label: Text(
                            _selectedDateRange == null
                                ? 'Select Date Range'
                                : '${DateFormatter.formatDate(_selectedDateRange!.start)} - ${DateFormatter.formatDate(_selectedDateRange!.end)}',
                          ),
                        ),
                      ),
                      if (_selectedDateRange != null) ...[
                        const SizedBox(width: AppTheme.spacing8),
                        IconButton(
                          onPressed: () =>
                              setState(() => _selectedDateRange = null),
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Transactions header
          SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Transactions',
              subtitle: '${_filteredTransactions.length} transactions found',
            ),
          ),

          // Transactions list
          if (_filteredTransactions.isEmpty)
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacing32),
                child: Column(
                  children: [
                    Icon(Icons.receipt_long, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: AppTheme.spacing16),
                    Text(
                      'No transactions found',
                      style: AppTheme.bodyLarge.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    if (_selectedFilter != 'all' ||
                        _selectedDateRange != null) ...[
                      const SizedBox(height: AppTheme.spacing8),
                      Text(
                        'Try adjusting your filters',
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final transaction = _filteredTransactions[index];
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
              }, childCount: _filteredTransactions.length),
            ),
        ],
      ),
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
