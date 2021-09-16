import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/widgets.dart';
import 'package:flutter_ebook/utils/constant.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({Key? key, this.isCheck = false, this.callback})
      : super(key: key);

  final bool isCheck;
  final BoolValue? callback;

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  final double _size = 26;
  late bool _isCheck = this.widget.isCheck;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          this._isCheck = !this._isCheck;
        });
        if (this.widget.callback != null) this.widget.callback!(this._isCheck);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
        width: this._size,
        height: this._size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: kWhiteColor,
            gradient: this._isCheck ? kPrimaryGradient : null),
        child: this._isCheck
            ? Center(
                child: Icon(
                  CupertinoIcons.checkmark_alt,
                  color: kWhiteColor,
                ),
              )
            : null,
      ),
    );
  }
}
