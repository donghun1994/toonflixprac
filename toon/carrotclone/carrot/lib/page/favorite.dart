import 'package:carrot/page/detail.dart';
import 'package:carrot/repository/contents_respository.dart';
import 'package:carrot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyFavoriteContents extends StatefulWidget {
  const MyFavoriteContents({super.key});

  @override
  State<MyFavoriteContents> createState() => _MyFavoriteContentsState();
}

class _MyFavoriteContentsState extends State<MyFavoriteContents> {
  late ContentsRepository contentsRepository = ContentsRepository();

  @override
  void initState() {
    super.initState();
    contentsRepository = ContentsRepository();
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
        title: const Text(
      '관심목록',
      style: TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget _bodyWidget() {
    return FutureBuilder(
        future: _loadMyFavoriteContentList(),
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData == false) {
            return const Center(child: Text('해당 지역의 데이터가 없습니다.'));
          }
          List<dynamic> datas = snapshot.data;
          return _makeDataList(datas);
        }));
  }

  Future<List<dynamic>> _loadMyFavoriteContentList() async {
    return await contentsRepository.loadFavoriteContents();
  }

  Widget _makeDataList(List<dynamic> datas) {
    return ListView.separated(
      itemCount: datas.length,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
