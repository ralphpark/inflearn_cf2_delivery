
import 'package:inflearn_cf2_actual/common/const/data.dart';
import 'package:inflearn_cf2_actual/common/utils/data_utils.dart';
import 'package:inflearn_cf2_actual/restorant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel>prouducts;

  RestaurantDetailModel({
    required super.id,
    required super.name,

    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.prouducts,
  });



  factory RestaurantDetailModel.fromJson({
    required Map<String, dynamic> json,
  }){
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere(
            (e) => e.name == json['priceRange'],
        orElse: () => RestaurantPriceRange.medium,
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      prouducts: json['products'].map<RestaurantProductModel>(
              (e) => RestaurantProductModel.fromJson(json: e),
        ).toList(),
    );
  }
}


class RestaurantProductModel{
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory RestaurantProductModel.fromJson({
    required Map<String, dynamic> json,
  }){
    return RestaurantProductModel(
      id: json['id'],
      name: json['name'],
      imgUrl: 'http://$ip${json['imgUrl']}',
      detail: json['detail'],
      price: json['price'],
    );
  }

}

