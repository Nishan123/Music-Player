import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final List<SongModel> data;
  const PlayerScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: [
                Obx(
                  () => Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: QueryArtworkWidget(
                        id: data[controller.playIndex.value].id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: double.infinity,
                        artworkWidth: double.infinity,
                        nullArtworkWidget: const Icon(
                          Icons.music_note,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25))),
                    child: Column(
                      children: [
                        Text(
                          data[controller.playIndex.value].displayNameWOExt,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: ourStyle(
                            family: semiBold,
                            size: 20,
                            color: bgDarkColor,
                          ),
                        ),
                        Text(
                          'By.${data[controller.playIndex.value].artist.toString()}',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: ourStyle(
                              family: light, size: 15, color: bgDarkColor),
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => Row(
                            children: [
                              Text(controller.position.value),
                              Expanded(
                                  child: Slider(
                                      thumbColor: whiteColor,
                                      activeColor: Colors.white,
                                      inactiveColor: bgColor,
                                      min: const Duration(seconds: 0)
                                          .inSeconds
                                          .toDouble(),
                                      max: controller.max.value,
                                      value: controller.value.value,
                                      onChanged: (newValue) {
                                        controller.changeDurationToSeconds(
                                            newValue.toInt());
                                        newValue = newValue;
                                      })),
                              Text(controller.duration.value),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                color: bgDarkColor,
                                iconSize: 50,
                                onPressed: () {
                                  controller.palySong(
                                      data[controller.playIndex.value - 1].uri,
                                      controller.playIndex.value - 1);
                                },
                                icon: const Icon(Icons.skip_previous_rounded)),
                            Obx(
                              () => IconButton(
                                  color: bgDarkColor,
                                  iconSize: 60,
                                  onPressed: () {
                                    if (controller.isPlaying.value) {
                                      controller.audioPlayer.pause();
                                      controller.isPlaying(false);
                                    } else {
                                      controller.audioPlayer.play();
                                      controller.isPlaying(true);
                                    }
                                  },
                                  icon: controller.isPlaying.value
                                      ? const Icon(Icons.pause_circle_filled)
                                      : const Icon(Icons.play_circle_fill)),
                            ),
                            IconButton(
                                color: bgDarkColor,
                                iconSize: 50,
                                onPressed: () {
                                  controller.palySong(
                                      data[controller.playIndex.value + 1].uri,
                                      controller.playIndex.value + 1);
                                },
                                icon: const Icon(Icons.skip_next_rounded)),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
