import 'package:json_annotation/json_annotation.dart';
import 'package:network_2/Models/pageModel.dart';

part 'paListModel.g.dart';

@JsonSerializable()
class PaListModel{
  List<PageModel> data;

  PaListModel({this.data});

  factory PaListModel.fromJson(Map<String, dynamic> json) =>
      _$PaListModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaListModelToJson(this);

}