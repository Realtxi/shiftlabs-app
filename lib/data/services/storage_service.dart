import "package:shared_preferences/shared_preferences.dart";

class StorageService {
  static const String _favoritesKey = "shiftlabs_favorites";
  static const String _languageKey = "shiftlabs_language";
  static const String _recentToolsKey = "shiftlabs_recent_tools";

  Future<Set<String>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_favoritesKey) ?? [];
    return list.toSet();
  }

  Future<void> toggleFavorite(String toolId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = (prefs.getStringList(_favoritesKey) ?? []).toSet();
    if (list.contains(toolId)) {
      list.remove(toolId);
    } else {
      list.add(toolId);
    }
    await prefs.setStringList(_favoritesKey, list.toList());
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? "tr";
  }

  Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, lang);
  }

  Future<List<String>> getRecentToolIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentToolsKey) ?? [];
  }

  Future<void> addRecentTool(String toolId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_recentToolsKey) ?? [];
    list.remove(toolId);
    list.insert(0, toolId);
    if (list.length > 20) {
      list.removeLast();
    }
    await prefs.setStringList(_recentToolsKey, list);
  }
}
