import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "../../core/theme/app_theme.dart";
import "../../data/models/tool_model.dart";
import "../view_models/app_view_model.dart";
import "../widgets/category_filter_bar.dart";
import "../widgets/search_bar_widget.dart";
import "../widgets/tool_card.dart";
import "tool_detail_screen.dart";

class ToolsCatalogScreen extends StatefulWidget {
  final AppViewModel viewModel;

  const ToolsCatalogScreen({super.key, required this.viewModel});

  @override
  State<ToolsCatalogScreen> createState() => _ToolsCatalogScreenState();
}

class _ToolsCatalogScreenState extends State<ToolsCatalogScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.viewModel.searchQuery;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openToolDetail(ShiftTool tool) {
    widget.viewModel.recordToolClick(tool);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ToolDetailScreen(
          tool: tool,
          langCode: widget.viewModel.language,
          onToggleFavorite: () => widget.viewModel.toggleFavorite(tool),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;
    final isEn = vm.language == "en";
    final filtered = vm.filteredTools;

    if (vm.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          // Studio Spotlight Banner (if no active search)
          if (vm.searchQuery.isEmpty && vm.selectedCategory == "all") ...[
            _buildSpotlightBanner(context, isEn),
            const SizedBox(height: 14),
          ],
          // Search Bar
          SearchBarWidget(
            controller: _searchController,
            onChanged: (val) => vm.setSearchQuery(val),
            onClear: () => vm.clearSearch(),
            totalCount: vm.allTools.length,
            langCode: vm.language,
          ),
          const SizedBox(height: 12),
          // Category Selector Bar
          CategoryFilterBar(
            selectedCategory: vm.selectedCategory,
            onSelectCategory: (cat) => vm.setSelectedCategory(cat),
            counts: vm.categoryCounts,
            langCode: vm.language,
          ),
          const SizedBox(height: 14),
          // Results Header & Count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEn
                    ? "Showing ${filtered.length} of ${vm.allTools.length} tools"
                    : "${vm.allTools.length} araçtan ${filtered.length} tanesi gösteriliyor",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
              if (vm.searchQuery.isNotEmpty || vm.selectedCategory != "all")
                TextButton(
                  onPressed: () {
                    _searchController.clear();
                    vm.clearSearch();
                    vm.setSelectedCategory("all");
                  },
                  child: Text(
                    isEn ? "Reset Filters" : "Filtreleri Sıfırla",
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // Responsive Tools Grid
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState(isEn)
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 24),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 380,
                      mainAxisExtent: 175,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final tool = filtered[index];
                      return ToolCard(
                        tool: tool,
                        langCode: vm.language,
                        onTap: () => _openToolDetail(tool),
                        onToggleFavorite: () => vm.toggleFavorite(tool),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpotlightBanner(BuildContext context, bool isEn) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E1B4B), // Deep Indigo
            Color(0xFF31102B), // Deep Rose/Plum
            Color(0xFF0F172A), // Slate
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.movie_creation_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "YENİ V2.0",
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Shiftlabs Studio",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  isEn
                      ? "Premiere & After Effects hybrid editor with multi-track timeline, Hollywood LUTs & kinetic subtitles."
                      : "Premiere & After Effects hibrit video editörü: Çok kanallı timeline, Hollywood LUT filtreleri ve kinetik altyazı.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: Colors.white70,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
            icon: const Icon(Icons.play_arrow_rounded, size: 18),
            label: Text(
              isEn ? "Open Studio" : "Studio Aç",
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 12.5,
              ),
            ),
            onPressed: () => widget.viewModel.setTabIndex(1),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isEn) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: AppColors.textMuted,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isEn ? "No tools found" : "Aradığınız kriterlere uygun araç bulunamadı",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isEn
                ? "Try searching with different keywords or reset categories."
                : "Farklı anahtar kelimeler deneyin veya filtreleri temizleyin.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
