import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_matomo/flutter_matomo.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _matomoStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    await FlutterMatomo.initializeTracker(
        'https://a1.i-atros.com/matomo.php', 2);

    Future.delayed(Duration(seconds: 2), () async {
      _matomoStatus = await FlutterMatomo.trackScreen(context, "Screen opened");
      setState(() {});
    });

    Future.delayed(Duration(seconds: 4), () async {
      _matomoStatus = await FlutterMatomo.trackScreenWithName(
          "This uses a name MyApp", "Screen opened");
      setState(() {});
    });

    Future.delayed(Duration(seconds: 6), () async {
      _matomoStatus =
          await FlutterMatomo.trackEvent(context, "Register button", "Clicked");
      setState(() {});
    });

    Future.delayed(Duration(seconds: 8), () async {
      _matomoStatus = await FlutterMatomo.trackEventWithName(
          "This uses a name MyApp", "Register button", "Clicked");
      setState(() {});
    });

    Future.delayed(Duration(seconds: 10), () async {
      _matomoStatus = await FlutterMatomo.trackDownload();
      setState(() {});
    });

    Future.delayed(Duration(seconds: 12), () async {
      _matomoStatus = await FlutterMatomo.trackGoal(1);
      setState(() {});
    });

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              '$_matomoStatus\n',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => FlutterMatomo.dispatchEvents(),
            label: Text("Dispatch now")),
      ),
    );
  }
}
