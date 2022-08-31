import 'package:json_annotation/json_annotation.dart';
import 'package:network_2/Models/profileModel.dart';

part 'prListModel.g.dart';

@JsonSerializable()
class PrListModel{
  List<ProfileModel> data;

  PrListModel({this.data});

  factory PrListModel.fromJson(Map<String, dynamic> json) =>
      _$PrListModelFromJson(json);
  Map<String, dynamic> toJson() => _$PrListModelToJson(this);

}