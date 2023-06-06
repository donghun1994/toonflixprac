import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, List<Map<String, String>>> datas = {};
  late String currentlocation;
  final Map<String, String> locationTypeToString = {
    'ara': '아라동',
    'ora': '오라동',
    'donam': '도남동'
  };

  @override
  void initState() {
    super.initState();
    datas = {
      "ara": [
        {
          "cid": "1",
          "image": "assets/images/ara-1.jpg",
          "title": "네메시스 축구화275",
          "location": "제주 제주시 아라동",
          "price": "30000",
          "likes": "2"
        },
        {
          "cid": "2",
          "image": "assets/images/ara-2.jpg",
          "title": "LA갈비 5kg팔아요~",
          "location": "제주 제주시 아라동",
          "price": "100000",
          "likes": "5"
        },
        {
          "cid": "3",
          "image": "assets/images/ara-3.jpg",
          "title": "치약팝니다",
          "location": "제주 제주시 아라동",
          "price": "5000",
          "likes": "0"
        },
        {
          "cid": "4",
          "image": "assets/images/ara-4.jpg",
          "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
          "location": "제주 제주시 아라동",
          "price": "2500000",
          "likes": "6"
        },
        {
          "cid": "5",
          "image": "assets/images/ara-5.jpg",
          "title": "디월트존기임팩",
          "location": "제주 제주시 아라동",
          "price": "150000",
          "likes": "2"
        },
        {
          "cid": "6",
          "image": "assets/images/ara-6.jpg",
          "title": "갤럭시s10",
          "location": "제주 제주시 아라동",
          "price": "180000",
          "likes": "2"
        },
        {
          "cid": "7",
          "image": "assets/images/ara-7.jpg",
          "title": "선반",
          "location": "제주 제주시 아라동",
          "price": "15000",
          "likes": "2"
        },
        {
          "cid": "8",
          "image": "assets/images/ara-8.jpg",
          "title": "냉장 쇼케이스",
          "location": "제주 제주시 아라동",
          "price": "80000",
          "likes": "3"
        },
        {
          "cid": "9",
          "image": "assets/images/ara-9.jpg",
          "title": "대우 미니냉장고",
          "location": "제주 제주시 아라동",
          "price": "30000",
          "likes": "3"
        },
        {
          "cid": "10",
          "image": "assets/images/ara-10.jpg",
          "title": "멜킨스 풀업 턱걸이 판매합니다.",
          "location": "제주 제주시 아라동",
          "price": "50000",
          "likes": "7"
        },
      ],
      "ora": [
        {
          "cid": "11",
          "image": "assets/images/ora-1.jpg",
          "title": "LG 통돌이세탁기 15kg(내부",
          "location": "제주 제주시 오라동",
          "price": "150000",
          "likes": "13"
        },
        {
          "cid": "12",
          "image": "assets/images/ora-2.jpg",
          "title": "3단책장 전면책장 가져가실분",
          "location": "제주 제주시 오라동",
          "price": "무료나눔",
          "likes": "6"
        },
        {
          "cid": "13",
          "image": "assets/images/ora-3.jpg",
          "title": "브리츠 컴퓨터용 스피커",
          "location": "제주 제주시 오라동",
          "price": "1000",
          "likes": "4"
        },
        {
          "cid": "14",
          "image": "assets/images/ora-4.jpg",
          "title": "안락 의자",
          "location": "제주 제주시 오라동",
          "price": "10000",
          "likes": "1"
        },
        {
          "cid": "15",
          "image": "assets/images/ora-5.jpg",
          "title": "어린이책 무료드림",
          "location": "제주 제주시 오라동",
          "price": "무료나눔",
          "likes": "1"
        },
        {
          "cid": "16",
          "image": "assets/images/ora-6.jpg",
          "title": "어린이책 무료드림",
          "location": "제주 제주시 오라동",
          "price": "무료나눔",
          "likes": "0"
        },
        {
          "cid": "17",
          "image": "assets/images/ora-7.jpg",
          "title": "칼세트 재제품 팝니다",
          "location": "제주 제주시 오라동",
          "price": "20000",
          "likes": "5"
        },
        {
          "cid": "18",
          "image": "assets/images/ora-8.jpg",
          "title": "아이팜장난감정리함팔아요",
          "location": "제주 제주시 오라동",
          "price": "30000",
          "likes": "29"
        },
        {
          "cid": "19",
          "image": "assets/images/ora-9.jpg",
          "title": "한색책상책장수납장세트 팝니다.",
          "location": "제주 제주시 오라동",
          "price": "1500000",
          "likes": "1"
        },
        {
          "cid": "20",
          "image": "assets/images/ora-10.jpg",
          "title": "순성 데일리 오가닉 카시트",
          "location": "제주 제주시 오라동",
          "price": "60000",
          "likes": "8"
        },
      ]
    };
    currentlocation = 'ara';
  }

  final oCcy = NumberFormat("#,###", "ko_KR");
  String calcStringTowon(String priceString) {
    return "${oCcy.format(int.parse(priceString))}원";
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      elevation: 1,
      title: GestureDetector(
        onTap: () {
          print("click");
        },
        child: PopupMenuButton<String>(
          offset: const Offset(-3, 30),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              1),
          onSelected: (String where) {
            setState(() {
              currentlocation = where;
            });
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(value: "ara", child: Text("아라동")),
              const PopupMenuItem(value: "ora", child: Text("오라동")),
              const PopupMenuItem(value: "donam", child: Text("도남동"))
            ];
          },
          child: Row(
            children: [
              Text(locationTypeToString[currentlocation] ?? ''),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/svg/bell.svg",
            width: 22,
          ),
        ),
      ],
    );
  }

  Widget _bodyWidget() {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: Colors.black.withOpacity(0.5),
        );
      },
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    datas["ara"]![index]["image"].toString(),
                    width: 100,
                    height: 100,
                  )),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        datas["ara"]![index]["title"].toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        datas["ara"]![index]["location"].toString(),
                        style: TextStyle(
                            fontSize: 13, color: Colors.black.withOpacity(0.5)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        calcStringTowon(
                            datas["ara"]![index]["price"].toString()),
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/heart_off.svg",
                                width: 13,
                                height: 13,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(datas["ara"]![index]["likes"].toString()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
