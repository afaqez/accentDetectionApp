import 'package:url_launcher/url_launcher.dart' as launcher;

void launchUrl() async {
  Uri uri = Uri.parse(
    'https://drive.google.com/drive/folders/17iPT9ILQgez9jp_e_AABqwErvq1ljiXD?usp=sharing',
  );

  if (!await launcher.launchUrl(
    uri,
    mode: launcher.LaunchMode.externalApplication,
  )) {
    print("Could not launch the email.");
  }
}
