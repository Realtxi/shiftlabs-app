import "package:url_launcher/url_launcher.dart";

class UrlUtils {
  static Future<bool> openUrl(String urlString) async {
    final uri = Uri.tryParse(urlString);
    if (uri != null) {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
    return false;
  }
}
