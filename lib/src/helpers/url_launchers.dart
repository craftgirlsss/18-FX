import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrls(String uri) async {
  if (!await launchUrl(
    mode: LaunchMode.externalApplication,
    Uri.parse(uri)
    )
  ) {
    throw Exception('Could not launch $uri');
  }
}