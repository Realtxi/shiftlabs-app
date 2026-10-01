import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "../../core/theme/app_theme.dart";
import "../../core/utils/icon_mapper.dart";

class CategoryFilterBar extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onSelectCategory;
  final Map<String, int> counts;
  final String langCode;

  const CategoryFilterBar({
    super.key,
    required this.selectedCategory,
    required this.onSelectCategory,
    required this.counts,
    required this.langCode,
  });

  static const List<Map<String, String>> _categoriesTr = [
    {"id": "all", "label": "Tümü", "icon": "sparkles"},
    {"id": "developer", "label": "Geliştirici & Kod", "icon": "code"},
    {"id": "image", "label": "Görsel & Tasarım", "icon": "palette"},
    {"id": "video", "label": "Video & Medya", "icon": "video"},
    {"id": "audio", "label": "Ses & Müzik", "icon": "music"},
    {"id": "social", "label": "Sosyal Medya", "icon": "share2"},
    {"id": "document", "label": "Belge & PDF", "icon": "filetext"},
    {"id": "text", "label": "Metin & Çeviri", "icon": "type"},
    {"id": "utility", "label": "Faydalı Araçlar", "icon": "calculator"},
    {"id": "web", "label": "Web & SEO", "icon": "globe"},
  ];

  static const List<Map<String, String>> _categoriesEn = [
    {"id": "all", "label": "All Tools", "icon": "sparkles"},
    {"id": "developer", "label": "Developer & Code", "icon": "code"},
    {"id": "image", "label": "Image & Design", "icon": "palette"},
    {"id": "video", "label": "Video & Media", "icon": "video"},
    {"id": "audio", "label": "Audio & Sound", "icon": "music"},
    {"id": "social", "label": "Social Media", "icon": "share2"},
    {"id": "document", "label": "Document & PDF", "icon": "filetext"},
    {"id": "text", "label": "Text & Strings", "icon": "type"},
    {"id": "utility", "label": "Utilities & Math", "icon": "calculator"},
    {"id": "web", "label": "Web & SEO", "icon": "globe"},
  ];

  @override
  Widget build(BuildContext context) {
    final list = langCode == "en" ? _categoriesEn : _categoriesTr;

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = list[index];
          final id = cat["id"]!;
          final isSelected = selectedCategory.toLowerCase() == id.toLowerCase();
          final count = counts[id] ?? 0;
          final catColor = id == "all"
              ? AppColors.primary
              : IconMapper.getCategoryColor(id);

          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onSelectCategory(id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? catColor.withValues(alpha: 0.2)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? catColor
                        : AppColors.border,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      IconMapper.getIcon(cat["icon"], id),
                      size: 15,
                      color: isSelected ? catColor : AppColors.textMuted,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      cat["label"]!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                      ),
                    ),
                    if (count > 0) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? catColor
                              : AppColors.card,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "$count",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : AppColors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
