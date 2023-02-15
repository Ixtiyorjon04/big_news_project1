import 'package:big_news_project/data/model/category_model.dart';
import 'package:big_news_project/data/model/post_model.dart';
import 'package:dio/dio.dart';

class AppApi {
  final Dio _dio;

  AppApi(this._dio);

  Future<List<Categories>> getCategories() async {
    final response = await _dio.get("api.php?action=categories");
    final list = response.data as List;
    return list.map((e) => Categories.fromJson(e)).toList();
  }
Future <List<Post>> getPost(int categoryId)async{
 final response =await _dio.get("api.php?action=posts&first_update=1613122152&last_update=0&category=$categoryId");
final list =response.data as List;
return list.map((e) => Post.fromJson(e)).toList();
}
}
