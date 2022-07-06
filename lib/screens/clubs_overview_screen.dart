import 'dart:async';

import 'package:all_about_clubs/models/club.dart';
import 'package:all_about_clubs/screens/club_detail_screen.dart';
import 'package:all_about_clubs/screens/loading_screen.dart';
import 'package:all_about_clubs/services/backend_service.dart';
import 'package:all_about_clubs/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ClubsOverviewScreen extends StatefulWidget {
  const ClubsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ClubsOverviewScreen> createState() => _ClubsOverviewScreenState();
}

class _ClubsOverviewScreenState extends State<ClubsOverviewScreen> {
  bool isReconnecting = false;
  Timer? timer;
  int seconds = 5;
  List<Club>? allClubs;
  bool isLoadingIcons = true;
  bool sortByValue = false;
  @override
  void initState() {
    super.initState();
    getAllClubs();
    startTimer();
  }

  Future<void> getAllClubs() async {
    var allClubs = await BackendService().getListOfClubs();
    setState(() {
      this.allClubs = allClubs;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (allClubs != null) timer.cancel();
      if (seconds <= 0) {
        getAllClubs();
        setState(() {
          isReconnecting = true;
          seconds = 5;
        });
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (allClubs == null) {
      return Material(
        child: Stack(children: [
          const Center(child: LoadingScreen()),
          if (isReconnecting)
            Center(
              child: Text(
                "Trying to reconnect in  $seconds seconds",
                textScaleFactor: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ]),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text(APP_TITLE),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.sort,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    sortByValue = !sortByValue;
                  });
                },
              )
            ],
            backgroundColor: THEME_COLOR,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: generateClubTiles(sortByValue),
            ),
          ));
    }
  }

  List<Widget> generateClubTiles(bool sortedByValue) {
    sortedByValue
        ? allClubs!.sort((a, b) => b.value.compareTo(a.value))
        : allClubs!.sort((a, b) => a.name.compareTo(b.name));

    List<Widget> allClubTiles = [];
    for (var i = 0; i < allClubs!.length; i++) {
      allClubTiles.add(InkWell(
        onTap: (() => Navigator.push(
            context,
            PageTransition(
                child: ClubDetailScreen(club: allClubs!.elementAt(i)),
                type: PageTransitionType.rightToLeft,
                isIos: true))),
        child: Card(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(19.0),
              child: Stack(children: [
                Row(children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      allClubs!.elementAt(i).image,
                      fit: BoxFit.scaleDown,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CircularProgressIndicator(
                          color: THEME_COLOR,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 5,
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: allClubs!.elementAt(i).name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.black)),
                                TextSpan(
                                    text: "\n${allClubs!.elementAt(i).country}",
                                    style: const TextStyle(color: Colors.grey))
                              ]),
                            ),
                          ),
                        ],
                      )),
                ]),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Text("${allClubs!.elementAt(i).value} Millionen"))
              ]),
            ),
          ),
        ),
      ));
    }
    return allClubTiles;
  }
}
