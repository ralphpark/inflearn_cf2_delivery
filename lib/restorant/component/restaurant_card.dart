import 'package:flutter/material.dart';
import 'package:inflearn_cf2_actual/common/const/colors.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.rating,
  });

  //이미지
  final Widget image;

  //레스토랑 이름
  final String name;

  //레스토랑 태그
  final List<String> tags;

  //평점 갯수
  final int ratingCount;

  //배송걸리는 시간
  final int deliveryTime;

  //배달비용
  final int deliveryFee;

  //평균 평점
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image,
        ),
        SizedBox(height: 16),
        Column(
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
                _IconText(icon: Icons.star, label: rating.toStringAsFixed(1)),
                renderDot(),
                _IconText(icon: Icons.receipt, label: ratingCount.toString(),),
                renderDot(),
                _IconText(icon: Icons.access_time, label: '$deliveryTime분'),
                renderDot(),
                _IconText(icon: Icons.monetization_on, label: '배달비 ${deliveryFee ==0 ? '무료' : deliveryFee}원'),
              ],
            ),
          ],
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

