import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/permissions_handle.dart';
import 'package:makhosi_app/utils/settings.dart';

class AudioCall extends StatefulWidget {
  final ClientRole role;
  final String channelName;
  final String token;

  AudioCall({this.channelName, this.role, this.token});

  @override
  _AudioCallState createState() => _AudioCallState();
}

// App state
class _AudioCallState extends State<AudioCall> {
  bool muted = false;
  RtcEngine _engine;
  List _users = [];

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future _loadFile() async {
    var bytes =
        await (await audioCache.load('audio/call-ring.mp3')).readAsBytes();

    advancedPlayer = await audioCache.playBytes(bytes, loop: true);
  }

  dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    advancedPlayer.stop();
    super.dispose();
  }

  // Initialize the app
  Future<void> initPlatformState() async {
    await _loadFile();
    // Create RTC client instance
    _engine = await RtcEngine.create(APP_ID);
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);

    await _engine.setClientRole(widget.role);

    // Define event handler
    _engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('joinChannelSuccess $channel $uid');
    }, userJoined: (int uid, int elapsed) {
      print('userJoined $uid');
      setState(() {
        _users.add(uid);
      });

      if (_users.length >= 1) {
        advancedPlayer.stop();
      }
    }, userOffline: (int uid, UserOfflineReason reason) async {
      print('userOffline $uid');

      setState(() {
        _users.removeLast();
      });
      if (_users.length < 1)
        await Future.delayed(
            Duration(seconds: 3), () => Navigator.pop(context));
    }));
    // Join channel 123
    if (widget.channelName == 'voice_call')
      await _engine.joinChannel(Token, 'voice_call', null, 0);
    else
      await _engine.joinChannel(widget.token, widget.channelName, null, 0);
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  /// Toolbar layout
  Widget _toolbar() {
    // if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          )
        ],
      ),
    );
  }

  Widget _viewContainer() {
    return Center(
      child: CircleAvatar(
        radius: 50,
      ),
    );
  }

  // Create a simple chat UI
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewContainer(),
            // _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
