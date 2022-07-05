import 'package:json_annotation/json_annotation.dart';

part 'club.g.dart';

@JsonSerializable()
class Club {
  Club(
      {required this.name,
      required this.country,
      required this.value,
      required this.image,
      required this.european_titles});
  String name;
  String country;
  int value;
  String image;
  int european_titles;

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);

  Map<String, dynamic> toJson() => _$ClubToJson(this);
}
