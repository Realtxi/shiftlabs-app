import "package:flutter/material.dart";

class IconMapper {
  static IconData getIcon(String? iconName, String category) {
    if (iconName != null) {
      switch (iconName.toLowerCase()) {
        case "calendar":
          return Icons.calendar_today_rounded;
        case "keyround":
        case "key":
          return Icons.key_rounded;
        case "sparkles":
          return Icons.auto_awesome_rounded;
        case "music":
          return Icons.music_note_rounded;
        case "radio":
          return Icons.radio_rounded;
        case "volumex":
          return Icons.volume_off_rounded;
        case "volume":
          return Icons.volume_up_rounded;
        case "sliders":
          return Icons.tune_rounded;
        case "rotateccw":
          return Icons.rotate_left_rounded;
        case "filetext":
        case "file":
          return Icons.description_rounded;
        case "binary":
          return Icons.data_object_rounded;
        case "filecheck":
          return Icons.assignment_turned_in_rounded;
        case "palette":
          return Icons.palette_rounded;
        case "layers":
          return Icons.layers_rounded;
        case "lock":
          return Icons.lock_rounded;
        case "shield":
          return Icons.shield_rounded;
        case "globe":
          return Icons.language_rounded;
        case "code":
          return Icons.code_rounded;
        case "share2":
          return Icons.share_rounded;
        case "video":
          return Icons.videocam_rounded;
        case "scissors":
          return Icons.content_cut_rounded;
        case "camera":
          return Icons.camera_alt_rounded;
        case "zap":
          return Icons.bolt_rounded;
        case "terminal":
          return Icons.terminal_rounded;
        case "cpu":
          return Icons.memory_rounded;
        case "search":
          return Icons.search_rounded;
        case "calculator":
          return Icons.calculate_rounded;
        case "clock":
          return Icons.schedule_rounded;
        case "type":
          return Icons.text_fields_rounded;
        case "image":
          return Icons.image_rounded;
        case "hash":
          return Icons.tag_rounded;
        case "smartphone":
          return Icons.smartphone_rounded;
        case "at-sign":
        case "atsign":
          return Icons.alternate_email_rounded;
        case "repeat":
          return Icons.repeat_rounded;
        case "shuffle":
          return Icons.shuffle_rounded;
        case "percent":
          return Icons.percent_rounded;
        case "activity":
          return Icons.insights_rounded;
        case "database":
          return Icons.storage_rounded;
        case "box":
          return Icons.view_in_ar_rounded;
        case "server":
          return Icons.dns_rounded;
        case "qr":
        case "qrcode":
          return Icons.qr_code_rounded;
        case "wifi":
          return Icons.wifi_rounded;
        case "contact":
          return Icons.contact_page_rounded;
        case "film":
          return Icons.movie_filter_rounded;
      }
    }

    // Fallback based on category
    switch (category.toLowerCase()) {
      case "developer":
        return Icons.code_rounded;
      case "image":
        return Icons.image_rounded;
      case "video":
        return Icons.movie_creation_rounded;
      case "audio":
        return Icons.graphic_eq_rounded;
      case "social":
        return Icons.share_rounded;
      case "document":
        return Icons.menu_book_rounded;
      case "text":
        return Icons.text_fields_rounded;
      case "utility":
      default:
        return Icons.handyman_rounded;
    }
  }

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case "developer":
        return const Color(0xFF3B82F6); // Blue
      case "image":
        return const Color(0xFFA855F7); // Purple
      case "video":
        return const Color(0xFFE11D48); // Rose
      case "audio":
        return const Color(0xFF06B6D4); // Cyan
      case "social":
        return const Color(0xFFEC4899); // Pink
      case "document":
        return const Color(0xFFF59E0B); // Amber
      case "text":
        return const Color(0xFF10B981); // Emerald
      case "utility":
      default:
        return const Color(0xFF6366F1); // Indigo
    }
  }
}
