import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ebook/UI/widgets/custom_sliding_segmented_control.dart';
import 'package:flutter_ebook/utils/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(label: 'Good Morning', fontSize: 14),
                    // const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _title(label: 'Ivan Kolinsky'),
                        Container(
                          padding: const EdgeInsets.fromLTRB(4, 4, 16, 4),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: kPrimaryDarkColor,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Icon(
                                  CupertinoIcons.sun_haze_fill,
                                  size: 18,
                                  color: kWhiteColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: '240',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' point',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500))
                              ])),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: kWhiteColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buttonWithIcon(
                        label: 'Claim',
                        assetName: 'assets/icons/claim_icon.svg'),
                    _divider(),
                    _buttonWithIcon(
                        label: 'Get Point',
                        assetName: 'assets/icons/point_icon.svg'),
                    _divider(),
                    _buttonWithIcon(
                        label: 'My Card',
                        assetName: 'assets/icons/card_icon.svg'),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // My book
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_title(label: 'My Book'), Text('see more')],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 16),
                    _myBookItem(),
                    const SizedBox(width: 15),
                    _myBookItem(),
                    const SizedBox(width: 15),
                    _myBookItem(),
                    const SizedBox(width: 15),
                    _myBookItem(),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomSlidingSegmentedControl(
                children: [],
                onValueChanged: (int value) {
                  print(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title({required String label, double fontSize = 20.0}) {
    return Text(
      label,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
    );
  }

  Widget _buttonWithIcon({required String label, required String assetName}) {
    return CupertinoButton(
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            SvgPicture.asset(assetName),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        onPressed: () {});
  }

  Widget _divider() {
    return Container(
      height: 24,
      width: 1,
      color: kWhiteColor.withOpacity(0.3),
    );
  }

  final String _urlImage =
      'https://ae01.alicdn.com/kf/HTB1AhSuXjQnBKNjSZSgq6xHGXXaM/-.jpg_q50.jpg';

  Widget _myBookItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 220,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: kWhiteColor.withOpacity(0.2)),
              image: DecorationImage(
                image: NetworkImage(_urlImage),
                fit: BoxFit.cover,
              )),
          // child: Image.network(_urlImage),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            _icon(CupertinoIcons.time),
            _text('3d 5h'),
            const SizedBox(width: 10),
            _icon(CupertinoIcons.square_on_square),
            _text('23%')
          ],
        )
      ],
    );
  }

  Widget _icon(IconData iconData) {
    return Icon(
      iconData,
      color: kWhiteColor.withOpacity(0.3),
      size: 16,
    );
  }

  Widget _text(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Text(
        text,
        style: TextStyle(
          color: kWhiteColor.withOpacity(0.4),
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }
}
