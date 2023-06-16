import 'package:shop_app/domain/api_client/category_api_client.dart';
import 'package:shop_app/domain/entity/categories_response.dart';

class CategoryService {
  final _categoryApiClient = CategoryApiClient();

  Future<CategoriesResponse> mainScreenCategories() async {
    return _categoryApiClient.getCategories();
  }
}
