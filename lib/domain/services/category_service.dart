import 'package:shop_app/ui/widgets/main_screen/main_screen_view_model.dart';
import 'package:shop_app/domain/api_client/category_api_client.dart';
import 'package:shop_app/domain/entity/categories_response.dart';

class CategoryService implements MainScreenViewModelCategoryProvider {
  final CategoryApiClient categoryApiClient;

  CategoryService({
    required this.categoryApiClient,
  });

  @override
  Future<CategoriesResponse> mainScreenCategories() async {
    return categoryApiClient.getCategories();
  }
}
