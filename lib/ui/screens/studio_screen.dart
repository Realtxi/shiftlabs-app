import "dart:math" as math;
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:google_fonts/google_fonts.dart";
import "../../core/theme/app_theme.dart";
import "../../core/utils/url_utils.dart";
import "../view_models/app_view_model.dart";

class StudioItem {
  final String id;
  final String titleTr;
  final String titleEn;
  final String badge;
  final IconData icon;
  final Color accentColor;
  final List<Color> gradient;
  final String route;
  final String descTr;
  final String descEn;
  final List<String> tags;

  const StudioItem({
    required this.id,
    required this.titleTr,
    required this.titleEn,
    required this.badge,
    required this.icon,
    required this.accentColor,
    required this.gradient,
    required this.route,
    required this.descTr,
    required this.descEn,
    required this.tags,
  });
}

class StudioScreen extends StatefulWidget {
  final AppViewModel viewModel;

  const StudioScreen({super.key, required this.viewModel});

  @override
  State<StudioScreen> createState() => _StudioScreenState();
}

class _StudioScreenState extends State<StudioScreen> {
  int _selectedStudioIndex = 0;

  // Video Studio State
  String _selectedAspectRatio = "16:9";
  String _selectedLut = "teal-orange";
  bool _isPlaying = false;

  // Batch Studio State
  String _batchFormat = "WebP";
  double _batchQuality = 85.0;
  final TextEditingController _batchWatermarkCtrl = TextEditingController(text: "Shiftlabs");
  bool _isBatchProcessing = false;

  // Data Studio State
  String _chartType = "bar";

  // 3D Studio State
  String _geo3d = "Torus Knot";
  bool _wireframe3d = true;
  static const Color _color3d = AppColors.secondaryLight;

  // Vault Studio State
  final TextEditingController _vaultPasswordCtrl = TextEditingController(text: "Kripto!Master#99");

  // Screen Recorder State
  bool _isRecording = false;

  // Network Suite State
  bool _isTestingPing = false;

  // Code Playground State
  String _codeLanguage = "HTML";
  final TextEditingController _codeCtrl = TextEditingController(
    text: "<div class=\"hero\">\n  <h1>Shiftlabs v2.0</h1>\n  <p>100% Client-Side Power</p>\n</div>",
  );

  // QR Hub State
  final TextEditingController _qrDataCtrl = TextEditingController(text: "https://shiftlabs.co");

  // API Lab State
  final TextEditingController _apiUrlCtrl = TextEditingController(text: "https://shiftlabs.co/api/v1/mock/ping");

  @override
  void dispose() {
    _batchWatermarkCtrl.dispose();
    _vaultPasswordCtrl.dispose();
    _codeCtrl.dispose();
    _qrDataCtrl.dispose();
    _apiUrlCtrl.dispose();
    super.dispose();
  }

  final List<StudioItem> _studios = [
    const StudioItem(
      id: "video",
      titleTr: "Video Studio Pro",
      titleEn: "Video Studio Pro",
      badge: "PRO SUITE",
      icon: Icons.movie_filter_rounded,
      accentColor: AppColors.primary,
      gradient: [Color(0xFF1E1B4B), Color(0xFF2E1065), Color(0xFF0F172A)],
      route: "studio",
      descTr: "Hibrit Premiere & After Effects istemci taraflı video stüdyosu. Çok kanallı SMPTE timeline, Hollywood Lumetri LUT'ları ve 1080p WebM dışa aktarım.",
      descEn: "Hybrid Premiere & After Effects client-side video editor. Multi-track SMPTE timeline, Hollywood Lumetri LUTs, and WebM 1080p 60fps export.",
      tags: ["Timeline", "Lumetri LUTs", "SMPTE", "1080p 60fps"],
    ),
    const StudioItem(
      id: "batch",
      titleTr: "Batch Studio",
      titleEn: "Batch Studio",
      badge: "IMAGE LAB",
      icon: Icons.layers_rounded,
      accentColor: AppColors.accentEmerald,
      gradient: [Color(0xFF064E3B), Color(0xFF065F46), Color(0xFF022C22)],
      route: "batch",
      descTr: "Toplu görsel boyutlandırma, WebP / JPG / PNG format dönüştürücü, metin filigranı ve çoklu dosya ZIP paketi.",
      descEn: "Bulk multi-image resizing, WebP/JPG/PNG conversion, text watermarking, and instant multi-file download.",
      tags: ["Bulk Resize", "WebP", "Watermark", "ZIP Export"],
    ),
    const StudioItem(
      id: "data",
      titleTr: "Data & Chart Studio",
      titleEn: "Data & Chart Studio",
      badge: "DATA & BI",
      icon: Icons.bar_chart_rounded,
      accentColor: AppColors.accentCyan,
      gradient: [Color(0xFF0E7490), Color(0xFF155E75), Color(0xFF083344)],
      route: "data",
      descTr: "CSV & Excel tablo görüntüleyici, yinelenen veri temizleyici, JSON/SQL dönüştürücü ve anlık grafik görselleştirici.",
      descEn: "CSV & Excel table viewer, duplicate remover, JSON/SQL converter, and instant Canvas chart generator (Bar, Line, Pie).",
      tags: ["CSV Table", "SQL Converter", "Chart Visualizer", "Deduplicate"],
    ),
    const StudioItem(
      id: "3d",
      titleTr: "3D WebGL Studio",
      titleEn: "3D WebGL Studio",
      badge: "3D / GPU",
      icon: Icons.view_in_ar_rounded,
      accentColor: AppColors.secondaryLight,
      gradient: [Color(0xFF581C87), Color(0xFF3B0764), Color(0xFF1E1B4B)],
      route: "3d",
      descTr: "Three.js WebGL 3D model görüntüleyici, parametrik şekiller, tel kafes (wireframe) modu ve şeffaf PNG render.",
      descEn: "Interactive Three.js WebGL viewport, geometric presets, wireframe mode, and transparent PNG snapshot export.",
      tags: ["WebGL", "Three.js", "Wireframe", "Shaders"],
    ),
    const StudioItem(
      id: "vault",
      titleTr: "Vault & Crypto Lab",
      titleEn: "Vault & Crypto Lab",
      badge: "SECURITY",
      icon: Icons.lock_rounded,
      accentColor: AppColors.accentEmerald,
      gradient: [Color(0xFF14532D), Color(0xFF052E16), Color(0xFF064E3B)],
      route: "vault",
      descTr: "LSB Steganografi (görsel pikseline gizli mesaj gömme), PBKDF2 + AES-256-GCM şifreleme ve parola entropi testi.",
      descEn: "LSB Steganography (hide secret messages in PNG pixels), AES-256-GCM client encryption, and password entropy analyzer.",
      tags: ["Steganography", "AES-256-GCM", "PBKDF2", "Password Entropy"],
    ),
    const StudioItem(
      id: "record",
      titleTr: "Screen Recorder Studio",
      titleEn: "Screen Recorder Studio",
      badge: "MEDIA PRO",
      icon: Icons.videocam_rounded,
      accentColor: AppColors.primary,
      gradient: [Color(0xFF881337), Color(0xFF4C0519), Color(0xFF1E1B4B)],
      route: "record",
      descTr: "Sıfır filigranla HD tarayıcı ekranı ve web kamerası kaydı. Sistem & mikrofon sesi desteği ve anında WebM/MP4 indirme.",
      descEn: "HD browser screen and webcam recorder. Zero watermarks, system & mic audio support, and instant WebM/MP4 export.",
      tags: ["Screen Capture", "Webcam", "Microphone", "No Watermark"],
    ),
    const StudioItem(
      id: "network",
      titleTr: "Network Diagnostic Suite",
      titleEn: "Network Diagnostic Suite",
      badge: "DIAGNOSTIC",
      icon: Icons.language_rounded,
      accentColor: AppColors.accentBlue,
      gradient: [Color(0xFF1E3A8A), Color(0xFF172554), Color(0xFF0F172A)],
      route: "network",
      descTr: "WebRTC IP sızıntı tespiti, Canvas parmak izi teşhisi, cihaz donanım ve ekran özellikleri ve canlı edge ping testi.",
      descEn: "WebRTC IP leak detector, Canvas fingerprint hash generator, device hardware & DPR inspection, and live edge ping test.",
      tags: ["WebRTC Leak", "Canvas Fingerprint", "Hardware Concurrency", "Edge Ping"],
    ),
    const StudioItem(
      id: "drop",
      titleTr: "ShiftDrop P2P Transfer",
      titleEn: "ShiftDrop P2P Transfer",
      badge: "WEBRTC",
      icon: Icons.radio_rounded,
      accentColor: AppColors.accentCyan,
      gradient: [Color(0xFF0369A1), Color(0xFF075985), Color(0xFF082F49)],
      route: "drop",
      descTr: "Cihazlar arasında doğrudan WebRTC P2P uçtan uca şifreli dosya aktarımı. Sunucuya dosya yüklenmez, boyut sınırı yoktur.",
      descEn: "Encrypted device-to-device P2P file sharing via WebRTC. Zero server uploads, unlimited file size.",
      tags: ["P2P Transfer", "WebRTC DataChannel", "Zero Upload", "End-to-End"],
    ),
    const StudioItem(
      id: "pdf",
      titleTr: "PDF Master & OCR",
      titleEn: "PDF Master & OCR",
      badge: "DOCUMENT",
      icon: Icons.description_rounded,
      accentColor: AppColors.accentAmber,
      gradient: [Color(0xFF9A3412), Color(0xFF7C2D12), Color(0xFF1C1917)],
      route: "pdf",
      descTr: "PDF sayfalarını birleştirme, bölme, dijital imza ekleme, şifreleme ve Tesseract OCR ile taranmış belgelerden metin çıkarma.",
      descEn: "PDF merge, split, digital sign, password protect, and Tesseract OCR document text extraction.",
      tags: ["PDF Merge", "OCR Text Extract", "Digital Signature", "Compress"],
    ),
    const StudioItem(
      id: "audio",
      titleTr: "Audio Studio Pro",
      titleEn: "Audio Studio Pro",
      badge: "AUDIO",
      icon: Icons.graphic_eq_rounded,
      accentColor: AppColors.secondary,
      gradient: [Color(0xFF4338CA), Color(0xFF312E81), Color(0xFF0F172A)],
      route: "audio",
      descTr: "Ses dalga boyu görselleştirici, ses kırpma & birleştirme, perde/hız kontrolü ve gürültü azaltma.",
      descEn: "Waveform visualizer, audio cutter & merger, pitch/tempo changer, and noise gate filters.",
      tags: ["Waveform Visualizer", "Pitch Shift", "Audio Trimmer", "Noise Gate"],
    ),
    const StudioItem(
      id: "code",
      titleTr: "Code Playground",
      titleEn: "Code Playground",
      badge: "DEVELOPER",
      icon: Icons.code_rounded,
      accentColor: AppColors.accentBlue,
      gradient: [Color(0xFF1E293B), Color(0xFF0F172A), Color(0xFF020617)],
      route: "code",
      descTr: "Canlı HTML, CSS ve JavaScript sandbox editörü, SQLite veritabanı sorgulayıcı ve TypeScript derleyici.",
      descEn: "Live HTML/CSS/JS sandbox, in-browser SQLite query console, and TypeScript transpiler.",
      tags: ["HTML/CSS/JS", "SQLite SQL", "Live Sandbox", "TypeScript"],
    ),
    const StudioItem(
      id: "qr-hub",
      titleTr: "QR Hub Stüdyosu",
      titleEn: "QR Hub Studio",
      badge: "VECTOR",
      icon: Icons.qr_code_rounded,
      accentColor: Color(0xFFEC4899),
      gradient: [Color(0xFF831843), Color(0xFF500724), Color(0xFF0F172A)],
      route: "qr-hub",
      descTr: "Özel renkli, logolu, gradyanlı ve yüksek çözünürlüklü vektör QR kod stüdyosu. WiFi, vCard, URL ve metin desteği.",
      descEn: "Custom color, gradient, logo overlay vector QR code studio. Supports WiFi, vCard, URL and text.",
      tags: ["WiFi QR", "vCard", "Gradient Colors", "High Res PNG/SVG"],
    ),
    const StudioItem(
      id: "design",
      titleTr: "Design Studio",
      titleEn: "Design Studio",
      badge: "GRAPHICS",
      icon: Icons.palette_rounded,
      accentColor: AppColors.accentAmber,
      gradient: [Color(0xFFB45309), Color(0xFF78350F), Color(0xFF1E1B4B)],
      route: "design",
      descTr: "YouTube küçük resimleri, Instagram postları ve sosyal medya grafikleri için hızlı tuval tasarım stüdyosu.",
      descEn: "Fast graphic & thumbnail maker for YouTube, Instagram posts, banners, and badges.",
      tags: ["Thumbnail Maker", "Canvas 2D", "Instagram 1:1", "Social Assets"],
    ),
    const StudioItem(
      id: "api-lab",
      titleTr: "API & Mock Lab",
      titleEn: "API & Mock Lab",
      badge: "DEV TOOLS",
      icon: Icons.dns_rounded,
      accentColor: AppColors.secondaryLight,
      gradient: [Color(0xFF4C1D95), Color(0xFF2E1065), Color(0xFF0F172A)],
      route: "api-lab",
      descTr: "Tarayıcı içi REST API istek test edici, sahte (mock) veri sunucusu ve webhook simülatörü.",
      descEn: "In-browser REST API tester, mock JSON server, and webhook payload simulator.",
      tags: ["REST Tester", "Mock Server", "Webhook Payload", "JSON Schema"],
    ),
  ];

  void _openFullWebStudio(String route) {
    final lang = widget.viewModel.language;
    UrlUtils.openUrl("https://shiftlabs.co/$lang/$route");
  }

  void _copyToClipboard(String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEn = widget.viewModel.language == "en";
    final studio = _studios[_selectedStudioIndex];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Studio Selector Tabs / Chips
          _buildStudioSelectorBar(isEn),
          const SizedBox(height: 16),
          // Active Studio Hero Banner
          _buildActiveStudioBanner(studio, isEn),
          const SizedBox(height: 16),
          // Active Studio Interactive Workbench
          _buildActiveStudioWorkbench(studio, isEn),
          const SizedBox(height: 24),
          // Studio Companion Tools Grid
          _buildStudioCompanionTools(studio, isEn),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStudioSelectorBar(bool isEn) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _studios.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final s = _studios[index];
          final isSelected = _selectedStudioIndex == index;
          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => setState(() => _selectedStudioIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? s.accentColor.withValues(alpha: 0.2) : AppColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? s.accentColor : AppColors.border,
                  width: isSelected ? 1.5 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: s.accentColor.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    s.icon,
                    size: 18,
                    color: isSelected ? s.accentColor : AppColors.textMuted,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isEn ? s.titleEn : s.titleTr,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: isSelected ? s.accentColor : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      s.badge,
                      style: GoogleFonts.spaceMono(
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActiveStudioBanner(StudioItem studio, bool isEn) {
    final title = isEn ? studio.titleEn : studio.titleTr;
    final desc = isEn ? studio.descEn : studio.descTr;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: studio.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: studio.accentColor.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: studio.accentColor.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: studio.accentColor.withValues(alpha: 0.4)),
                ),
                child: Icon(studio.icon, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: studio.accentColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            studio.badge,
                            style: GoogleFonts.spaceMono(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      desc,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5,
                        color: Colors.white70,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Action Buttons Bar
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: studio.accentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.open_in_new_rounded, size: 18),
                  label: Text(
                    isEn ? "Open Web Studio Fullscreen" : "Web Stüdyosunu Tam Ekran Aç",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  onPressed: () => _openFullWebStudio(studio.route),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.card.withValues(alpha: 0.6),
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: AppColors.border),
                  ),
                ),
                icon: const Icon(Icons.share_rounded, size: 18, color: Colors.white),
                onPressed: () => _copyToClipboard(
                  "https://shiftlabs.co/${widget.viewModel.language}/${studio.route}",
                  isEn ? "Studio URL copied!" : "Stüdyo bağlantısı kopyalandı!",
                ),
                tooltip: isEn ? "Share Studio" : "Stüdyoyu Paylaş",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveStudioWorkbench(StudioItem studio, bool isEn) {
    switch (studio.id) {
      case "video":
        return _buildVideoWorkbench(isEn);
      case "batch":
        return _buildBatchWorkbench(isEn);
      case "data":
        return _buildDataWorkbench(isEn);
      case "3d":
        return _build3DWorkbench(isEn);
      case "vault":
        return _buildVaultWorkbench(isEn);
      case "record":
        return _buildRecordWorkbench(isEn);
      case "network":
        return _buildNetworkWorkbench(isEn);
      case "drop":
        return _buildDropWorkbench(isEn);
      case "pdf":
        return _buildPdfWorkbench(isEn);
      case "audio":
        return _buildAudioWorkbench(isEn);
      case "code":
        return _buildCodeWorkbench(isEn);
      case "qr-hub":
        return _buildQrWorkbench(isEn);
      case "design":
        return _buildDesignWorkbench(isEn);
      case "api-lab":
        return _buildApiWorkbench(isEn);
      default:
        return _buildVideoWorkbench(isEn);
    }
  }

  // --- 1. Video Studio Workbench ---
  Widget _buildVideoWorkbench(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
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
                isEn ? "SMPTE Multi-Track Monitor" : "SMPTE Çok Kanallı Monitör",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              Row(
                children: ["16:9", "9:16", "1:1"].map((ratio) {
                  final isSel = _selectedAspectRatio == ratio;
                  return Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: InkWell(
                      onTap: () => setState(() => _selectedAspectRatio = ratio),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isSel ? AppColors.primary : AppColors.surface,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: isSel ? AppColors.primary : AppColors.border),
                        ),
                        child: Text(
                          ratio,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isSel ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.movie_creation_outlined, color: AppColors.primary, size: 36),
                      const SizedBox(height: 8),
                      Text(
                        "1080p 60fps SMPTE Canvas",
                        style: GoogleFonts.spaceMono(fontSize: 12, color: Colors.white70),
                      ),
                      Text(
                        "LUT: ${_selectedLut.toUpperCase()} | ASPECT: $_selectedAspectRatio",
                        style: GoogleFonts.spaceMono(fontSize: 10, color: AppColors.accentCyan),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 12,
                  right: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded),
                        color: AppColors.primary,
                        iconSize: 32,
                        onPressed: () => setState(() => _isPlaying = !_isPlaying),
                      ),
                      Text("00:01:24:18", style: GoogleFonts.spaceMono(color: AppColors.accentEmerald, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isEn ? "Hollywood Lumetri LUTs:" : "Hollywood Lumetri Renk Filtreleri (LUT):",
            style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textMuted),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              {"id": "teal-orange", "label": "Teal & Orange"},
              {"id": "kodak-2383", "label": "Kodak 2383"},
              {"id": "matrix-green", "label": "Matrix Green"},
              {"id": "blade-runner", "label": "Blade Runner"},
              {"id": "noir", "label": "Film Noir"},
            ].map((lut) {
              final isSel = _selectedLut == lut["id"];
              return InkWell(
                onTap: () => setState(() => _selectedLut = lut["id"]!),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isSel ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isSel ? AppColors.primary : AppColors.border),
                  ),
                  child: Text(
                    lut["label"]!,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      color: isSel ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // --- 2. Batch Studio Workbench ---
  Widget _buildBatchWorkbench(bool isEn) {
    return Container(
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
            isEn ? "Bulk Image Processing Configuration" : "Toplu Görsel İşleme Yapılandırması",
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isEn ? "Target Format" : "Hedef Format", style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textMuted)),
                    const SizedBox(height: 6),
                    Row(
                      children: ["WebP", "JPG", "PNG"].map((fmt) {
                        final isSel = _batchFormat == fmt;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: ChoiceChip(
                            label: Text(fmt, style: TextStyle(fontSize: 11, color: isSel ? Colors.white : AppColors.textSecondary)),
                            selected: isSel,
                            selectedColor: AppColors.accentEmerald,
                            backgroundColor: AppColors.surface,
                            onSelected: (_) => setState(() => _batchFormat = fmt),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kalite / Sıkıştırma: %${_batchQuality.toInt()}", style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textMuted)),
                    Slider(
                      value: _batchQuality,
                      min: 30,
                      max: 100,
                      activeColor: AppColors.accentEmerald,
                      onChanged: (v) => setState(() => _batchQuality = v),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _batchWatermarkCtrl,
            style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white),
            decoration: InputDecoration(
              labelText: isEn ? "Text Watermark Overlay" : "Metin Filigranı (Watermark)",
              prefixIcon: const Icon(Icons.branding_watermark_rounded, size: 18),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentEmerald,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: Text(isEn ? "Simulate Batch Resize" : "Toplu Boyutlandırmayı Simüle Et"),
                  onPressed: () {
                    setState(() => _isBatchProcessing = true);
                    Future.delayed(const Duration(seconds: 1), () {
                      if (mounted) setState(() => _isBatchProcessing = false);
                    });
                  },
                ),
              ),
            ],
          ),
          if (_isBatchProcessing) ...[
            const SizedBox(height: 10),
            const LinearProgressIndicator(color: AppColors.accentEmerald),
          ],
        ],
      ),
    );
  }

  // --- 3. Data Studio Workbench ---
  Widget _buildDataWorkbench(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
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
                isEn ? "Live CSV Table & Chart Engine" : "Canlı CSV Tablo & Grafik Motoru",
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
              ),
              Row(
                children: [
                  ChoiceChip(
                    label: const Text("Bar"),
                    selected: _chartType == "bar",
                    selectedColor: AppColors.accentCyan,
                    onSelected: (_) => setState(() => _chartType = "bar"),
                  ),
                  const SizedBox(width: 4),
                  ChoiceChip(
                    label: const Text("Line"),
                    selected: _chartType == "line",
                    selectedColor: AppColors.accentCyan,
                    onSelected: (_) => setState(() => _chartType = "line"),
                  ),
                  const SizedBox(width: 4),
                  ChoiceChip(
                    label: const Text("Pie"),
                    selected: _chartType == "pie",
                    selectedColor: AppColors.accentCyan,
                    onSelected: (_) => setState(() => _chartType = "pie"),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Sample Table Grid Preview
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: const BoxDecoration(
                    color: AppColors.cardHover,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                  ),
                  child: Row(
                    children: const [
                      Expanded(flex: 1, child: Text("ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white70))),
                      Expanded(flex: 3, child: Text("Kategori", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white70))),
                      Expanded(flex: 2, child: Text("Değer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white70))),
                      Expanded(flex: 2, child: Text("Grafik Bar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white70))),
                    ],
                  ),
                ),
                _buildTableRow("1", "Teknoloji", "₺ 84.500", 0.85, AppColors.accentCyan),
                _buildTableRow("2", "Tasarım", "₺ 62.000", 0.62, AppColors.secondary),
                _buildTableRow("3", "Pazarlama", "₺ 41.200", 0.41, AppColors.accentEmerald),
                _buildTableRow("4", "Sunucu & DevOps", "₺ 95.000", 0.95, AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(String id, String cat, String val, double pct, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(id, style: GoogleFonts.spaceMono(fontSize: 11, color: AppColors.textMuted))),
          Expanded(flex: 3, child: Text(cat, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white))),
          Expanded(flex: 2, child: Text(val, style: GoogleFonts.spaceMono(fontSize: 11, color: color, fontWeight: FontWeight.bold))),
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: pct, color: color, backgroundColor: AppColors.border, minHeight: 8),
            ),
          ),
        ],
      ),
    );
  }

  // --- 4. 3D WebGL Studio Workbench ---
  Widget _build3DWorkbench(bool isEn) {
    return Container(
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
            isEn ? "Interactive 3D WebGL Shader Viewport" : "İnteraktif 3D WebGL & Tel Kafes Görünümü",
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _color3d.withValues(alpha: 0.5)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.view_in_ar_rounded,
                  size: 72,
                  color: _color3d.withValues(alpha: 0.8),
                ),
                Positioned(
                  top: 10,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      "GEO: $_geo3d | WIREFRAME: ${_wireframe3d ? 'ON' : 'OFF'}",
                      style: GoogleFonts.spaceMono(fontSize: 10, color: _color3d),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(6)),
                    child: Text("60 FPS Three.js Engine", style: GoogleFonts.spaceMono(fontSize: 10, color: AppColors.accentEmerald)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  children: ["Torus Knot", "Dodecahedron", "Sphere", "Cube"].map((geo) {
                    final isSel = _geo3d == geo;
                    return ChoiceChip(
                      label: Text(geo, style: TextStyle(fontSize: 11, color: isSel ? Colors.white : AppColors.textSecondary)),
                      selected: isSel,
                      selectedColor: _color3d,
                      backgroundColor: AppColors.surface,
                      onSelected: (_) => setState(() => _geo3d = geo),
                    );
                  }).toList(),
                ),
              ),
              Switch(
                value: _wireframe3d,
                activeThumbColor: _color3d,
                onChanged: (v) => setState(() => _wireframe3d = v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 5. Vault & Crypto Lab Workbench ---
  Widget _buildVaultWorkbench(bool isEn) {
    final pwd = _vaultPasswordCtrl.text;
    int pool = 0;
    if (RegExp(r'[a-z]').hasMatch(pwd)) {
      pool += 26;
    }
    if (RegExp(r'[A-Z]').hasMatch(pwd)) {
      pool += 26;
    }
    if (RegExp(r'[0-9]').hasMatch(pwd)) {
      pool += 10;
    }
    if (RegExp(r'[^a-zA-Z0-9]').hasMatch(pwd)) {
      pool += 33;
    }
    if (pool == 0) {
      pool = 1;
    }
    final entropy = (pwd.length * (math.log(pool) / math.ln2)).round();

    return Container(
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
            isEn ? "Client-Side Cryptography & Password Entropy" : "İstemci Tarafı Kriptografi & Parola Entropisi",
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _vaultPasswordCtrl,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.spaceMono(fontSize: 12, color: Colors.white),
            decoration: const InputDecoration(
              labelText: "Şifre / Parola Girdisi",
              prefixIcon: Icon(Icons.key_rounded, size: 18),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bilgi Entropisi: $entropy bit", style: GoogleFonts.spaceMono(color: AppColors.accentEmerald, fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(entropy >= 65 ? "🛡️ Kırılamaz Güç" : "⚠️ Geliştirilmeli", style: const TextStyle(fontSize: 11, color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (entropy / 100).clamp(0.05, 1.0),
                    color: entropy >= 60 ? AppColors.accentEmerald : AppColors.accentAmber,
                    backgroundColor: AppColors.border,
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 6. Screen Recorder Workbench ---
  Widget _buildRecordWorkbench(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
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
                isEn ? "Zero-Watermark HD Recorder" : "Filigransız HD Kaydedici",
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _isRecording ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _isRecording ? "🔴 CANLI KAYITTA" : "HAZIR",
                  style: GoogleFonts.spaceMono(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRecording ? AppColors.cardHover : AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: Icon(_isRecording ? Icons.stop_rounded : Icons.fiber_manual_record_rounded),
                  label: Text(_isRecording ? "Kaydı Durdur" : "Kaydı Başlat"),
                  onPressed: () => setState(() => _isRecording = !_isRecording),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 7. Network Suite Workbench ---
  Widget _buildNetworkWorkbench(bool isEn) {
    return Container(
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
            isEn ? "Device Diagnostic & WebRTC Leak Test" : "Cihaz Teşhisi & WebRTC Sızıntı Testi",
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 12),
          _buildDiagItem("WebRTC IP Sızıntı Koruması", "✅ Korunuyor (Sıfır Sunucu Yükleme)", AppColors.accentEmerald),
          _buildDiagItem("Dart & Flutter Motoru", "Dart 3.x / Flutter 3.29+ Native AOT", AppColors.accentCyan),
          _buildDiagItem("Çalışma Modu", "100% Client-Side Pure Sandbox", AppColors.textPrimary),
          _buildDiagItem("Edge Ping Gecikmesi", _isTestingPing ? "Ölçülüyor..." : "14ms (Frankfurt / Istanbul Edge)", AppColors.accentEmerald),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.accentBlue,
              side: const BorderSide(color: AppColors.accentBlue),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: Text(isEn ? "Retest Latency" : "Gecikmeyi Yeniden Test Et"),
            onPressed: () {
              setState(() => _isTestingPing = true);
              Future.delayed(const Duration(milliseconds: 600), () {
                if (mounted) setState(() => _isTestingPing = false);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDiagItem(String label, String val, Color valColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textMuted)),
          Text(val, style: GoogleFonts.spaceMono(fontSize: 11.5, color: valColor, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // --- 8. Drop Workbench ---
  Widget _buildDropWorkbench(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
      child: Column(
        children: [
          const Icon(Icons.radio_rounded, size: 48, color: AppColors.accentCyan),
          const SizedBox(height: 10),
          Text("ShiftDrop P2P Oda Kodu: #DROP-8492", style: GoogleFonts.spaceMono(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
          const SizedBox(height: 4),
          Text(isEn ? "Direct WebRTC Encrypted Transfer" : "Doğrudan WebRTC Uçtan Uca Şifreli Aktarım", style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  // --- 9. PDF Workbench ---
  Widget _buildPdfWorkbench(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("PDF Master & OCR Araçları", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: ["PDF Birleştir", "PDF Böl", "Sayfa Sil", "Dijital İmza", "OCR Metin Çıkar"].map((act) {
              return ActionChip(
                label: Text(act, style: const TextStyle(fontSize: 11, color: Colors.white)),
                backgroundColor: AppColors.surface,
                onPressed: () => _openFullWebStudio("pdf"),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // --- 10. Audio Workbench ---
  Widget _buildAudioWorkbench(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Audio Waveform & Pitch", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
          const SizedBox(height: 12),
          Container(
            height: 60,
            decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(24, (i) {
                final h = 10.0 + ((i * 7) % 35);
                return Container(width: 4, height: h, decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(2)));
              }),
            ),
          ),
        ],
      ),
    );
  }

  // --- 11. Code Workbench ---
  Widget _buildCodeWorkbench(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Web Sandbox & SQL", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
              Row(
                children: ["HTML", "CSS", "JS", "SQL"].map((lang) {
                  final isSel = _codeLanguage == lang;
                  return Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ChoiceChip(
                      label: Text(lang),
                      selected: isSel,
                      selectedColor: AppColors.accentBlue,
                      onSelected: (_) => setState(() => _codeLanguage = lang),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _codeCtrl,
            maxLines: 4,
            style: GoogleFonts.spaceMono(fontSize: 11, color: Colors.white),
            decoration: const InputDecoration(fillColor: Colors.black87),
          ),
        ],
      ),
    );
  }

  // --- 12. QR Workbench ---
  Widget _buildQrWorkbench(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Özel Renkli & Gradyanlı QR Stüdyosu", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
          const SizedBox(height: 10),
          TextField(
            controller: _qrDataCtrl,
            style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white),
            decoration: const InputDecoration(labelText: "QR Kod İçeriği / URL", prefixIcon: Icon(Icons.qr_code_rounded, size: 18)),
          ),
        ],
      ),
    );
  }

  // --- 13. Design Workbench ---
  Widget _buildDesignWorkbench(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Küçük Resim & Sosyal Medya Tasarım Tuvali", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: ["YouTube (16:9)", "Instagram (1:1)", "Story (9:16)", "Twitter Banner (3:1)"].map((t) {
              return Chip(label: Text(t, style: const TextStyle(fontSize: 11, color: Colors.white)), backgroundColor: AppColors.surface);
            }).toList(),
          ),
        ],
      ),
    );
  }

  // --- 14. API Workbench ---
  Widget _buildApiWorkbench(bool isEn) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("REST API & Webhook Test Hub", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(8)),
                child: const Text("GET", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _apiUrlCtrl,
                  style: GoogleFonts.spaceMono(fontSize: 11, color: Colors.white),
                  decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Companion Tools Grid ---
  Widget _buildStudioCompanionTools(StudioItem studio, bool isEn) {
    final relevantTools = widget.viewModel.allTools.where((t) {
      if (studio.id == "video") return t.category == "video";
      if (studio.id == "batch") return t.category == "image";
      if (studio.id == "data") return t.category == "developer" || t.category == "utility";
      if (studio.id == "3d") return t.category == "developer" || t.category == "image";
      if (studio.id == "vault") return t.slug.contains("hash") || t.slug.contains("password") || t.slug.contains("cipher");
      if (studio.id == "record") return t.category == "video" || t.category == "social";
      if (studio.id == "network") return t.category == "developer";
      if (studio.id == "drop") return t.category == "utility" || t.category == "developer";
      if (studio.id == "pdf") return t.category == "document";
      if (studio.id == "audio") return t.category == "audio";
      if (studio.id == "code") return t.category == "developer";
      if (studio.id == "qr-hub") return t.slug.contains("qr");
      if (studio.id == "design") return t.category == "image" || t.category == "social";
      if (studio.id == "api-lab") return t.category == "developer";
      return true;
    }).take(6).toList();

    if (relevantTools.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEn ? "${studio.titleEn} Companion Tools" : "${studio.titleTr} İlgili Araçları",
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
            mainAxisExtent: 80,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: relevantTools.length,
          itemBuilder: (context, index) {
            final t = relevantTools[index];
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: InkWell(
                onTap: () {
                  final lang = widget.viewModel.language;
                  UrlUtils.openUrl(t.getWebUrl(lang));
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: studio.accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(studio.icon, color: studio.accentColor, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.getTitle(widget.viewModel.language),
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.5,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            t.getSubtitle(widget.viewModel.language),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10.5,
                              color: AppColors.textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.textMuted),
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
