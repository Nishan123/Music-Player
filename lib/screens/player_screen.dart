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
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.menu_outlined))
        ],
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
                        nullArtworkWidget: Container(
                          height: 150,
                          width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                          
                        ),
                          child: const Icon(
                            Icons.music_note,
                            size: 90,
                            color: Color.fromARGB(255, 151, 151, 151),
                          ),
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
                            color: whiteColor,
                          ),
                        ),
                        Text(
                          'By.${data[controller.playIndex.value].artist.toString()}',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: ourStyle(
                              family: light, size: 15, color: whiteColor),
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => Row(
                            children: [
                              Expanded(
                                  child: Slider(
                                      thumbColor: whiteColor,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white30,
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.position.value,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(controller.duration.value,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                color: whiteColor,
                                iconSize: 50,
                                onPressed: () {
                                  controller.palySong(
                                      data[controller.playIndex.value - 1].uri,
                                      controller.playIndex.value - 1);
                                },
                                icon: const Icon(Icons.skip_previous_rounded)),
                            Obx(
                              () => IconButton(
                                  color: whiteColor,
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
                                color: whiteColor,
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
