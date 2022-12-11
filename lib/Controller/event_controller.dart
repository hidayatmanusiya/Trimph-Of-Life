import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventController extends GetxController {
  DateTime selectedDateTime = DateTime.now().add(Duration(days: 10));
  bool isTime = false;
  String title, description, location;
  GlobalKey<FormState> eventformKey = GlobalKey<FormState>();

  String titleValidator(String val) {
    if (val.length < 4) {
      return 'Title length should be atleast 4 character';
    } else {
      return null;
    }
  }

  getDate() {
    String _date = DateFormat('dd MMM, yyyy').format(selectedDateTime);
    return _date;
  }

  getTime() {
    String _date = DateFormat('hh :mm a').format(selectedDateTime);
    return _date;
  }

  updateDate(hours, minutes) {
    String _date = DateFormat('dd MMM, yyyy').format(selectedDateTime);
    _date = "$_date $hours $minutes";
    selectedDateTime = DateFormat('dd MMM, yyyy hh mm').parse(_date);
    isTime = true;
    update();
    // DateTime.parse(_date);
  }
/* ----------------------------- create an event ---------------------------- */

/* ------------------------------- update Event ------------------------------ */

/* ------------------------------- get my Event ------------------------------- */

/* ------------------------------ get all event ----------------------------- */

/* --------------------------- get specific event --------------------------- */

}
