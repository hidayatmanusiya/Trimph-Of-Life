import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ConstantFunctions {
  ConstantFunctions._();

  static final now = DateTime.now();
  static final formattedAMPM = DateFormat('a').format(now);
  static final formattedTime = DateFormat('hh:mm ').format(now);
  static final formattedDate1 = DateFormat('EEE, d MMM').format(now);
  static final formattedDate2 = DateFormat('dd-MM-yyyy').format(now);
  static final formattedDatefinal = DateFormat('dd-MM-yy');
  static final calendar_formate_now = DateFormat('EE, dd-MM-yyyy');
  static final calendar_formate = DateFormat('dd-MM-yyyy');

  static const double padding = 20;
  static const double avatarRadius = 45;

  static const String privacy_policy_url =
      "https://developermeow.s3.amazonaws.com/privacy-policy.html";

  static Future openLink(String url) => _launchUrl(url);

  static Future openEmail(
      {@required String toEmail,
      @required String subject,
      @required String body}) async {
    try {
      final url =
          'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
      await _launchUrl(url);
    } catch (e) {
      print('openEmail ${e.toString()}');
    }
  }

  static Future openPhoneCall({@required String phoneNumber}) async {
    try {
      final url = 'tel:$phoneNumber';
      if (await canLaunch(url)) {
        await _launchUrl(url);
      } else {
        print('canLaunch false');
      }
      await _launchUrl(url);
    } catch (e) {
      print('openPhoneCall ${e.toString()}');
    }
  }

  static getSnakeBar(@required BuildContext context, @required String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 4),
        content: Text(message,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18)),
        backgroundColor: Color(0xff040404),
      ),
    );
  }

  static Future openSMS(
      {@required String phoneNumber, @required String message}) async {
    try {
      if (Platform.isAndroid) {
        final url = 'sms:$phoneNumber ?body=$message';
        if (await canLaunch(url)) {
          await _launchUrl(url);
        }
      }
    } catch (e) {
      print('openSMS ${e.toString()}');
    }
  }

  static Future _launchUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      }
    } catch (e) {
      print('_launchUrl ${e.toString()}');
    }
  }

  static PageRouteBuilder OpenNewActivity(screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, _) {
        return FadeTransition(opacity: animation, child: screen);
      },
    );
  }

  static PageRouteBuilder OpenNewScreenClean(context, material_route_page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => material_route_page,
        ),
        (Route<dynamic> route) => false);
  }

  static PageRouteBuilder OpenNewActivityClean(screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, _) {
        return FadeTransition(opacity: animation, child: screen);
      },
    );
  }

  static Widget GetDivider(Color container_color, Color divider_color,
      double _vertical, double _horizontal) {
    return Container(
      color: container_color,
      padding:
          EdgeInsets.symmetric(vertical: _vertical, horizontal: _horizontal),
      child: Divider(
        height: 1,
        color: divider_color,
      ),
    );
  }
}
