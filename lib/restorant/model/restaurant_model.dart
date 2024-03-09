// import 'package:inflearn_cf2_actual/common/const/data.dart';
// import 'package:inflearn_cf2_actual/common/utils/data_utils.dart';
// import 'package:inflearn_cf2_actual/restorant/component/restaurant_card.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'restaurant_model.g.dart';
//
// enum RestaurantPriceRange {
//   expensive,
//   medium,
//   cheap,
// }
//
// @JsonSerializable()
// class RestaurantModel {
//   final String id;
//   final String name;
//   //자동생성된 g.dart 파일에서 변환필요시
//   //작성 후 터미널에서 flutter pub run build_runner build 다시 실행
//   // 무조건 static으로 작성해야 한다.
//   // 새로 생성하거나 수정시 자동으로 빌드 진행하려면 flutter pub run build_runner watch 실행
//   @JsonKey(
//     fromJson: DataUtils.pathToUrl,
//     // toJson: thumbUrlToJson,
//   )
//   final String thumbUrl;
//   final List<String> tags;
//   final RestaurantPriceRange priceRange;
//   final double ratings;
//   final int ratingsCount;
//   final int deliveryTime;
//   final int deliveryFee;
//
//   RestaurantModel({
//     required this.id,
//     required this.name,
//     required this.thumbUrl,
//     required this.tags,
//     required this.priceRange,
//     required this.ratings,
//     required this.ratingsCount,
//     required this.deliveryTime,
//     required this.deliveryFee,
//   });
//
//   // Json으로 부터 RestaurantModel(인스턴스)을 생성하는 factory 생성
//   factory RestaurantModel.fromJson({
//     required Map<String, dynamic> json,
//   }) => _$RestaurantModelFromJson(json);
// }
//
//   // RestaurantModel을 Json으로 변환하는 toJson 생성
//   // Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
//
//
//   //json_serializable을 사용하지 않을 경우 아래와 같이 factory를 생성해야 한다.
//   // factory RestaurantModel.fromJson({required Map<String, dynamic> json}) {
//   //   return RestaurantModel(
//   //     id: json['id'],
//   //     name: json['name'],
//   //     thumbUrl: 'http://$ip${json['thumbUrl']}',
//   //     tags: List<String>.from(json['tags']),
//   //     priceRange: RestaurantPriceRange.values.firstWhere(
//   //           (e) => e.name == json['priceRange'],
//   //       orElse: () => RestaurantPriceRange.midium,
//   //     ),
//   //     ratings: json['ratings'],
//   //     ratingsCount: json['ratingsCount'],
//   //     deliveryTime: json['deliveryTime'],
//   //     deliveryFee: json['deliveryFee'],
//   //   );
//   // }
import 'package:inflearn_cf2_actual/common/const/data.dart';
import 'package:inflearn_cf2_actual/common/utils/data_utils.dart';
import 'package:inflearn_cf2_actual/restorant/component/restaurant_card.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => _$RestaurantModelFromJson(json);
}