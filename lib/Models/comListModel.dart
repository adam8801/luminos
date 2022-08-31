import 'package:json_annotation/json_annotation.dart';
import 'package:network_2/Models/commentModel.dart';

part 'comListModel.g.dart';

@JsonSerializable()
class ComListModel{
  List<CommentModel> comment;

  ComListModel({this.comment});

  factory ComListModel.fromJson(Map<String, dynamic> json) =>
      _$ComListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ComListModelToJson(this);

}