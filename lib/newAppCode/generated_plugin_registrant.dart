//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars

import 'package:agora_rtc_engine/agora_rtc_engine_web.dart';
import 'package:file_picker/_internal/file_picker_web.dart';

import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AgoraRtcEngineWeb.registerWith(registrar);
  FilePickerWeb.registerWith(registrar);
 // FluttertoastWebPlugin.registerWith(registrar);
  ImagePickerPlugin.registerWith(registrar);
  SharedPreferencesPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
