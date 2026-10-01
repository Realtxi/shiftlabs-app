import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "../../core/theme/app_theme.dart";
import "../../core/utils/url_utils.dart";
import "../view_models/app_view_model.dart";

class SettingsScreen extends StatelessWidget {
  final AppViewModel viewModel;

  const SettingsScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final isEn = viewModel.language == "en";

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.settings_rounded, color: AppColors.secondary, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEn ? "Settings & System" : "Ayarlar ve Sistem",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Shiftlabs v2.0 Pro Suite",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Language Card
          _buildCard(
            title: isEn ? "Language Preferences" : "Dil Tercihi",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEn ? "Application Language" : "Uygulama Dili",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isEn ? "Turkish or English UI" : "Türkçe ve İngilizce arayüz",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildLanguageChip(
                      label: "🇹🇷 Türkçe",
                      isSelected: !isEn,
                      onTap: () => viewModel.setLanguage("tr"),
                    ),
                    const SizedBox(width: 8),
                    _buildLanguageChip(
                      label: "🇬🇧 English",
                      isSelected: isEn,
                      onTap: () => viewModel.setLanguage("en"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // System Architecture Card
          _buildCard(
            title: isEn ? "Architecture & Privacy" : "Mimari ve Gizlilik Güvencesi",
            child: Column(
              children: [
                _buildInfoRow(
                  icon: Icons.shield_rounded,
                  color: AppColors.accentEmerald,
                  title: isEn ? "100% Client-Side Privacy" : "%100 İstemci Tarafı Gizlilik",
                  desc: isEn
                      ? "Files, images, and text never leave your device."
                      : "Dosyalar, görseller ve metinler sunucuya iletilmez, tamamen cihazınızda işlenir.",
                ),
                const Divider(color: AppColors.border, height: 20),
                _buildInfoRow(
                  icon: Icons.bolt_rounded,
                  color: AppColors.primary,
                  title: isEn ? "Total Integrated Tools" : "Toplam Entegre Araç",
                  desc: "${viewModel.allTools.length} ${isEn ? "production-grade tools" : "profesyonel araç"}",
                ),
                const Divider(color: AppColors.border, height: 20),
                _buildInfoRow(
                  icon: Icons.movie_filter_rounded,
                  color: AppColors.secondary,
                  title: "Shiftlabs Studio Pro",
                  desc: isEn
                      ? "Premiere & After Effects hybrid video timeline editor"
                      : "Premiere & After Effects hibrit çok kanallı video stüdyosu",
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Links Card
          _buildCard(
            title: isEn ? "Shiftlabs Ecosystem" : "Shiftlabs Ekosistemi",
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.language_rounded, color: AppColors.accentCyan),
                  title: Text(
                    "shiftlabs.co Canlı Web Sitesi",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    "https://shiftlabs.co",
                    style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                  ),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 16, color: AppColors.textMuted),
                  onTap: () => UrlUtils.openUrl("https://shiftlabs.co"),
                ),
                const Divider(color: AppColors.border, height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.code_rounded, color: AppColors.accentEmerald),
                  title: Text(
                    "GitHub Açık Kaynak / CI/CD",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    "https://github.com/Realtxi/shiftlabs",
                    style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                  ),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 16, color: AppColors.textMuted),
                  onTap: () => UrlUtils.openUrl("https://github.com/Realtxi/shiftlabs"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Version Info
          Center(
            child: Column(
              children: [
                Text(
                  "Shiftlabs Multiplatform v2.0.0",
                  style: GoogleFonts.spaceMono(
                    fontSize: 11.5,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Designed for macOS, Windows, iOS & Android",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 14.5,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildLanguageChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5,
                  color: AppColors.textMuted,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
