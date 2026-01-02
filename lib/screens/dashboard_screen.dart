import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../config/app_theme.dart';
import '../config/app_routes.dart';
import '../providers/watch_provider.dart';
import '../data/static_data.dart';
import '../widgets/watch_card.dart';
import '../widgets/filter_dropdown.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showAddListingDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddListingSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'LUXEWATCH',
          style: GoogleFonts.playfairDisplay(
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  _showNotificationsSheet();
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.profileSettings);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade800),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Search watches...',
                      hintStyle: TextStyle(color: AppTheme.textSecondary),
                      prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showFilters ? Icons.filter_list_off : Icons.filter_list,
                          color: AppTheme.primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _showFilters = !_showFilters;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    onChanged: (value) {
                      Provider.of<WatchProvider>(context, listen: false)
                          .search(value);
                    },
                  ),
                ),
                if (_showFilters) ...[                  const SizedBox(height: 12),
                  Consumer<WatchProvider>(
                    builder: (context, watchProvider, child) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FilterDropdown(
                                  label: 'Brand',
                                  value: watchProvider.selectedBrand,
                                  items: StaticData.brands,
                                  onChanged: (value) {
                                    watchProvider.setFilter(brand: value);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: FilterDropdown(
                                  label: 'Condition',
                                  value: watchProvider.selectedCondition,
                                  items: StaticData.conditions,
                                  onChanged: (value) {
                                    watchProvider.setFilter(condition: value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: FilterDropdown(
                                  label: 'Price',
                                  value: watchProvider.selectedPriceRange,
                                  items: StaticData.priceRanges,
                                  onChanged: (value) {
                                    watchProvider.setFilter(priceRange: value);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: FilterDropdown(
                                  label: 'Year',
                                  value: watchProvider.selectedYear,
                                  items: StaticData.years,
                                  onChanged: (value) {
                                    watchProvider.setFilter(year: value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              watchProvider.clearFilters();
                              _searchController.clear();
                            },
                            child: const Text('Clear All Filters'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade800),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: AppTheme.textSecondary,
              indicatorColor: AppTheme.primaryColor,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Trending'),
                Tab(text: 'My Listings'),
                Tab(text: 'Saved'),
                Tab(text: 'Alerts'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTrendingTab(),
                _buildMyListingsTab(),
                _buildSavedTab(),
                _buildAlertsTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddListingDialog,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: AppTheme.backgroundColor),
      ),
    );
  }

  Widget _buildTrendingTab() {
    return Consumer<WatchProvider>(
      builder: (context, watchProvider, child) {
        if (watchProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor),
          );
        }

        if (watchProvider.watches.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: AppTheme.textSecondary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No watches found',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your filters',
                  style: TextStyle(
                    color: AppTheme.textSecondary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        }

        return AnimationLimiter(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: watchProvider.watches.length,
            itemBuilder: (context, index) {
              final watch = watchProvider.watches[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                duration: const Duration(milliseconds: 500),
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: WatchCard(
                      watch: watch,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.watchDetails,
                          arguments: watch,
                        );
                      },
                      onFavoriteToggle: () {
                        watchProvider.toggleFavorite(watch.id);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMyListingsTab() {
    return Consumer<WatchProvider>(
      builder: (context, watchProvider, child) {
        if (watchProvider.myListings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.watch_outlined,
                  size: 64,
                  color: AppTheme.textSecondary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No listings yet',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _showAddListingDialog,
                  child: const Text('Create Your First Listing'),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: watchProvider.myListings.length,
          itemBuilder: (context, index) {
            final watch = watchProvider.myListings[index];
            return WatchCard(
              watch: watch,
              showFavoriteButton: false,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.watchDetails,
                  arguments: watch,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildSavedTab() {
    return Consumer<WatchProvider>(
      builder: (context, watchProvider, child) {
        if (watchProvider.savedWatches.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_outline,
                  size: 64,
                  color: AppTheme.textSecondary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No saved watches',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the heart icon to save watches',
                  style: TextStyle(
                    color: AppTheme.textSecondary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: watchProvider.savedWatches.length,
          itemBuilder: (context, index) {
            final watch = watchProvider.savedWatches[index];
            return WatchCard(
              watch: watch,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.watchDetails,
                  arguments: watch,
                );
              },
              onFavoriteToggle: () {
                watchProvider.toggleFavorite(watch.id);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildAlertsTab() {
    final notifications = StaticData.notifications;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification['isRead']
                ? AppTheme.surfaceColor
                : AppTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: !notification['isRead']
                ? Border.all(color: AppTheme.primaryColor.withOpacity(0.3))
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification['title'],
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['message'],
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['time'],
                      style: TextStyle(
                        color: AppTheme.textSecondary.withOpacity(0.7),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNotificationsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Notifications',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              ...StaticData.notifications.take(3).map((notification) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    notification['title'],
                    style: const TextStyle(color: AppTheme.textPrimary),
                  ),
                  subtitle: Text(
                    notification['time'],
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class AddListingSheet extends StatefulWidget {
  const AddListingSheet({super.key});

  @override
  State<AddListingSheet> createState() => _AddListingSheetState();
}

class _AddListingSheetState extends State<AddListingSheet> {
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCondition = 'Excellent';
  int _selectedYear = 2023;

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Create New Listing',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _brandController,
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Brand',
                hintText: 'e.g., Rolex, Omega',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _modelController,
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Model',
                hintText: 'e.g., Submariner, Speedmaster',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCondition,
                    dropdownColor: AppTheme.surfaceColor,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: const InputDecoration(labelText: 'Condition'),
                    items: StaticData.conditions
                        .where((c) => c != 'All Conditions')
                        .map((condition) {
                      return DropdownMenuItem(
                        value: condition,
                        child: Text(condition),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCondition = value;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedYear,
                    dropdownColor: AppTheme.surfaceColor,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: const InputDecoration(labelText: 'Year'),
                    items: List.generate(25, (index) => 2024 - index)
                        .map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedYear = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              style: const TextStyle(color: AppTheme.textPrimary),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price (USD)',
                prefixText: '\$ ',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              style: const TextStyle(color: AppTheme.textPrimary),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Describe your watch...',
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade800,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 32,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add Photos',
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Listing created successfully!'),
                      backgroundColor: AppTheme.primaryColor,
                    ),
                  );
                },
                child: const Text('Create Listing'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}