import 'package:json_annotation/json_annotation.dart';
import 'package:network_2/Models/blogModel.dart';

part 'blListModel.g.dart';

@JsonSerializable()
class BlListModel{
  List<BlogModel> data;

  BlListModel({this.data});

  factory BlListModel.fromJson(Map<String, dynamic> json) =>
      _$BlListModelFromJson(json);
  Map<String, dynamic> toJson() => _$BlListModelToJson(this);

}