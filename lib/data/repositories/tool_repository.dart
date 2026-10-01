import "dart:convert";
import "package:flutter/services.dart";
import "../models/tool_model.dart";
import "../services/storage_service.dart";

class ToolRepository {
  final StorageService storageService;
  List<ShiftTool> _cachedTools = [];

  ToolRepository({required this.storageService});

  Future<List<ShiftTool>> loadTools() async {
    if (_cachedTools.isNotEmpty) {
      return _cachedTools;
    }

    try {
      final jsonString = await rootBundle.loadString("assets/data/tools.json");
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      final favoriteIds = await storageService.getFavoriteIds();

      _cachedTools = jsonList.map((item) {
        final tool = ShiftTool.fromJson(item as Map<String, dynamic>);
        tool.isFavorite = favoriteIds.contains(tool.id);
        return tool;
      }).toList();

      return _cachedTools;
    } catch (e) {
      return [];
    }
  }

  Future<void> toggleFavorite(ShiftTool tool) async {
    await storageService.toggleFavorite(tool.id);
    tool.isFavorite = !tool.isFavorite;
  }

  List<ShiftTool> filterTools({
    required List<ShiftTool> allTools,
    required String category,
    required String query,
    required String langCode,
  }) {
    final lowerQuery = query.trim().toLowerCase();

    return allTools.where((tool) {
      final matchCategory =
          category == "all" || tool.category.toLowerCase() == category.toLowerCase();

      if (!matchCategory) return false;

      if (lowerQuery.isEmpty) return true;

      final title = tool.getTitle(langCode).toLowerCase();
      final subtitle = tool.getSubtitle(langCode).toLowerCase();
      final slug = tool.slug.toLowerCase();
      final badge = tool.badge.toLowerCase();

      return title.contains(lowerQuery) ||
          subtitle.contains(lowerQuery) ||
          slug.contains(lowerQuery) ||
          badge.contains(lowerQuery);
    }).toList();
  }
}
