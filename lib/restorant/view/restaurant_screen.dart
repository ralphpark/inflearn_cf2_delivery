import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inflearn_cf2_actual/common/const/data.dart';
import 'package:inflearn_cf2_actual/common/dio/dio.dart';
import 'package:inflearn_cf2_actual/restorant/component/restaurant_card.dart';
import 'package:inflearn_cf2_actual/restorant/model/restaurant_model.dart';
import 'package:inflearn_cf2_actual/restorant/repository/restaurant_repository.dart';
import 'package:inflearn_cf2_actual/restorant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();
    dio.interceptors.add(
      CustomInterceptor(
        storage: storage,
      ),
    );
    final resp = await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant').paginate();
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<List<RestaurantModel>>(
                  future: paginateRestaurant(),
                  builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.separated(
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {

                          final pitem = snapshot.data![index];
                          //parsed = 변환됐다

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RestaurantDetailScreen(
                                    id: pitem.id,
                                  ),
                                ),
                              );
                            },
                            child: RestaurantCard.fromModel(
                              model: pitem,
                            ),
                          );
                        }
                    );
                  }
              )
          )
      ),
    );
  }
}
