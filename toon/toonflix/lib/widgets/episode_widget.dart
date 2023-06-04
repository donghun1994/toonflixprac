import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final String webtoonId;
  final WebtoonEpisodeModel episode;

  onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.green,
            ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  offset: const Offset(3, 3),
                  color: Colors.black.withOpacity(0.3))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
