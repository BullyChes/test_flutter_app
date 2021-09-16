import 'package:flutter/widgets.dart';
import 'package:flutter_ebook/utils/constant.dart';

class CustomSlidingSegmentedControl extends StatefulWidget {
  const CustomSlidingSegmentedControl(
      {Key? key, this.onValueChanged, required this.children})
      : super(key: key);

  final List<String> children;
  final ValueChanged<int>? onValueChanged;

  @override
  _CustomSlidingSegmentedControlState createState() =>
      _CustomSlidingSegmentedControlState();
}

class _CustomSlidingSegmentedControlState
    extends State<CustomSlidingSegmentedControl> {
  int index = 0;

  Widget _buildItem(int currentIndex, String label) {
    return GestureDetector(
      onTap: () {
        if (index != currentIndex)
          setState(() {
            index = currentIndex;
            if (this.widget.onValueChanged != null)
              this.widget.onValueChanged!(currentIndex);
          });
      },
      child: Container(
        width: currentIndex != 2 ? 100 : 124,
        height: 24,
        alignment: Alignment.bottomLeft,
        // color: kBlackColor.withOpacity(0.3),
        child: AnimatedDefaultTextStyle(
            child: Text(
              label,
              textAlign: TextAlign.start,
            ),
            style: index == currentIndex
                ? TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)
                : TextStyle(
                    color: kWhiteColor.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
            duration: const Duration(milliseconds: 300)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildItem(0, 'Best Seller'),
          const SizedBox(width: 15),
          _buildItem(1, 'The Latest'),
          const SizedBox(width: 15),
          _buildItem(2, 'Coming Soon')
        ],
      ),
    );
  }
}
