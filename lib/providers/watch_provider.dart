import 'package:flutter/material.dart';
import '../models/watch_model.dart';
import '../data/static_data.dart';

class WatchProvider extends ChangeNotifier {
  List<WatchModel> _watches = [];
  List<WatchModel> _filteredWatches = [];
  List<WatchModel> _myListings = [];
  List<WatchModel> _savedWatches = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedBrand = 'All Brands';
  String _selectedCondition = 'All Conditions';
  String _selectedPriceRange = 'All Prices';
  String _selectedYear = 'All Years';

  List<WatchModel> get watches => _filteredWatches;
  List<WatchModel> get myListings => _myListings;
  List<WatchModel> get savedWatches => _savedWatches;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String get selectedBrand => _selectedBrand;
  String get selectedCondition => _selectedCondition;
  String get selectedPriceRange => _selectedPriceRange;
  String get selectedYear => _selectedYear;

  WatchProvider() {
    loadWatches();
  }

  Future<void> loadWatches() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _watches = List.from(StaticData.watches);
    _filteredWatches = List.from(_watches);
    _savedWatches = _watches.where((w) => w.isFavorite).toList();
    _myListings = _watches.take(2).toList();
    
    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setFilter({
    String? brand,
    String? condition,
    String? priceRange,
    String? year,
  }) {
    if (brand != null) _selectedBrand = brand;
    if (condition != null) _selectedCondition = condition;
    if (priceRange != null) _selectedPriceRange = priceRange;
    if (year != null) _selectedYear = year;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredWatches = _watches.where((watch) {
      bool matchesSearch = _searchQuery.isEmpty ||
          watch.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          watch.model.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesBrand = _selectedBrand == 'All Brands' ||
          watch.brand == _selectedBrand;

      bool matchesCondition = _selectedCondition == 'All Conditions' ||
          watch.condition == _selectedCondition;

      bool matchesPrice = _matchesPriceRange(watch.price);
      bool matchesYear = _matchesYear(watch.year);

      return matchesSearch && matchesBrand && matchesCondition && matchesPrice && matchesYear;
    }).toList();

    notifyListeners();
  }

  bool _matchesPriceRange(double price) {
    switch (_selectedPriceRange) {
      case 'Under \$5,000':
        return price < 5000;
      case '\$5,000 - \$10,000':
        return price >= 5000 && price < 10000;
      case '\$10,000 - \$25,000':
        return price >= 10000 && price < 25000;
      case '\$25,000 - \$50,000':
        return price >= 25000 && price < 50000;
      case '\$50,000 - \$100,000':
        return price >= 50000 && price < 100000;
      case 'Over \$100,000':
        return price >= 100000;
      default:
        return true;
    }
  }

  bool _matchesYear(int year) {
    switch (_selectedYear) {
      case '2024':
        return year == 2024;
      case '2023':
        return year == 2023;
      case '2022':
        return year == 2022;
      case '2021':
        return year == 2021;
      case '2020':
        return year == 2020;
      case '2015-2019':
        return year >= 2015 && year <= 2019;
      case '2010-2014':
        return year >= 2010 && year <= 2014;
      case 'Before 2010':
        return year < 2010;
      default:
        return true;
    }
  }

  void toggleFavorite(String watchId) {
    final index = _watches.indexWhere((w) => w.id == watchId);
    if (index != -1) {
      _watches[index] = _watches[index].copyWith(
        isFavorite: !_watches[index].isFavorite,
      );
      _savedWatches = _watches.where((w) => w.isFavorite).toList();
      _applyFilters();
    }
  }

  void addListing(WatchModel watch) {
    _watches.insert(0, watch);
    _myListings.insert(0, watch);
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedBrand = 'All Brands';
    _selectedCondition = 'All Conditions';
    _selectedPriceRange = 'All Prices';
    _selectedYear = 'All Years';
    _filteredWatches = List.from(_watches);
    notifyListeners();
  }
}