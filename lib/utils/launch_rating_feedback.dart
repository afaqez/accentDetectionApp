import 'package:url_launcher/url_launcher.dart' as launcher;

void launchRatingFeedback(int rating) async {
  Uri uri = Uri.parse(
    'mailto:moeezsuleman506@gmail.com?subject=Rating your Application - Speak Right Application&body=Hello, I would like to give $rating stars to your application.',
  );

  if (!await launcher.launchUrl(uri)) {
    print("Could not launch the email.");
  }
}
