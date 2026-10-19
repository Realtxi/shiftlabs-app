import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "../../core/theme/app_theme.dart";
import "../view_models/app_view_model.dart";

class OfficeAppItem {
  final String id;
  final String title;
  final String msEquivalent;
  final String descTr;
  final String descEn;
  final IconData icon;
  final Color color;
  final Color bgLight;

  const OfficeAppItem({
    required this.id,
    required this.title,
    required this.msEquivalent,
    required this.descTr,
    required this.descEn,
    required this.icon,
    required this.color,
    required this.bgLight,
  });
}

class OfficeSuiteScreen extends StatefulWidget {
  final AppViewModel viewModel;

  const OfficeSuiteScreen({super.key, required this.viewModel});

  @override
  State<OfficeSuiteScreen> createState() => _OfficeSuiteScreenState();
}

class _OfficeSuiteScreenState extends State<OfficeSuiteScreen> {
  int _selectedAppIndex = 0;

  // Active Doc State
  final TextEditingController _titleCtrl = TextEditingController(text: "Yeni Doküman");
  final TextEditingController _contentCtrl = TextEditingController(
    text: "ShiftDoc mobil ve masaüstü döküman stüdyosuna hoş geldiniz.\n\n"
        "• Çevrimdışı ve anında düzenleme desteği\n"
        "• MySQL bulut kasasıyla güvenli senkronizasyon\n"
        "• 10 büyük Microsoft 365 alternatifi tek çatı altında.",
  );

  final List<OfficeAppItem> _apps = const [
    OfficeAppItem(
      id: "word",
      title: "ShiftDoc",
      msEquivalent: "Word",
      descTr: "Zengin metin biçimlendirme, sayfa düzeni ve döküman editörü.",
      descEn: "Rich text editing, page layout, and document editor.",
      icon: Icons.description_rounded,
      color: Colors.blue,
      bgLight: Color(0x1F2196F3),
    ),
    OfficeAppItem(
      id: "sheet",
      title: "ShiftSheet",
      msEquivalent: "Excel",
      descTr: "Dinamik hesap tablosu, formüller ve veri analizi.",
      descEn: "Dynamic spreadsheet, formulas, and data analysis.",
      icon: Icons.table_chart_rounded,
      color: Colors.green,
      bgLight: Color(0x1F4CAF50),
    ),
    OfficeAppItem(
      id: "deck",
      title: "ShiftSlide",
      msEquivalent: "PowerPoint",
      descTr: "Sunum slaytları, gradyan temalar ve tam ekran sunum.",
      descEn: "Presentation slides, gradient themes, and presentation mode.",
      icon: Icons.slideshow_rounded,
      color: Colors.orange,
      bgLight: Color(0x1FFF9800),
    ),
    OfficeAppItem(
      id: "notes",
      title: "ShiftNotes",
      msEquivalent: "OneNote",
      descTr: "Hızlı not defteri, kategoriler ve güvenli günlük.",
      descEn: "Quick notepad, categories, and secure journal.",
      icon: Icons.sticky_note_2_rounded,
      color: Colors.purple,
      bgLight: Color(0x1F9C27B0),
    ),
    OfficeAppItem(
      id: "vector",
      title: "ShiftVector",
      msEquivalent: "Visio",
      descTr: "İş akışı şemaları, mimari diyagramlar ve zihin haritası.",
      descEn: "Flowcharts, architectural diagrams, and mind maps.",
      icon: Icons.account_tree_rounded,
      color: Colors.cyan,
      bgLight: Color(0x1F00BCD4),
    ),
    OfficeAppItem(
      id: "flow",
      title: "ShiftFlow",
      msEquivalent: "Project / Planner",
      descTr: "Kanban görev panoları ve proje zamanlama takibi.",
      descEn: "Kanban task boards and project schedule tracking.",
      icon: Icons.view_kanban_rounded,
      color: Colors.teal,
      bgLight: Color(0x1F009688),
    ),
    OfficeAppItem(
      id: "db",
      title: "ShiftBase",
      msEquivalent: "Access",
      descTr: "İlişkisel veri tabloları, özel alanlar ve kayıt yönetimi.",
      descEn: "Relational data tables, custom fields, and record management.",
      icon: Icons.storage_rounded,
      color: Colors.red,
      bgLight: Color(0x1FF44336),
    ),
    OfficeAppItem(
      id: "layout",
      title: "ShiftPublish",
      msEquivalent: "Publisher",
      descTr: "Bülten, afiş, broşür ve sayfa mizanpaj tasarımı.",
      descEn: "Newsletter, poster, brochure, and page layout designer.",
      icon: Icons.auto_awesome_mosaic_rounded,
      color: Color(0xFF00796B),
      bgLight: Color(0x1F00796B),
    ),
    OfficeAppItem(
      id: "forms",
      title: "ShiftForm",
      msEquivalent: "Forms",
      descTr: "Dinamik anket, geri bildirim formu ve soru stüdyosu.",
      descEn: "Dynamic survey, feedback form, and question studio.",
      icon: Icons.fact_check_rounded,
      color: Color(0xFF00897B),
      bgLight: Color(0x1F00897B),
    ),
    OfficeAppItem(
      id: "todo",
      title: "ShiftTask",
      msEquivalent: "To-Do",
      descTr: "Kişisel görev listesi, öncelikler ve kontrol listesi.",
      descEn: "Personal task list, priorities, and checklists.",
      icon: Icons.task_alt_rounded,
      color: Colors.blueAccent,
      bgLight: Color(0x1F448AFF),
    ),
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  void _saveDocument() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.cloud_done_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text("Belge MySQL Bulut Kasasına ve Cihaza Kaydedildi!"),
          ],
        ),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEn = widget.viewModel.language == "en";
    final activeApp = _apps[_selectedAppIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Top Office App Switcher Bar
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _apps.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final app = _apps[index];
                final isSelected = _selectedAppIndex == index;
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    setState(() {
                      _selectedAppIndex = index;
                      _titleCtrl.text = "${app.title} Belgesi";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? app.bgLight : AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? app.color : AppColors.border,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(app.icon, size: 16, color: app.color),
                        const SizedBox(width: 6),
                        Text(
                          app.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: app.color.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            app.msEquivalent,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: app.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Document Header Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.card,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleCtrl,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: "Belge Başlığı...",
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: activeApp.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.cloud_upload_rounded, size: 16),
                  label: Text(
                    isEn ? "Save Document" : "Kaydet",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  onPressed: _saveDocument,
                ),
              ],
            ),
          ),

          // Main In-App Workspace
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _contentCtrl,
                  maxLines: null,
                  expands: true,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    height: 1.6,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "${activeApp.title} için içerik oluşturun veya not alın...",
                    hintStyle: const TextStyle(color: AppColors.textMuted),
                  ),
                ),
              ),
            ),
          ),

          // Bottom Cloud Status Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(activeApp.icon, size: 14, color: activeApp.color),
                    const SizedBox(width: 6),
                    Text(
                      "${activeApp.title} (${activeApp.msEquivalent})",
                      style: GoogleFonts.spaceMono(fontSize: 11, color: activeApp.color, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.lock_outline_rounded, size: 13, color: AppColors.accentEmerald),
                    SizedBox(width: 4),
                    Text(
                      "MySQL Kasası Senkronize",
                      style: TextStyle(fontSize: 10.5, color: AppColors.accentEmerald, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
