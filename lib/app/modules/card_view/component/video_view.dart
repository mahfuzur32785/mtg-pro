import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoView extends StatefulWidget {
  const VideoView({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  // late VideoPlayerController _controller;
  late YoutubePlayerController _controller;
  String? videoId = '';
  @override
  void initState() {
    // _controller = VideoPlayerController.network(widget.url,)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    videoId = YoutubePlayerController.convertUrlToId(widget.url);
    print(videoId);
    _controller = YoutubePlayerController.fromVideoId(
      videoId: "$videoId",
      autoPlay: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    // return _controller.value.isInitialized
    //     ? AspectRatio(
    //         aspectRatio: _controller.value.aspectRatio,
    //         child: VideoPlayer(_controller),
    //       )
    //     : const Center(
    //         child: CircularProgressIndicator(),
    //       );
    return YoutubePlayer(
      controller: _controller,
      aspectRatio: 16/9,
    );
  }
}
