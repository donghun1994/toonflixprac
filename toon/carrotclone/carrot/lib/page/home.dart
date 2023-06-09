import 'package:carrot/page/detail.dart';
import 'package:carrot/repository/contents_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String currentlocation;
  late ContentsRepository contentsRepository = ContentsRepository();
  final Map<String, String> locationTypeToString = {
    'ara': '아라동',
    'ora': '오라동',
    'donam': '도남동'
  };

  @override
  void initState() {
    super.initState();
    currentlocation = 'ara';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
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

  _loadContents() {
    return contentsRepository.loadContentsFromLocation(currentlocation);
  }

  Widget _makeDataList(List<Map<String, String>> datas) {
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
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DetailContentView(
                  data: datas[index],
                );
              },
            ));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Hero(
                      tag: datas[index]["cid"].toString(),
                      child: Image.asset(
                        datas[index]["image"].toString(),
                        width: 100,
                        height: 100,
                      ),
                    )),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datas[index]["title"].toString(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          datas[index]["location"].toString(),
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          DataUtils.calcStringTowon(
                              datas[index]["price"].toString()),
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
                                Text(datas[index]["likes"].toString()),
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
          ),
        );
      },
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder(
        future: _loadContents(),
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData == false) {
            return const Center(child: Text('해당 지역의 데이터가 없습니다.'));
          }
          List<Map<String, String>> datas = snapshot.data;
          return _makeDataList(datas);
        }));
  }
}
