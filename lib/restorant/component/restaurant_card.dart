import 'package:flutter/material.dart';
import 'package:inflearn_cf2_actual/common/const/colors.dart';
import 'package:inflearn_cf2_actual/restorant/model/restaurant_detail_model.dart';
import 'package:inflearn_cf2_actual/restorant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.isDetail = false,
    this.detail,
  });

  //이미지
  final Widget image;

  //레스토랑 이름
  final String name;

  //레스토랑 태그
  final List<String> tags;

  //평점 갯수
  final int ratingsCount;

  //배송걸리는 시간
  final int deliveryTime;

  //배달비용
  final int deliveryFee;

  //평균 평점
  final double ratings;

  //디테일 화면인지 여부
  final bool isDetail;

  //상세내용
  final String? detail;

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
      isDetail: isDetail,
      detail: model is RestaurantDetailModel ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(isDetail)
          image,
        if(!isDetail)
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image,
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tags.join(' · '),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: BODY_TEXT_COLOR,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _IconText(icon: Icons.star, label: ratings.toStringAsFixed(1)),
                  renderDot(),
                  _IconText(icon: Icons.receipt, label: ratingsCount.toString(),),
                  renderDot(),
                  _IconText(icon: Icons.access_time, label: '$deliveryTime분'),
                  renderDot(),
                  _IconText(icon: Icons.monetization_on, label: '배달비 ${deliveryFee ==0 ? '무료' : deliveryFee}'),
                ],
              ),
              if(isDetail !=null && isDetail && detail != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(detail!),
                ),
            ],
          ),
        )
      ],
    );
  }
  Widget renderDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text('·', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: PRIMARY_COLOR,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

