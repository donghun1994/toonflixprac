import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot/components/manor_temperature_widget.dart';
import 'package:carrot/repository/contents_respository.dart';
import 'package:carrot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailContentView extends StatefulWidget {
  final Map<String, dynamic>? data;
  const DetailContentView({super.key, required this.data});

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView>
    with SingleTickerProviderStateMixin {
  late Size size;
  late List<String> imgList;
  late int _current;
  double scrollpositionToAlpha = 0;
  final CarouselController _imgcontroller = CarouselController();
  final ScrollController _controller = ScrollController();
  late AnimationController _animationController;
  late Animation _colorTween;
  late bool isMyFavoriteContent;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ContentsRepository contentsRepository;

  @override
  void initState() {
    super.initState();
    isMyFavoriteContent = false;
    contentsRepository = ContentsRepository();
    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _controller.addListener(() {
      setState(() {
        if (scrollpositionToAlpha > 255) {
          scrollpositionToAlpha = 255;
        } else {
          scrollpositionToAlpha = _controller.offset;
        }
        _animationController.value = scrollpositionToAlpha / 255;
      });
    });

    _loadMyFavoriteContentState();
  }

  _loadMyFavoriteContentState() async {
    bool ck = await contentsRepository
        .isMyFavitecontents(widget.data!['cid'].toString());
    setState(() {
      isMyFavoriteContent = ck;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    _current = 0;
    imgList = [
      widget.data!['image'].toString(),
      widget.data!['image'].toString(),
      widget.data!['image'].toString(),
      widget.data!['image'].toString(),
      widget.data!['image'].toString(),
    ];
  }

  Widget _makeIcon(IconData icon) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) => Icon(
        icon,
        color: _colorTween.value,
      ),
    );
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.white.withAlpha(scrollpositionToAlpha.toInt()),
      leading: IconButton(
        icon: _makeIcon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: _makeIcon(Icons.share),
        ),
        IconButton(
          onPressed: () {},
          icon: _makeIcon(Icons.more_vert),
        ),
      ],
    );
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.asset("assets/images/user.png").image,
          ),
          const SizedBox(
            width: 10,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '테스터',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '제주시 도담동',
              )
            ],
          ),
          Expanded(child: ManorTemperature(manorTemp: 37.5))
        ],
      ),
    );
  }

  Widget _makeSliderImage() {
    return Stack(
      children: [
        Hero(
          tag: widget.data!["cid"].toString(),
          child: CarouselSlider(
            items: imgList.map(
              (url) {
                return Image.asset(
                  widget.data!['image'].toString(),
                  fit: BoxFit.fill,
                  width: size.width,
                );
              },
            ).toList(),
            options: CarouselOptions(
                height: size.width,
                initialPage: 0,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _imgcontroller.animateToPage(entry.key),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.red
                              : Colors.white)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _line() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.data!['title'].toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            '생활용품 - 22시간 전',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            '이 상품을 팔기 위한 안내 텍스트\n트 불랃불랄부랍루ㅏㅂ루ㅏ루ㅏㄹㅁㄴㅇ\n러마ㅣㄴ댜ㅐ먼ㄷ기',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            '채팅 3 - 관심 17 - 조회 296',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _otherCellContents() {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '판매자님의 판매상품',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '모두보기',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          _makeSliderImage(),
          _sellerSimpleInfo(),
          _line(),
          _contentDetail(),
          _line(),
          _otherCellContents(),
        ])),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildListDelegate(List.generate(20, (index) {
              return Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.grey,
                          height: 120,
                        ),
                      ),
                      const Text(
                        '상품정보',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const Text(
                        '금액',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ]),
              );
            })),
          ),
        ),
      ],
    );
  }

  Widget _bottombarWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width,
      height: 60,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        GestureDetector(
          onTap: () async {
            if (isMyFavoriteContent) {
              await contentsRepository
                  .deleteMyFavoritecontent(widget.data!['cid'].toString());
            } else {
              await contentsRepository.addMyFaoviteContent(widget.data!);
            }
            setState(() {
              isMyFavoriteContent = !isMyFavoriteContent;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 1000),
              content: Text(
                isMyFavoriteContent ? "관심목록에 추가 됐습니다." : "관심목록에서 제거됐습니다.",
              ),
            ));
          },
          child: SvgPicture.asset(
            isMyFavoriteContent
                ? "assets/svg/heart_on.svg"
                : "assets/svg/heart_off.svg",
            width: 25,
            height: 25,
            color: const Color(0xfff08f4f),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 10),
          width: 1,
          height: 40,
          color: Colors.grey.withOpacity(0.3),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DataUtils.calcStringTowon(widget.data!['price'].toString()),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '가격제안불가',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            )
          ],
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xfff08f4f),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: const Text('채팅으로 거래하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottombarWidget(),
    );
  }
}
