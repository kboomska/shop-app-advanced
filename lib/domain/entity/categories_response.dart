import 'package:json_annotation/json_annotation.dart';

import 'package:shop_app/domain/entity/category.dart';

part 'categories_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CategoriesResponse {
  List<Category> categories;

  CategoriesResponse({
    required this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}
