import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/general_ui/audio_call.dart';
import 'package:makhosi_app/main_ui/general_ui/call_page.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/permissions_handle.dart';

class PickupCall extends StatefulWidget {
  final String title, label, type, channelName, token;
  PickupCall({this.title, this.label, this.type, this.channelName, this.token});
  @override
  _PickupCallState createState() => _PickupCallState();
}

class _PickupCallState extends State<PickupCall> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }

    _loadFile();
  }

  Future _loadFile() async {
    var bytes =
        await (await audioCache.load('audio/pickup-ringing.mp3')).readAsBytes();

    advancedPlayer = await audioCache.playBytes(bytes, loop: true);
  }

  @override
  void dispose() {
    super.dispose();
    advancedPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: Text(
                        widget.label,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: () async {
                      await HandlePermission.handleCamera();
                      await HandlePermission.handleMic();
                      if (widget.type == 'voice') {
                        Navigator.pop(context);
                        NavigationController.push(
                            context,
                            AudioCall(
                                channelName: widget.token.isEmpty
                                    ? 'voice_call'
                                    : widget.channelName,
                                role: ClientRole.Broadcaster,
                                token: widget.token));
                      }
                      if (widget.type == 'video') {
                        Navigator.pop(context);
                        NavigationController.push(
                            context,
                            CallPage(
                                channelName: widget.token.isEmpty
                                    ? 'voice_call'
                                    : widget.channelName,
                                role: ClientRole.Broadcaster,
                                token: widget.token));
                      }
                    },
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.greenAccent,
                    padding: const EdgeInsets.all(15.0),
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
            ),
          ],
        ),
      ),
    );
  }

  _onCallEnd(context) {
    Navigator.pop(context);
  }
}
