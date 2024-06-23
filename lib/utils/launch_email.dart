import 'package:url_launcher/url_launcher.dart' as launcher;

void launchEmail() async {
  Uri uri = Uri.parse(
    'mailto:moeezsuleman506@gmail.com?subject=Contact Us - Speak Right Application&body=Hello, I would like to contact you regarding',
  );

  if (!await launcher.launchUrl(uri)) {
    print("Could not launch the email.");
  }
}
