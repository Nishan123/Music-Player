import 'package:flutter/material.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: Icon(
                  Icons.music_note,
                  size: 40,
                ),
                alignment: Alignment.center,
              )),
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
                        "Music Name",
                        style: ourStyle(
                            family: semiBold, size: 20, color: bgDarkColor),
                      ),
                      Text(
                        "By.Artist Name",
                        style: ourStyle(
                            family: light, size: 15, color: bgDarkColor),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Text("00:00"),
                          Expanded(
                              child: Slider(
                                  value: 0.0,
                                  thumbColor: whiteColor,
                                  activeColor: sliderColor,
                                  inactiveColor: bgColor,
                                  onChanged: (newValue) {})),
                          Text("04:00"),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              color: Colors.black,
                              iconSize: 35,
                              onPressed: () {},
                              icon: Icon(Icons.skip_previous)),
                          IconButton(
                              color: Colors.black,
                              iconSize: 40,
                              onPressed: () {},
                              icon: Icon(Icons.play_circle_fill)),
                          IconButton(
                              color: Colors.black,
                              iconSize: 35,
                              onPressed: () {},
                              icon: Icon(Icons.skip_next)),
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
    );
  }
}
