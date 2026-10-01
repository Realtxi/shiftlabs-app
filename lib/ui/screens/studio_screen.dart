import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "../../core/theme/app_theme.dart";
import "../../core/utils/url_utils.dart";
import "../view_models/app_view_model.dart";

class StudioScreen extends StatefulWidget {
  final AppViewModel viewModel;

  const StudioScreen({super.key, required this.viewModel});

  @override
  State<StudioScreen> createState() => _StudioScreenState();
}

class _StudioScreenState extends State<StudioScreen> {
  String selectedAspectRatio = "16:9";
  String selectedLut = "teal-orange";
  String selectedTextPreset = "mrbeast";
  bool isRgbSplitEnabled = true;
  bool isFilmGrainEnabled = false;
  bool isScanlinesEnabled = false;
  bool isPlaying = false;
  double timelineProgress = 0.35; // 35% through timeline

  final List<Map<String, String>> luts = [
    {"id": "teal-orange", "name": "Teal & Orange", "desc": "Hollywood Blockbuster"},
    {"id": "kodak-2383", "name": "Kodak 2383", "desc": "Analog 35mm Film Print"},
    {"id": "matrix-green", "name": "Matrix Green", "desc": "Cyberpunk Dystopia"},
    {"id": "blade-runner", "name": "Blade Runner", "desc": "Neon Amber High-Contrast"},
    {"id": "noir-film", "name": "Film Noir", "desc": "High Contrast Monochrome"},
    {"id": "cyberpunk", "name": "Cyberpunk 2077", "desc": "Ultra Violet / Neon Pink"},
  ];

  final List<Map<String, String>> typographyPresets = [
    {"id": "mrbeast", "name": "MrBeast Karaoke", "style": "Sarı-Siyah Kalın Kontur"},
    {"id": "lower-third", "name": "Lower Third", "style": "Minimal Yayıncı Kartı"},
    {"id": "glitch", "name": "Cyber Glitch", "style": "Bozulma & Neon Efekti"},
    {"id": "cinematic", "name": "Cinematic Serif", "style": "Klasik Film Yazı Tipi"},
  ];

  void _openFullWebStudio() {
    final lang = widget.viewModel.language;
    UrlUtils.openUrl("https://shiftlabs.co/$lang/studio");
  }

  @override
  Widget build(BuildContext context) {
    final isEn = widget.viewModel.language == "en";

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Studio Header Banner
          _buildHeaderBanner(isEn),
          const SizedBox(height: 16),
          // Main Studio Workbench Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildMonitorAndTimeline(isEn)),
                    const SizedBox(width: 16),
                    Expanded(flex: 2, child: _buildInspectorPanel(isEn)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildMonitorAndTimeline(isEn),
                    const SizedBox(height: 16),
                    _buildInspectorPanel(isEn),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 24),
          // Studio Related Tools
          _buildStudioTools(isEn),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeaderBanner(bool isEn) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E1B4B),
            Color(0xFF2E1065),
            Color(0xFF0F172A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.movie_filter_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "PRO VIDEO SUITE",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Shiftlabs Studio Pro",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  isEn
                      ? "Hybrid Premiere & After Effects client-side video editor. Multi-track SMPTE timeline, Hollywood Lumetri LUTs, and WebM 1080p 60fps export."
                      : "Premiere & After Effects hibrit istemci taraflı video stüdyosu. Çok kanallı SMPTE timeline, Hollywood Lumetri LUT'ları ve 1080p WebM dışa aktarım.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    color: Colors.white70,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.open_in_new_rounded, size: 18),
            label: Text(
              isEn ? "Open Web Studio" : "Tam Ekran Web Studio",
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            onPressed: _openFullWebStudio,
          ),
        ],
      ),
    );
  }

  Widget _buildMonitorAndTimeline(bool isEn) {
    return Column(
      children: [
        // Preview Monitor
        Container(
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Monitor Canvas Background
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.video_library_rounded,
                      size: 48,
                      color: AppColors.primary.withValues(alpha: 0.6),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isEn
                          ? "Preview Monitor [1080p 60fps SMPTE]"
                          : "Önizleme Monitörü [1080p 60fps SMPTE]",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "LUT: ${selectedLut.toUpperCase()} | ASPECT: $selectedAspectRatio",
                      style: GoogleFonts.spaceMono(
                        fontSize: 11,
                        color: AppColors.accentCyan,
                      ),
                    ),
                  ],
                ),
              ),
              // Top Overlay Controls
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        "00:01:24:18",
                        style: GoogleFonts.spaceMono(
                          color: AppColors.accentEmerald,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _buildAspectPill("16:9"),
                        const SizedBox(width: 6),
                        _buildAspectPill("9:16"),
                        const SizedBox(width: 6),
                        _buildAspectPill("1:1"),
                      ],
                    ),
                  ],
                ),
              ),
              // Bottom Transport Controls
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous_rounded),
                        color: Colors.white70,
                        iconSize: 20,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.fast_rewind_rounded),
                        color: Colors.white70,
                        iconSize: 20,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                        ),
                        color: AppColors.primary,
                        iconSize: 36,
                        onPressed: () => setState(() => isPlaying = !isPlaying),
                      ),
                      IconButton(
                        icon: const Icon(Icons.fast_forward_rounded),
                        color: Colors.white70,
                        iconSize: 20,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next_rounded),
                        color: Colors.white70,
                        iconSize: 20,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Multi-Track Timeline
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEn ? "Multi-Track Timeline (T1, V1, A1, A2)" : "Çok Kanallı Zaman Çizgisi",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    "J / K / L Shuttle Shortcuts",
                    style: GoogleFonts.spaceMono(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Track T1 (Text & Titles)
              _buildTimelineTrack("T1", "Kinetic Subtitles & Lower Thirds", AppColors.secondary, 0.7),
              const SizedBox(height: 6),
              // Track V1 (Video Cuts)
              _buildTimelineTrack("V1", "Main Video Footage (1080p)", AppColors.primary, 0.9),
              const SizedBox(height: 6),
              // Track A1 (Voice / Dialogue)
              _buildTimelineTrack("A1", "Voiceover Dialogue (48kHz)", AppColors.accentCyan, 0.85),
              const SizedBox(height: 6),
              // Track A2 (Music & Ducking)
              _buildTimelineTrack("A2", "Cyberpunk BGM (Auto Ducking)", AppColors.accentEmerald, 0.95),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineTrack(String label, String name, Color trackColor, double widthFactor) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border, width: 0.8),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: trackColor.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(
              label,
              style: GoogleFonts.spaceMono(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: trackColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: trackColor.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: trackColor.withValues(alpha: 0.5)),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspectorPanel(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEn ? "Hollywood Lumetri LUT Engine" : "Hollywood Lumetri LUT Motoru",
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          // LUT Selector List
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: luts.map((lut) {
              final isSel = selectedLut == lut["id"];
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => setState(() => selectedLut = lut["id"]!),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSel ? AppColors.secondary.withValues(alpha: 0.2) : AppColors.card,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSel ? AppColors.secondary : AppColors.border,
                      width: isSel ? 1.5 : 1,
                    ),
                  ),
                  child: Text(
                    lut["name"]!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
                      color: isSel ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border),
          const SizedBox(height: 12),
          Text(
            isEn ? "Shader & VFX Stack" : "Shader & VFX Efekt Katmanı",
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          _buildVfxSwitch(
            title: "RGB Split Chromatic Aberration",
            desc: "3-Kanal renk kayması ve prizma etkisi",
            value: isRgbSplitEnabled,
            onChanged: (v) => setState(() => isRgbSplitEnabled = v),
          ),
          _buildVfxSwitch(
            title: "CRT Retro Scanlines",
            desc: "Retro televizyon tarama çizgileri",
            value: isScanlinesEnabled,
            onChanged: (v) => setState(() => isScanlinesEnabled = v),
          ),
          _buildVfxSwitch(
            title: "35mm Analog Film Grain",
            desc: "Organik film greni ve dokusu",
            value: isFilmGrainEnabled,
            onChanged: (v) => setState(() => isFilmGrainEnabled = v),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border),
          const SizedBox(height: 12),
          Text(
            isEn ? "Kinetic Typography" : "Kinetik Tipografi Presets",
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: typographyPresets.map((preset) {
              final isSel = selectedTextPreset == preset["id"];
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  isSel ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                  color: isSel ? AppColors.primary : AppColors.textMuted,
                  size: 18,
                ),
                title: Text(
                  preset["name"]!,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  preset["style"]!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                onTap: () => setState(() => selectedTextPreset = preset["id"]!),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.rocket_launch_rounded, size: 18),
              label: Text(
                isEn ? "Launch Studio Engine" : "Studio Motorunu Başlat",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              onPressed: _openFullWebStudio,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAspectPill(String ratio) {
    final isSel = selectedAspectRatio == ratio;
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => setState(() => selectedAspectRatio = ratio),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSel ? AppColors.primary : Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSel ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          ratio,
          style: GoogleFonts.spaceMono(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildVfxSwitch({
    required String title,
    required String desc,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  desc,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
            inactiveThumbColor: AppColors.textMuted,
            inactiveTrackColor: AppColors.card,
          ),
        ],
      ),
    );
  }

  Widget _buildStudioTools(bool isEn) {
    final videoTools = [
      {
        "title": isEn ? "Video FPS Calculator" : "Video FPS & Frame Hesaplayıcı",
        "desc": isEn ? "Calculate exact frames at 24/30/60/120 fps" : "24/30/60/120 fps için tam kare sayısı hesaplayın",
        "slug": "video-fps-calculator",
        "cat": "video",
      },
      {
        "title": isEn ? "Video Bitrate & Size" : "Video Bitrate & Dosya Boyutu",
        "desc": isEn ? "Estimate target output file size in MB" : "Süre ve Mbps bitrate'ine göre tahmini boyut",
        "slug": "video-bitrate-calculator",
        "cat": "video",
      },
      {
        "title": isEn ? "SRT Subtitle Maker" : "SRT Altyazı Oluşturucu",
        "desc": isEn ? "Generate synchronized .srt files" : "Zaman damgalı profesyonel SRT altyazı dosyaları",
        "slug": "srt-subtitle-generator",
        "cat": "video",
      },
      {
        "title": isEn ? "TikTok & Reels Script" : "TikTok & Reels CapCut Senaryosu",
        "desc": isEn ? "Viral short video templates (Hook, Body, CTA)" : "Kanca, Gövde ve Eylem Çağrısı ile viral şablonlar",
        "slug": "tiktok-script-generator",
        "cat": "social",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEn ? "Studio Companion Tools" : "Studio Yardımcı Araçları",
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 360,
            mainAxisExtent: 90,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: videoTools.length,
          itemBuilder: (context, index) {
            final t = videoTools[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: InkWell(
                onTap: () {
                  final lang = widget.viewModel.language;
                  UrlUtils.openUrl("https://shiftlabs.co/$lang/tools/${t["cat"]}/${t["slug"]}");
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.movie_creation_outlined, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t["title"]!,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            t["desc"]!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: AppColors.textMuted),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
