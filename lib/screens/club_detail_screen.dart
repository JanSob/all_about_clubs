import 'package:all_about_clubs/models/club.dart';
import 'package:all_about_clubs/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClubDetailScreen extends StatefulWidget {
  const ClubDetailScreen({Key? key, required this.club}) : super(key: key);
  final Club club;

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        backgroundColor: THEME_COLOR,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade800,
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                      child: Text(
                        widget.club.country,
                        overflow: TextOverflow.visible,
                        softWrap: false,
                        textScaleFactor: 1.6,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Image.network(
                      widget.club.image,
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
                ),
                const Expanded(flex: 1, child: SizedBox())
              ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textScaleFactor: 1.2,
                text: TextSpan(children: [
                  TextSpan(
                      text: AppLocalizations.of(context)!.details1Prefix,
                      style: const TextStyle(color: Colors.black)),
                  TextSpan(
                      text: widget.club.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  TextSpan(
                      text: AppLocalizations.of(context)!.details1Postfix(
                          widget.club.country, widget.club.value),
                      style: const TextStyle(color: Colors.black)),
                  TextSpan(
                      text:
                          "\n${AppLocalizations.of(context)!.details2(widget.club.name, widget.club.european_titles)}",
                      style: const TextStyle(color: Colors.black))
                ]),
              ),
            ), //Text("\n${AppLocalizations.of(context)!.details2(widget.club.name, widget.club.european_titles)}"),
          )
        ],
      ),
    ));
  }
}
