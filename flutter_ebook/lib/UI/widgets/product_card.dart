import 'package:flutter/widgets.dart';
import 'package:flutter_ebook/UI/widgets/custom_button.dart';
import 'package:flutter_ebook/utils/constant.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {Key? key,
      required this.id,
      this.urlImage,
      required this.title,
      required this.brand,
      required this.price,
      this.newPrice,
      required this.isFavorite})
      : super(key: key);

  final String id;
  final String? urlImage;
  final String title;
  final String brand;
  final String price;
  final String? newPrice;
  final bool isFavorite;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double _imageHeight = 100;
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 2 - 21,
      height: 232,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              AnimatedContainer(
                duration: this._value != 0
                    ? const Duration(milliseconds: 400)
                    : const Duration(seconds: 1),
                // width: 100,
                height: this._value == 0 ? this._imageHeight : 60,
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  image: this.widget.urlImage != null
                      ? DecorationImage(
                          image: NetworkImage(this.widget.urlImage!),
                          fit: BoxFit.fitHeight)
                      : null,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${this.widget.title}\n',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w500, height: 1.5),
              ),
              SizedBox(height: 3),
              GestureDetector(
                child: Text(
                  this.widget.brand,
                  style: TextStyle(
                    color: kPrimaryDarkColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // поиск по бренду
                },
              ),
              SizedBox(height: 8),
              this.widget.newPrice != null
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        '${this.widget.price} ₽',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                            color: kGrayTextColor),
                      ),
                    )
                  : const SizedBox(height: 15),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: this.widget.newPrice != null
                        ? this.widget.newPrice!.split('.').first
                        : this.widget.price.split('.').first,
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: kTextColor)),
                TextSpan(
                    text: this.widget.newPrice != null
                        ? ',${this.widget.newPrice!.split('.').last} ₽'
                        : ',${this.widget.price.split('.').last} ₽',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: kTextColor)),
              ]))
            ],
          ),
          _addItemButton(),
        ],
      ),
    );
  }

  Widget _addItemButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CustomButton(
        type: ButtonType.Animated,
        callback: (value) {
          setState(() {
            this._value = value;
          });
          return value;
        },
      ),
    );
  }
}
