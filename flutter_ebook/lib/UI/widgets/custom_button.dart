import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_ebook/utils/constant.dart';

enum ButtonType { Default, Animated }

class CustomButton extends StatefulWidget {
  const CustomButton(
      {Key? key,
      required this.type,
      this.onPressed,
      this.callback,
      this.label = 'Label'})
      : super(key: key);

  final ButtonType type;
  final void Function()? onPressed;

  /// Только для [ButtonType.Default]
  /// наименование кнопки
  final String label;

  /// Только для [ButtonType.Animated]
  /// возвращает выбранное число
  final IntValue? callback;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  // Дальше идут значения только для [ButtonType.Animated]
  double _width = 34.0;
  int _value = 0;
  bool _visibleElement = false;
  LinearGradient _linearGradient = kBlackGradient;
  late double _size = this._width;

  @override
  Widget build(BuildContext context) {
    switch (this.widget.type) {
      case ButtonType.Default:
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kPrimaryColor,
          ),
          child: CupertinoButton(
              child: Text(
                this.widget.label,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: kWhiteColor),
              ),
              onPressed: this.widget.onPressed),
        );
      case ButtonType.Animated:
        return AnimatedContainer(
          duration: Duration(milliseconds: 800),
          width: this._width,
          height: this._size,
          curve: Curves.fastOutSlowIn,
          onEnd: () {
            if (this._value == 0)
              setState(() {
                this._visibleElement = false;
              });
            if (this._value >= 1)
              setState(() {
                this._visibleElement = true;
              });
          },
          decoration: BoxDecoration(
            gradient: this._linearGradient,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            direction: Axis.horizontal,
            children: [
              Visibility(
                visible: this._visibleElement && this._value >= 1,
                child: SizedBox(
                  width: this._size,
                  height: this._size,
                  child: CupertinoButton(
                      child: Icon(
                        Icons.remove,
                        color: kWhiteColor,
                      ),
                      padding: const EdgeInsets.all(5),
                      onPressed: () {
                        setState(() {
                          if (this._value == 1) {
                            this._width = 34.0;
                            this._linearGradient = kBlackGradient;
                          }
                          this._value--;
                          if (this.widget.callback != null)
                            this.widget.callback!(this._value);
                        });
                      }),
                ),
              ),
              Visibility(
                visible: this._visibleElement && this._value >= 1,
                child: SizedBox(
                  width: this._size,
                  height: this._size,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "${this._value}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: kWhiteColor)),
                          TextSpan(
                              text: " шт.",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: kWhiteColor)),
                        ])),
                  ),
                ),
              ),
              SizedBox(
                width: this._size,
                height: this._size,
                child: CupertinoButton(
                    child: Icon(
                      Icons.add,
                      color: kWhiteColor,
                    ),
                    padding: const EdgeInsets.all(5),
                    onPressed: () {
                      setState(() {
                        if (this._value == 0) {
                          this._width = 140;
                          this._linearGradient = kPrimaryGradient;
                        }
                        this._value++;
                        if (this.widget.callback != null)
                          this.widget.callback!(this._value);
                      });
                    }),
              ),
            ],
          ),
        );
    }
  }
}
