import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/balance_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/chip_filter.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/mock/account_repository.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../widgets/account_list_item.dart';

class AccountsScreen extends ConsumerStatefulWidget {
  const AccountsScreen({super.key});

  @override
  ConsumerState<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends ConsumerState<AccountsScreen> {
  bool _isLoading = true;
  List<Account> _accounts = [];
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final accounts = await AccountRepository.getAccounts();
      setState(() {
        _accounts = accounts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Account> get _filteredAccounts {
    switch (_selectedFilter) {
      case 'savings':
        return _accounts
            .where((account) => account.accountType == 'savings')
            .toList();
      case 'checking':
        return _accounts
            .where((account) => account.accountType == 'checking')
            .toList();
      case 'business':
        return _accounts
            .where((account) => account.accountType == 'business')
            .toList();
      default:
        return _accounts;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Accounts'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadAccounts),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: SingleChildScrollView(
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
                    label: 'Savings',
                    isSelected: _selectedFilter == 'savings',
                    onTap: () => setState(() => _selectedFilter = 'savings'),
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  ChipFilter(
                    label: 'Checking',
                    isSelected: _selectedFilter == 'checking',
                    onTap: () => setState(() => _selectedFilter = 'checking'),
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  ChipFilter(
                    label: 'Business',
                    isSelected: _selectedFilter == 'business',
                    onTap: () => setState(() => _selectedFilter = 'business'),
                  ),
                ],
              ),
            ),
          ),

          // Accounts list
          Expanded(
            child: _isLoading
                ? _buildLoadingState()
                : _filteredAccounts.isEmpty
                ? _buildEmptyState()
                : _buildAccountsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      itemCount: 3,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(AppTheme.radius16),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      title: 'No accounts found',
      subtitle: 'No accounts match your current filter',
      icon: Icons.account_balance_wallet,
      action: ElevatedButton(
        onPressed: () {},
        child: const Text('Open New Account'),
      ),
    );
  }

  Widget _buildAccountsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      itemCount: _filteredAccounts.length,
      itemBuilder: (context, index) {
        final account = _filteredAccounts[index];
        return AccountListItem(
          account: account,
          onTap: () {
            // Navigate to account detail
          },
        );
      },
    );
  }
}
