import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "../../core/theme/app_theme.dart";
import "../../data/models/tool_model.dart";
import "../view_models/app_view_model.dart";
import "../widgets/tool_card.dart";
import "tool_detail_screen.dart";

class FavoritesScreen extends StatelessWidget {
  final AppViewModel viewModel;

  const FavoritesScreen({super.key, required this.viewModel});

  void _openToolDetail(BuildContext context, ShiftTool tool) {
    viewModel.recordToolClick(tool);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ToolDetailScreen(
          tool: tool,
          langCode: viewModel.language,
          onToggleFavorite: () => viewModel.toggleFavorite(tool),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEn = viewModel.language == "en";
    final favorites = viewModel.favoriteTools;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.star_rounded, color: Colors.amber, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEn ? "Favorite Tools" : "Favori Araçlarınız",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isEn
                        ? "${favorites.length} tools starred for quick access"
                        : "Hızlı erişim için yıldızladığınız ${favorites.length} araç",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: favorites.isEmpty
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
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final tool = favorites[index];
                      return ToolCard(
                        tool: tool,
                        langCode: viewModel.language,
                        onTap: () => _openToolDetail(context, tool),
                        onToggleFavorite: () => viewModel.toggleFavorite(tool),
                      );
                    },
                  ),
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
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.star_border_rounded,
              color: Colors.amber,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isEn ? "No favorites yet" : "Henüz favori araç eklemediniz",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isEn
                ? "Click the star icon on any tool card to save it here."
                : "Araç kartlarındaki yıldız simgesine tıklayarak favorilerinize ekleyin.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            icon: const Icon(Icons.grid_view_rounded, size: 18),
            label: Text(
              isEn ? "Browse All Tools" : "Tüm Araçları Keşfet",
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            onPressed: () => viewModel.setTabIndex(0),
          ),
        ],
      ),
    );
  }
}
