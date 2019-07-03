import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class FlutterMatomo {
  static const MethodChannel _channel = const MethodChannel('flutter_matomo');

  static Future<String> initializeTracker(String url, int siteId) async {
    Map<String, dynamic> args = {};
    args.putIfAbsent('url', () => url);
    args.putIfAbsent('siteId', () => siteId);
    final String version =
        await _channel.invokeMethod('initializeTracker', args);
    return version;
  }

  static Future<String> dispatchEvents() async {
    final String version = await _channel.invokeMethod('dispatchEvents');
    return version;
  }

  static Future<String> trackEvent(
      BuildContext context, String eventName, String eventAction) async {
    var widgetName = context.widget.toStringShort();
    Map<String, dynamic> args = {};
    args.putIfAbsent('widgetName', () => widgetName);
    args.putIfAbsent('eventName', () => eventName);
    args.putIfAbsent('eventAction', () => eventAction);
    final String version = await _channel.invokeMethod('trackEvent', args);
    return version;
  }

  static Future<String> trackEventWithName(
      String widgetName, String eventName, String eventAction) async {
    Map<String, dynamic> args = {};
    args.putIfAbsent('widgetName', () => widgetName);
    args.putIfAbsent('eventName', () => eventName);
    args.putIfAbsent('eventAction', () => eventAction);
    final String version = await _channel.invokeMethod('trackEvent', args);
    return version;
  }

  static Future<String> trackScreen(
      BuildContext context, String eventName) async {
    var widgetName = context.widget.toStringShort();
    Map<String, dynamic> args = {};
    args.putIfAbsent('widgetName', () => widgetName);
    args.putIfAbsent('eventName', () => eventName);
    final String version = await _channel.invokeMethod('trackScreen', args);
    return version;
  }

  static Future<String> trackScreenWithName(
      String widgetName, String eventName) async {
    Map<String, dynamic> args = {};
    args.putIfAbsent('widgetName', () => widgetName);
    args.putIfAbsent('eventName', () => eventName);
    final String version = await _channel.invokeMethod('trackScreen', args);
    return version;
  }

  static Future<String> trackDownload() async {
    final String version = await _channel.invokeMethod('trackDownload');
    return version;
  }

  static Future<String> trackGoal(int goalId) async {
    Map<String, dynamic> args = {};
    args.putIfAbsent('goalId', () => goalId);
    final String version = await _channel.invokeMethod('trackGoal', args);
    return version;
  }
}
