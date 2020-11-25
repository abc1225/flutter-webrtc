import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'interface/media_stream.dart';
import 'interface/mediadevices.dart';

class Helper {
  static Future<List<MediaDeviceInfo>> enumerateDevices(String type) async {
    var devices = await navigator.mediaDevices.enumerateDevices();
    return devices.where((d) => d.kind == type).toList();
  }

  static Future<List<MediaDeviceInfo>> get cameras =>
      enumerateDevices('videoinput');

  /// To select a a specific camera, you need to set constraints
  /// eg.
  /// constraints = {
  ///      'audio': true,
  ///      'video': {
  ///          'deviceId': Helper.cameras[0].deviceId,
  ///          }
  ///      };
  ///
  /// Helper.openCamera(constraints);
  ///
  static Future<MediaStream> openCamera(Map<String, dynamic> mediaConstraints) {
    return navigator.mediaDevices.getUserMedia(mediaConstraints);
  }

  static Future<void> setVolume(double volume, MediaStreamTrack track) {
    if (track.kind == 'audio') {
      final constraints = track.getConstraints();
      constraints['volume'] = volume;
      return track.applyConstraints(constraints);
    }

    return Future.value();
  }

  static void setMicrophoneMute(bool mute, MediaStreamTrack track) {
    if (track.kind == 'audio') {
      track.enabled = mute;
    }
  }
}
