import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:google_fonts/google_fonts.dart";
import "../../core/theme/app_theme.dart";
import "../../core/utils/icon_mapper.dart";
import "../../core/utils/url_utils.dart";
import "../../data/models/tool_model.dart";

class ToolDetailScreen extends StatefulWidget {
  final ShiftTool tool;
  final String langCode;
  final VoidCallback onToggleFavorite;

  const ToolDetailScreen({
    super.key,
    required this.tool,
    required this.langCode,
    required this.onToggleFavorite,
  });

  @override
  State<ToolDetailScreen> createState() => _ToolDetailScreenState();
}

class _ToolDetailScreenState extends State<ToolDetailScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _nativeOutput = "";
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.tool.isFavorite;
    _initializeDefaultInput();
  }

  void _initializeDefaultInput() {
    if (widget.tool.slug == "rot13-cipher") {
      _inputController.text = "Shiftlabs Ultra Hızlı Araçlar";
      _runNativeRunner();
    } else if (widget.tool.slug.contains("base64")) {
      _inputController.text = "Shiftlabs Cross-Platform Suite v2.0";
      _runNativeRunner();
    } else {
      _inputController.text = "Shiftlabs 2026 Test Metni";
      _runNativeRunner();
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _runNativeRunner() {
    final text = _inputController.text;
    if (text.isEmpty) {
      setState(() => _nativeOutput = "");
      return;
    }

    final slug = widget.tool.slug;
    String out = "";

    if (slug == "rot13-cipher") {
      // ROT13 implementation
      final buffer = StringBuffer();
      for (var code in text.codeUnits) {
        if (code >= 65 && code <= 90) {
          buffer.writeCharCode((code - 65 + 13) % 26 + 65);
        } else if (code >= 97 && code <= 122) {
          buffer.writeCharCode((code - 97 + 13) % 26 + 97);
        } else {
          buffer.writeCharCode(code);
        }
      }
      out = buffer.toString();
    } else if (slug.contains("base64")) {
      try {
        out = base64Encode(utf8.encode(text));
      } catch (_) {
        out = text;
      }
    } else if (slug.contains("aspect-ratio") || slug.contains("resolution")) {
      out = "Hesaplanan Standart Oranlar:\n• 16:9 (HD/4K): 1920x1080 / 3840x2160\n• 9:16 (Reels/TikTok): 1080x1920\n• 1:1 (Kare Post): 1080x1080\n• 4:5 (Instagram): 1080x1350";
    } else {
      // General stats & preview runner
      final words = text.trim().split(RegExp(r"\s+")).where((w) => w.isNotEmpty).length;
      final chars = text.length;
      final charsNoSpace = text.replaceAll(RegExp(r"\s+"), "").length;
      final lines = text.split("\n").length;
      final readTimeSec = (words / 3.3).ceil();

      out = "Metin Analizi ve İşlem Özeti:\n"
          "• Toplam Kelime: $words\n"
          "• Karakter (Boşluklu): $chars\n"
          "• Karakter (Boşluksuz): $charsNoSpace\n"
          "• Satır Sayısı: $lines\n"
          "• Tahmini Okuma Süresi: ~$readTimeSec saniye";
    }

    setState(() => _nativeOutput = out);
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
    final tool = widget.tool;
    final isEn = widget.langCode == "en";
    final catColor = IconMapper.getCategoryColor(tool.category);
    final iconData = IconMapper.getIcon(tool.icon, tool.category);
    final title = tool.getTitle(widget.langCode);
    final subtitle = tool.getSubtitle(widget.langCode);
    final webUrl = tool.getWebUrl(widget.langCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tool.category.toUpperCase(),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: catColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
              color: _isFavorite ? Colors.amber : Colors.white70,
            ),
            onPressed: () {
              widget.onToggleFavorite();
              setState(() => _isFavorite = !_isFavorite);
            },
            tooltip: _isFavorite ? "Favorilerden Çıkar" : "Favorilere Ekle",
          ),
          IconButton(
            icon: const Icon(Icons.share_rounded, size: 20),
            onPressed: () => _copyToClipboard(
              webUrl,
              isEn ? "Tool link copied to clipboard!" : "Araç bağlantısı panoya kopyalandı!",
            ),
            tooltip: isEn ? "Copy Link" : "Bağlantıyı Kopyala",
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: catColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: catColor.withValues(alpha: 0.3)),
                        ),
                        child: Icon(iconData, color: catColor, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: catColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                tool.badge.toUpperCase(),
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: catColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              title,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    subtitle.isNotEmpty
                        ? subtitle
                        : (isEn
                            ? "High-performance client-side tool running 100% in your device."
                            : "Tarayıcınızda veya cihazınızda %100 çevrimdışı ve gizli çalışan yüksek performanslı araç."),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Primary Launch Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.rocket_launch_rounded, size: 20),
                label: Text(
                  isEn ? "Run Full Tool on Shiftlabs Web" : "Aracı Shiftlabs Web'de Başlat",
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.5,
                  ),
                ),
                onPressed: () => UrlUtils.openUrl(webUrl),
              ),
            ),
            const SizedBox(height: 20),
            // In-App Native Runner Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
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
                      Row(
                        children: [
                          const Icon(Icons.bolt_rounded, color: AppColors.accentEmerald, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            isEn ? "In-App Quick Runner" : "Uygulama İçi Hızlı Çalıştırıcı",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.accentEmerald.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "OFFLINE / ANINDA",
                          style: GoogleFonts.spaceMono(
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentEmerald,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Input text field
                  TextField(
                    controller: _inputController,
                    maxLines: 3,
                    onChanged: (_) => _runNativeRunner(),
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: isEn ? "Enter input text..." : "İşlenecek metni veya değeri girin...",
                      fillColor: AppColors.card,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Output box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isEn ? "OUTPUT RESULT" : "SONUÇ ÇIKTISI",
                              style: GoogleFonts.spaceMono(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textMuted,
                              ),
                            ),
                            if (_nativeOutput.isNotEmpty)
                              InkWell(
                                onTap: () => _copyToClipboard(
                                  _nativeOutput,
                                  isEn ? "Output copied!" : "Sonuç panoya kopyalandı!",
                                ),
                                child: Text(
                                  isEn ? "Copy" : "Kopyala",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.primaryLight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          _nativeOutput.isNotEmpty
                              ? _nativeOutput
                              : (isEn ? "Waiting for input..." : "Girdi bekleniyor..."),
                          style: GoogleFonts.spaceMono(
                            fontSize: 12,
                            color: _nativeOutput.isNotEmpty ? Colors.white : AppColors.textMuted,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Privacy & Architecture Spec Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildSpecItem(
                    title: isEn ? "Privacy & Security" : "Gizlilik ve Güvenlik",
                    value: isEn ? "100% Client-Side Pure" : "%100 İstemci Tarafında İşlenir",
                    icon: Icons.lock_outline_rounded,
                    color: AppColors.accentEmerald,
                  ),
                  const Divider(color: AppColors.border, height: 16),
                  _buildSpecItem(
                    title: isEn ? "Execution Latency" : "İşlem Gecikmesi",
                    value: "< 10ms (Native WebAssembly / Dart)",
                    icon: Icons.speed_rounded,
                    color: AppColors.accentCyan,
                  ),
                  const Divider(color: AppColors.border, height: 16),
                  _buildSpecItem(
                    title: isEn ? "Direct Web URL" : "Doğrudan Web URL",
                    value: "shiftlabs.co/.../${tool.slug}",
                    icon: Icons.link_rounded,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecItem({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.5,
            color: AppColors.textMuted,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
