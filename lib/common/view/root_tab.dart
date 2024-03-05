import 'package:flutter/material.dart';
import 'package:inflearn_cf2_actual/common/const/colors.dart';
import 'package:inflearn_cf2_actual/common/layout/default_layout.dart';
import 'package:inflearn_cf2_actual/restorant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin{
  late TabController controller;

  int index = 0;

  initState(){
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener(){
    setState(() {
      index = controller.index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '코팩 딜리버리',
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            RestaurantScreen(),
            Center(child: Container(child: Text('음식'),)),
            Center(child: Container(child: Text('주문'),)),
            Center(child: Container(child: Text('프로필'),)),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: BODY_TEXT_COLOR,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed, // shifting : 선택된 타입 크게
          onTap: (int index){
            controller.animateTo(index);
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '홈'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.fastfood_outlined),
                label: '음식'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                label: '주문'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                label: '프로필'
            ),
          ],
        ),
    );
  }
}
