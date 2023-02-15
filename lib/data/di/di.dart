import 'package:big_news_project/data/api/api.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt di = GetIt.instance;

void setUp(){
di.registerLazySingleton(() => Dio(BaseOptions(baseUrl:"https://www.terabayt.uz/" )));
di.registerLazySingleton(() => AppApi(di.get<Dio>()));
}