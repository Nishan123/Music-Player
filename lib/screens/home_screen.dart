import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:music_player/screens/player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: whiteColor,
                size: 28,
              ))
        ],
        leading: const Icon(
          Icons.sort_rounded,
          color: whiteColor,
        ),
        title: Text(
          "Music Player",
          style: ourStyle(family: bold, size: 21),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Songs Found",
                style: ourStyle(),
              ),
            );
          } else {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Obx(
                          () => ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: Text(
                              snapshot.data![index].displayNameWOExt,
                              maxLines: 2,
                              style: ourStyle(
                                size: 13,
                                color: whiteColor,
                                family: semiBold,
                              ),
                            ),
                            subtitle: Text(
                              "${snapshot.data![index].artist}",
                              style: ourStyle(size: 11, color: whiteColor),
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(
                                Icons.music_note,
                                color: whiteColor,
                                size: 28,
                              ),
                            ),
                            trailing: controller.playIndex.value == index &&
                                    controller.isPlaying.value
                                ?  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.pause_circle,
                                      size: 25,
                                      color: whiteColor,
                                    ))
                                :  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.play_circle,
                                      size: 25,
                                      color: whiteColor,
                                    )),
                            splashColor: whiteColor,
                            onTap: () {
                              controller.palySong(
                                  snapshot.data![index].uri, index);
                              Get.to(() => PlayerScreen(
                                    data: snapshot.data!,
                                  ));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
