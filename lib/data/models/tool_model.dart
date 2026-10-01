class ShiftTool {
  final String id;
  final String slug;
  final String category;
  final String icon;
  final String titleTr;
  final String titleEn;
  final String subtitleTr;
  final String subtitleEn;
  final String badge;
  bool isFavorite;

  ShiftTool({
    required this.id,
    required this.slug,
    required this.category,
    required this.icon,
    required this.titleTr,
    required this.titleEn,
    required this.subtitleTr,
    required this.subtitleEn,
    required this.badge,
    this.isFavorite = false,
  });

  factory ShiftTool.fromJson(Map<String, dynamic> json) {
    return ShiftTool(
      id: json["id"] as String? ?? "",
      slug: json["slug"] as String? ?? "",
      category: json["category"] as String? ?? "utility",
      icon: json["icon"] as String? ?? "Sparkles",
      titleTr: json["titleTr"] as String? ?? "",
      titleEn: json["titleEn"] as String? ?? "",
      subtitleTr: json["subtitleTr"] as String? ?? "",
      subtitleEn: json["subtitleEn"] as String? ?? "",
      badge: json["badge"] as String? ?? "TOOL",
      isFavorite: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "slug": slug,
      "category": category,
      "icon": icon,
      "titleTr": titleTr,
      "titleEn": titleEn,
      "subtitleTr": subtitleTr,
      "subtitleEn": subtitleEn,
      "badge": badge,
    };
  }

  String getTitle(String langCode) {
    if (langCode == "en") {
      return titleEn.isNotEmpty ? titleEn : titleTr;
    }
    return titleTr.isNotEmpty ? titleTr : titleEn;
  }

  String getSubtitle(String langCode) {
    if (langCode == "en") {
      return subtitleEn.isNotEmpty ? subtitleEn : subtitleTr;
    }
    return subtitleTr.isNotEmpty ? subtitleTr : subtitleEn;
  }

  String getWebUrl(String langCode) {
    final lang = langCode == "en" ? "en" : "tr";
    return "https://shiftlabs.co/$lang/tools/$category/$slug";
  }
}
