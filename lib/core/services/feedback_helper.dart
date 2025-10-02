import 'dart:developer';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

enum FeedbackType { bug, content, general }

class FeedbackHelper {
  static Future<void> sendMailFeedback({FeedbackType type = FeedbackType.general}) async {
    const String email = "technogenis@gmail.com";

    String subjectType;
    String bodyTemplate;

    switch (type) {
      case FeedbackType.bug:
        subjectType = "Bug Report";
        bodyTemplate = "Please describe the bug you encountered below:\n\n";
        break;
      case FeedbackType.content:
        subjectType = "Content Report";
        bodyTemplate = "Please describe the inappropriate or incorrect content:\n\n";
        break;
      default:
        subjectType = "Contact";
        bodyTemplate = "Your message here...\n\n";
        break;
    }

    final String subject = "AI Poem ${Platform.isAndroid ? "Android" : "iOS"} - $subjectType";

    final Uri emailLaunchUri = Uri.parse(
      "mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(bodyTemplate)}",
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
      } else {
        log("Could not launch mail app");
      }
    } catch (e) {
      log("Error launching mail app: $e");
    }
  }
}
