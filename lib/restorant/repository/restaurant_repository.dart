
import 'package:inflearn_cf2_actual/common/model/cursor_pagination_model.dart';
import 'package:inflearn_cf2_actual/restorant/model/restaurant_model.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {

  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
  _RestaurantRepository;

  // http://$ip/restaurant
  @GET('/')
  @Headers({
    'accessToken':'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate();
}

