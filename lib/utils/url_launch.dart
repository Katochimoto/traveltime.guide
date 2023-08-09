import 'package:url_launcher/url_launcher.dart';

Future<void> urlLaunch(String? url) async {
  if (url != null) {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
