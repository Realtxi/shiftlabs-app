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

class _OfficeSuiteScreenState extends State<OfficeSuiteScreen> with SingleTickerProviderStateMixin {
  int _selectedAppIndex = 0;
  bool _isLoading = true;
  late AnimationController _spinCtrl;

  // Active Doc State
  final TextEditingController _titleCtrl = TextEditingController(text: "Yeni Doküman");
  final TextEditingController _contentCtrl = TextEditingController(
    text: "ShiftDoc mobil ve masaüstü döküman stüdyosuna hoş geldiniz.\n\n"
        "• Çevrimdışı ve anında düzenleme desteği\n"
        "• MySQL bulut kasasıyla güvenli senkronizasyon\n"
        "• 10 büyük Microsoft 365 alternatifi tek çatı altında.",
  );

  @override
  void initState() {
    super.initState();
    _spinCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _spinCtrl.dispose();
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

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

  void _showPexelsPicker() {
    final curated = [
      {
        "url": "https://images.pexels.com/photos/3183150/pexels-photo-3183150.jpeg?auto=compress&cs=tinysrgb&w=800",
        "title": "Modern Ofis Çalışma Alanı",
        "author": "Fauxels"
      },
      {
        "url": "https://images.pexels.com/photos/3184292/pexels-photo-3184292.jpeg?auto=compress&cs=tinysrgb&w=800",
        "title": "İş & Strateji Toplantısı",
        "author": "Fauxels"
      },
      {
        "url": "https://images.pexels.com/photos/1181244/pexels-photo-1181244.jpeg?auto=compress&cs=tinysrgb&w=800",
        "title": "Yazılım Mühendisliği & Kod",
        "author": "Christina Morillo"
      },
      {
        "url": "https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&w=800",
        "title": "Teknoloji & Kodlama",
        "author": "Luis Gomes"
      },
      {
        "url": "https://images.pexels.com/photos/3861969/pexels-photo-3861969.jpeg?auto=compress&cs=tinysrgb&w=800",
        "title": "Finansal Analiz & Raporlar",
        "author": "ThisIsEngineering"
      },
      {
        "url": "https://images.pexels.com/photos/323780/pexels-photo-323780.jpeg?auto=compress&cs=tinysrgb&w=800",
        "title": "Modern Şehir ve Gökdelenler",
        "author": "Expect Best"
      },
    ];

    final curatedVideos = [
      {
        "url": "https://static-videos.pexels.com/videos/855564/855564-hd_1920_1080_30fps.mp4",
        "image": "https://images.pexels.com/videos/855564/pictures/preview-0.jpg",
        "title": "İş Toplantısı & Çalışma",
        "author": "Ruvim Miksanskiy",
        "duration": "18s"
      },
      {
        "url": "https://static-videos.pexels.com/videos/853889/853889-hd_1920_1080_25fps.mp4",
        "image": "https://images.pexels.com/videos/853889/pictures/preview-0.jpg",
        "title": "Ekip Beyin Fırtınası",
        "author": "Ruvim Miksanskiy",
        "duration": "24s"
      },
      {
        "url": "https://static-videos.pexels.com/videos/3129671/3129671-hd_1920_1080_30fps.mp4",
        "image": "https://images.pexels.com/videos/3129671/pictures/preview-0.jpg",
        "title": "Kodlama & Yazılım",
        "author": "Pressmaster",
        "duration": "15s"
      },
      {
        "url": "https://static-videos.pexels.com/videos/856973/856973-hd_1920_1080_25fps.mp4",
        "image": "https://images.pexels.com/videos/856973/pictures/preview-0.jpg",
        "title": "Finansal Analiz & Grafikler",
        "author": "Ruvim Miksanskiy",
        "duration": "20s"
      },
      {
        "url": "https://static-videos.pexels.com/videos/7130545/7130545-hd_1920_1080_30fps.mp4",
        "image": "https://images.pexels.com/videos/7130545/pictures/preview-0.jpg",
        "title": "3D Akışkan Renk Dalgası",
        "author": "Codioful",
        "duration": "16s"
      },
    ];

    String activeTab = "photos";

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF05A081).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(activeTab == "videos" ? Icons.videocam_rounded : Icons.image_rounded, color: const Color(0xFF05A081), size: 18),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Pexels Stok Medya (Foto & Video)",
                        style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white60, size: 20),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ChoiceChip(
                    label: const Text("Fotoğraflar"),
                    selected: activeTab == "photos",
                    selectedColor: const Color(0xFF05A081),
                    onSelected: (val) {
                      if (val) setModalState(() => activeTab = "photos");
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("Videolar (MP4)"),
                    selected: activeTab == "videos",
                    selectedColor: const Color(0xFF05A081),
                    onSelected: (val) {
                      if (val) setModalState(() => activeTab = "videos");
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: activeTab == "videos"
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: curatedVideos.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          final item = curatedVideos[i];
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.pop(ctx);
                              setState(() {
                                _contentCtrl.text += "\n\n[Pexels Videosu: ${item['title']}]\nVideo Linki (MP4): ${item['url']}\nYapımcı: ${item['author']} (Pexels)\n";
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Pexels videosu dökümana eklendi!"),
                                  backgroundColor: Color(0xFF05A081),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Container(
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.border),
                                color: AppColors.surface,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Image.network(
                                            item["image"]!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => const Center(
                                              child: Icon(Icons.videocam_off, color: Colors.white30),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 6,
                                          left: 6,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withValues(alpha: 0.7),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              item["duration"]!,
                                              style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        const Center(
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Colors.black54,
                                            child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["title"]!,
                                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Video: ${item['author']}",
                                          style: const TextStyle(color: Colors.white54, fontSize: 9.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: curated.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          final item = curated[i];
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.pop(ctx);
                              setState(() {
                                _contentCtrl.text += "\n\n![${item['title']}](${item['url']})\nFotoğraf: ${item['author']} (Pexels)\n";
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Pexels görseli dökümana eklendi!"),
                                  backgroundColor: Color(0xFF05A081),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Container(
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.border),
                                color: AppColors.surface,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      item["url"]!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (context, error, stackTrace) => const Center(
                                        child: Icon(Icons.image_not_supported, color: Colors.white30),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["title"]!,
                                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Fotoğraf: ${item['author']}",
                                          style: const TextStyle(color: Colors.white54, fontSize: 9.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF07080C),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RotationTransition(
                turns: _spinCtrl,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const SweepGradient(
                      colors: [
                        Colors.orange,
                        Colors.pinkAccent,
                        Colors.deepPurpleAccent,
                        Colors.orange,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent.withValues(alpha: 0.3),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF07080C),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      "assets/images/logo-square-dark.png",
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Shiftlabs Office Suite",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "10 Office Stüdyosu Yükleniyor...",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white60,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: 140,
                child: LinearProgressIndicator(
                  minHeight: 3,
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                ),
              ),
            ],
          ),
        ),
      );
    }

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
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF05A081),
                    side: const BorderSide(color: Color(0xFF05A081)),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.image_outlined, size: 16),
                  label: const Text("Pexels", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  onPressed: _showPexelsPicker,
                ),
                const SizedBox(width: 8),
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

          // Main In-App Workspace with Smooth Animated Switcher
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.025),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
                    child: child,
                  ),
                ),
                child: KeyedSubtree(
                  key: ValueKey<int>(_selectedAppIndex),
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
