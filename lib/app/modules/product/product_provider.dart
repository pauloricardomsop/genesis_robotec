import 'package:dio/dio.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';

import '../../core/models/api_response_model.dart';

class ProductProvider {
  static Future<ApiResponse<List<Kit>>> getKits() async {
    try {
      final response =
          await Dio().get('https://863fb439-4374-42c4-b591-4b6afbfdc956.mock.pstmn.io/kits');
      return ApiResponse.complete(response.data.map<Kit>((e) => Kit.fromJson(e)).toList());
    } catch (e) {
      return ApiResponse.error(
          DioError(requestOptions: RequestOptions(path: ''), error: e.toString()));
    }
  }

  static Future<ApiResponse<dynamic>> getArchive(String link) async {
    try {
      final response = await Dio().get(link);
      return ApiResponse.complete(response.data);
    } catch (e) {
      throw ApiResponse.error(
          DioError(requestOptions: RequestOptions(path: ''), error: e.toString()));
    }
  }
}
