import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../utils/colors.dart';

class VideoPage extends StatefulWidget {
  String vedioUrl = "";
  VideoPage(String vedioUrl){
    this.vedioUrl = vedioUrl;
  }

  @override
  State<VideoPage> createState() => _VideoPageState(vedioUrl);
}

class _VideoPageState extends State<VideoPage> {
  bool vrMode = true;
  late VideoPlayerController _controller;
  String vedioUrl = "";

  _VideoPageState(String vedioUrl){
    this.vedioUrl = vedioUrl;
  }
  @override
  void initState() {
    _controller = VideoPlayerController.network(vedioUrl);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((value) {
      setState(() {});
    });
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: vrMode ? vr_player() : normalView(),
    );
  }

  normalView() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: VideoProgressIndicator(
            //     _controller,
            //     allowScrubbing: true,
            //   ),
            // ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //backgroundColor: ColorUtils.primary,
              ),
              onPressed: () {
                setState(() {
                  vrMode = true;
                });
              },
              child: Text('Watch in VR'),
            ),
          ],
        ),
      ),
    );
  }

  InkWell vr_player() {
    return InkWell(
      onTap: () {
        setState(() {
          if (_controller.value.isPlaying)
            _controller.pause();
          else {
            _controller.play();
          }
        });
      },
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              // color: Colors.amberAccent,
              alignment: Alignment(.9, 0),
              child: RotatedBox(
                quarterTurns: 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //backgroundColor: ColorUtils.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      vrMode = true;
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Exit VR'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String videoUrl =
    'https://rr3---sn-gwpa-civk.googlevideo.com/videoplayback?expire=1658528859&ei=-8_aYs-9H7GX2LYPlJ6j8Ak&ip=216.131.82.16&id=o-AHvWP0UWkTx0HrpyRJlR_tvtn_2p8Ez8E-nqzbD6HMOv&itag=18&source=youtube&requiressl=yes&spc=lT-KhoGQiOVeijFw98fV4KHwhnfD7bk&vprv=1&mime=video%2Fmp4&ns=0xPD-fvD4M4maOXuKf_70dEH&gir=yes&clen=20986982&ratebypass=yes&dur=260.109&lmt=1613400456453983&fexp=24001373,24007246&c=WEB&rbqsm=fr&txp=5538232&n=iZVBiIWb3m8mIA&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cspc%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIhAMvVlJtMGVyrjgvNlabbQasG6w3uUCjm0ms5WZky8s10AiBVlQc59QN7Lf4cvcEHpDaC2-vxtHF0EyqKYxbcrJmQfg%3D%3D&redirect_counter=1&rm=sn-ab5eer76&req_id=679fda268d73a3ee&cms_redirect=yes&cmsv=e&ipbypass=yes&mh=sO&mip=2409:4043:4b0f:9ace:61c4:b40c:d741:3b27&mm=31&mn=sn-gwpa-civk&ms=au&mt=1658508754&mv=u&mvi=3&pcm2cms=yes&pl=48&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pcm2cms,pl&lsig=AG3C_xAwRQIhAPdSWJ5OoKlJvS01bhjGLtFx4dyOFTWBM-xJyDzCJsCGAiAoa8YTA28QG4GRyFi8KEliEiHGQDaOUIdLlR4s5_DWDg%3D%3D';
