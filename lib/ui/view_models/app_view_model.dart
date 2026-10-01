import "package:flutter/material.dart";
import "../../data/models/tool_model.dart";
import "../../data/repositories/tool_repository.dart";
import "../../data/services/storage_service.dart";

class AppViewModel extends ChangeNotifier {
  final ToolRepository toolRepository;
  final StorageService storageService;

  bool _isLoading = true;
  List<ShiftTool> _allTools = [];
  String _selectedCategory = "all";
  String _searchQuery = "";
  String _language = "tr";
  int _currentTabIndex = 0;
  List<String> _recentToolIds = [];

  AppViewModel({
    required this.toolRepository,
    required this.storageService,
  });

  bool get isLoading => _isLoading;
  List<ShiftTool> get allTools => _allTools;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String get language => _language;
  int get currentTabIndex => _currentTabIndex;
  List<String> get recentToolIds => _recentToolIds;

  List<ShiftTool> get filteredTools {
    return toolRepository.filterTools(
      allTools: _allTools,
      category: _selectedCategory,
      query: _searchQuery,
      langCode: _language,
    );
  }

  List<ShiftTool> get favoriteTools {
    return _allTools.where((tool) => tool.isFavorite).toList();
  }

  List<ShiftTool> get recentTools {
    final map = {for (var t in _allTools) t.id: t};
    return _recentToolIds
        .map((id) => map[id])
        .where((t) => t != null)
        .cast<ShiftTool>()
        .toList();
  }

  Map<String, int> get categoryCounts {
    final counts = <String, int>{"all": _allTools.length};
    for (final tool in _allTools) {
      final cat = tool.category.toLowerCase();
      counts[cat] = (counts[cat] ?? 0) + 1;
    }
    return counts;
  }

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _language = await storageService.getLanguage();
    _recentToolIds = await storageService.getRecentToolIds();
    _allTools = await toolRepository.loadTools();

    _isLoading = false;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = "";
    notifyListeners();
  }

  void setTabIndex(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(ShiftTool tool) async {
    await toolRepository.toggleFavorite(tool);
    notifyListeners();
  }

  Future<void> setLanguage(String lang) async {
    if (_language != lang) {
      _language = lang;
      await storageService.setLanguage(lang);
      notifyListeners();
    }
  }

  Future<void> recordToolClick(ShiftTool tool) async {
    await storageService.addRecentTool(tool.id);
    _recentToolIds = await storageService.getRecentToolIds();
    notifyListeners();
  }
}
