import 'package:all_about_clubs/models/club.dart';
import 'package:all_about_clubs/screens/loading_screen.dart';
import 'package:all_about_clubs/services/backend_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClubsOverviewScreen extends StatefulWidget {
  const ClubsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ClubsOverviewScreen> createState() => _ClubsOverviewScreenState();
}

class _ClubsOverviewScreenState extends State<ClubsOverviewScreen> {
  List<Club>? allClubs;
  @override
  void initState() {
    super.initState();
    getAllClubs();
  }

  Future<void> getAllClubs() async {
    var _allClubs = await BackendService().getListOfClubs();
    setState(() {
      allClubs = _allClubs;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (allClubs == null) {
      return const Center(child: LoadingScreen());
    } else {
      return Scaffold(
          appBar: AppBar(),
          body: Text(AppLocalizations.of(context)!.details2("Real Madrid", 2)));
    }
  }
}
