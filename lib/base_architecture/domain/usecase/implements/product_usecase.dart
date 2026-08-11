import 'package:b2b_freshmore/base_architecture/core/api_response.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/usecase/baste_usecase.dart';

class ProductUsecase extends CrudUseCase<ProductData> {
  ProductUsecase({required super.repository});

  List<ProductData> _cachedProducts = [];

  @override
  Future<ApiResponse<List<T>>> getList<T>({
    required String endpoint,
    required List<T> Function(dynamic) parser,
    Map<String, dynamic>? queryParams,
    bool isList = true,
  }) async {
    final bool shouldAppend = queryParams?["shouldAppend"] ?? false;
    final bool forceRefresh = queryParams?["forceRefresh"] ?? false;

    final String selectedCategory = queryParams?["category"] ?? "All";

    if (forceRefresh || shouldAppend) {
      final response = await super.getList(
        endpoint: endpoint,
        parser: parser,
        queryParams: queryParams,
        isList: true,
      );

      if (response.success && response.data != null) {
        final incomingData = response.data! as List<ProductData>;
        if (shouldAppend) {
          _cachedProducts.addAll(incomingData);
        } else {
          _cachedProducts = incomingData;
        }
      }

      final result = _filterLocalData(selectedCategory);
      return ApiResponse(success: true, data: result as List<T>);
    } else {
      final filteredList = _filterLocalData(selectedCategory);
      return ApiResponse(success: true, data: filteredList as List<T>);
    }
  }

  List<ProductData> _filterLocalData(String category) {
    if (category == "All") return _allUniqueProducts();

    return _cachedProducts.where((product) {
      final pCategory = product.categoryName?.toLowerCase() ?? "";
      return pCategory == category.toLowerCase();
    }).toList();
  }

  List<ProductData> _allUniqueProducts() => _cachedProducts.toSet().toList();
}
