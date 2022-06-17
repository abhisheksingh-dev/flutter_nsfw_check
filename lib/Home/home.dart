import 'package:flutter/material.dart';
import 'package:nsfw/Home/homeWidgets.dart';
import 'package:nsfw/mediaUploadCheck/mediaUploadCheck.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeWidgets _homeWidgets = HomeWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Flutter NSFW Check"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _homeWidgets.buildCards(
                  context: context,
                  title: "Media Upload Check",
                  icon: Icons.camera,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MediaUploadCheck(),
                      ),
                    );
                  },
                ),
                _homeWidgets.buildCards(
                  context: context,
                  title: "Mock Cloud Data Check",
                  icon: Icons.cloud,
                  function: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Coming Soon"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
