part of '../stories.dart';
class AudioPlayerWidget extends StatefulWidget {
  final List audioList;
  final bool isPremium;

  const AudioPlayerWidget({
    super.key,
    required this.audioList,
    required this.isPremium,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _player = AudioPlayer();
  String? currentUrl;
  bool playing = false;

  void _play(String url) async {
    if (playing && currentUrl == url) {
      await _player.pause();
      setState(() => playing = false);
    } else {
      try {
        await _player.setUrl(url);
        await _player.play();
        setState(() {
          playing = true;
          currentUrl = url;
        });
      } catch (e) {
        print("Error playing audio: $e");
      }
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.audioList.map((a) {
        final url = a['url'] as String;
        return IconButton(
          icon: Icon(
            playing && currentUrl == url ? Icons.pause_circle : Icons.play_circle,
            color: Colors.green[700],
            size: 36,
          ),
          onPressed: () => _play(url),
        );
      }).toList(),
    );
  }
}
