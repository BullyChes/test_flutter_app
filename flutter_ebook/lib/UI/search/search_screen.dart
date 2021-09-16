import 'package:flutter/cupertino.dart';
import 'package:flutter_ebook/UI/widgets/custom_button.dart';
import 'package:flutter_ebook/UI/widgets/custom_checkbox.dart';
import 'package:flutter_ebook/UI/widgets/product_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoPageScaffold(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomCheckbox(),
                const SizedBox(height: 20),
                CustomButton(
                  type: ButtonType.Default,
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                CustomButton(
                  type: ButtonType.Animated,
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProductCard(
                        id: '123124',
                        urlImage:
                            'https://i.kym-cdn.com/photos/images/original/001/487/698/aa6.png',
                        title: 'Item Name',
                        brand: 'brand',
                        price: '2999.99',
                        newPrice: '1999.99',
                        isFavorite: false),
                    ProductCard(
                        id: '123124',
                        urlImage:
                            'https://i.pinimg.com/originals/41/2c/33/412c3309b7fe3ae64d960e36aa23d8d0.jpg',
                        title: 'Item Name',
                        brand: 'brand',
                        price: '2999.99',
                        isFavorite: false),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
