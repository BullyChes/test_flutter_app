
// import 'package:flutter/widgets.dart';

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
//   var _locationBloc = getIt<LocationBloc>();

//   int _currentImageIndex;
//   CarouselController carouselController;
//   AnimationController animationController;
//   int angle;
//   var _removeItem;

//   List<FavoriteLocationModel> _list = [];

//   final _animatedListKey = GlobalKey<AnimatedListState>();

//   @override
//   void initState() {
//     _locationBloc.fetchFavoriteLocation();

//     angle = 0;
//     animationController =
//         AnimationController(duration: Duration(minutes: 10), vsync: this);
//     animationController.forward();

//     _currentImageIndex = 1;
//     carouselController = CarouselController();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _locationBloc.dispose();
//     animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _animatedListBuilder();
//   }

//   Widget _animatedListBuilder() {
//     return StreamBuilder<List<FavoriteLocationModel>>(
//       stream: _locationBloc.getFavoriteLocation,
//       builder: (_, snapshot) {
//         if (snapshot.connectionState != ConnectionState.active)
//           return _loadingScreen();
//         if (snapshot.hasData && snapshot.data.isNotEmpty) {
//           _list = snapshot.data;
//           return Container(
//             child: ListView.builder(
//               key: _animatedListKey,
//               itemCount: _list.length,
//               itemBuilder: (context, index) {
//                 return _buildItem(_list[index], index);
//               },
//             ),
//           );
//         } else {
//           return _emptyList();
//         }
//       },
//     );
//   }

//   Widget _buildItem(FavoriteLocationModel item, int index) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: _item(item, index, context),
//     );
//   }

//   Widget _item(FavoriteLocationModel item, int index, BuildContext context) {
//     return StatefulBuilder(
//         key: ValueKey<FavoriteLocationModel>(item),
//         builder: (context, setState) {
//           return GestureDetector(
//             onTap: () async {
//               if (item.location.status.status != LocationStatus.ARCHIVE) {
//                 await Navigator.of(context)
//                     .push(MaterialPageRoute(
//                         builder: (_) => LocationInformationScreen(
//                             locationId: item.location.id,
//                             imageIndex: _currentImageIndex)))
//                     .then((_) {
//                   setState(() {});
//                 });
//               }
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipPath(
//                   clipper: ShapeBorderClipper(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16.0))),
//                   child: Stack(
//                     alignment: Alignment.topRight,
//                     children: [
//                       _imageSlider(item.location),
//                       _favoriteButton(item, index),
//                     ],
//                   ),
//                 ),
//                 _itemTitle(item.location),
//                 _itemAddress(item.location),
//                 Stack(
//                   children: [
//                     _itemPrice(item.location),
//                     _itemReview(item.location),
//                   ],
//                 ),
//                 _divider(index)
//               ],
//             ),
//           );
//         });
//   }

//   Widget _itemTitle(LocationModel item) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 8.0),
//         child: Text("${item.title}",
//             maxLines: 2,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//             overflow: TextOverflow.ellipsis),
//       ),
//     );
//   }

//   Widget _itemAddress(LocationModel item) {
//     return item.status.status != LocationStatus.ARCHIVE
//         ? Padding(
//             padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: SvgPicture.asset(
//                     "assets/images/house_icon.svg",
//                     width: 15,
//                     height: 15,
//                   ),
//                 ),
//                 item.district != null
//                     ? Flexible(
//                         child: Text(
//                           "${regionEnumValues.reverse[item.district.region.region]}, ${item.district.district}",
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           style: Theme.of(context).textTheme.subtitle1.copyWith(
//                                 color: KinodomColors.textNormalColor,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                         ),
//                       )
//                     : Text(
//                         "Район и регион не указаны",
//                         style: Theme.of(context).textTheme.subtitle1.copyWith(
//                               color: KinodomColors.textNormalColor,
//                               fontWeight: FontWeight.w400,
//                             ),
//                       ),
//               ],
//             ),
//           )
//         : _archiveLabel();
//   }

//   Widget _itemPrice(LocationModel item) {
//     return item.status.status != LocationStatus.ARCHIVE
//         ? Padding(
//             padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
//             child: Container(
//                 width: double.infinity,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         RatingBar(
//                           initialRating:
//                               (PricesType.values.indexOf(item.priceType) + 1)
//                                   .toDouble(),
//                           itemSize: 12,
//                           minRating: 1,
//                           direction: Axis.horizontal,
//                           allowHalfRating: false,
//                           ignoreGestures: true,
//                           itemCount: 4,
//                           ratingWidget: RatingWidget(
//                             full: SizedBox(
//                                 height: 11,
//                                 width: 11,
//                                 child: SvgPicture.asset(
//                                     "assets/images/rubFull.svg")),
//                             half: Container(),
//                             empty: SizedBox(
//                                 height: 11,
//                                 width: 11,
//                                 child: SvgPicture.asset(
//                                     "assets/images/rubEmpty.svg")),
//                           ),
//                           onRatingUpdate: (rating) {
//                             print(rating);
//                           },
//                         ),
//                       ],
//                     )
//                   ],
//                 )),
//           )
//         : Container();
//   }

//   Widget _itemReview(LocationModel item) {
//     return item.status.status != LocationStatus.ARCHIVE
//         ? Align(
//             alignment: Alignment.topRight,
//             child: GestureDetector(
//               onTap: () {
//                 if (item.reviews != null)
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               AllReviewsScreen(item.reviews)));
//               },
//               child: item.reviews != null
//                   ? Text(
//                       "${item.reviews} отзыва",
//                       style: Theme.of(context)
//                           .textTheme
//                           .subtitle1
//                           .copyWith(color: KinodomColors.kinodomMainTextColor),
//                     )
//                   : Text(
//                       "Нет отзывов",
//                       style: Theme.of(context)
//                           .textTheme
//                           .subtitle1
//                           .copyWith(color: KinodomColors.textFormDisabledColor),
//                     ),
//             ),
//           )
//         : Container();
//   }

//   Widget _archiveLabel() {
//     return Container(
//       margin: const EdgeInsets.only(top: 8.0),
//       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
//       decoration: BoxDecoration(
//           color: KinodomColors.archiveLabelColor,
//           borderRadius: BorderRadius.circular(5.0)),
//       child: Text("Архивная",
//           style: TextStyle(
//             color: Colors.white,
//           )),
//     );
//   }

//   Widget _emptyList() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//               child: Center(
//             child: Text(
//               "У вас пока нет ни одной избранной локации.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: KinodomColors.navBarItemColor,
//                   fontWeight: FontWeight.w400),
//             ),
//           )),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: DefaultButton(
//               buttonType: ButtonType.DEFAULT_BLUE,
//               title: "Заполнить анкету на поиск",
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) =>
//                             SearchRequestScreen()));
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _divider(int index) {
//     return _list.indexOf(_list.last) == index
//         ? Container()
//         : Divider(color: KinodomColors.dividerColor);
//   }

//   Widget _loadingScreen() {
//     return AnimatedBuilder(
//       animation: animationController,
//       builder: (BuildContext context, Widget child) {
//         angle = angle + 5;
//         return Center(
//           child: RotationTransition(
//             turns: AlwaysStoppedAnimation(angle / 360),
//             child: SvgPicture.asset(
//               "assets/images/loader.svg",
//               width: 48.0,
//               height: 48.0,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _favoriteButton(FavoriteLocationModel item, int index) {
//     return (UserProvider.user.userRole == UserRole.GUEST ||
//                 UserProvider.user.userRole == UserRole.MOVIE_MAKER) &&
//             item.location.isFavorite != null
//         ? Visibility(
//             visible: item.location.isFavorite != null,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       color: Color(0xff000000).withOpacity(0.15),
//                       borderRadius: BorderRadius.all(Radius.circular(60.0))),
//                   child: IconButton(
//                       icon: item.location.isFavorite
//                           ? Icon(
//                               Icons.favorite,
//                               color: Color(0xff00CAD7),
//                             )
//                           : Icon(
//                               Icons.favorite_border,
//                               color: Colors.white,
//                             ),
//                       onPressed: () {
//                         if (UserProvider.user.userRole == UserRole.GUEST) {
//                           showLoginRequestBottomSheet(
//                               context,
//                               "Добавить в избранное",
//                               "Избранное доступно только зарегистрированным пользователям, занимающимся подбором локаций.",
//                               null);
//                         } else {
//                           if (item.location.isFavorite) {
//                             setState(() {
//                               item.location.isFavorite = false;
//                               _removeFromFavoriteSnackBar(item, index);
//                               _removeFromItem(item, index);
//                             });
//                           } else {
//                             setState(() {
//                               item.location.isFavorite = true;
//                               _addInFavoriteSnackBar(item, index);
//                               _addAnItem(item, index);
//                             });
//                           }
//                         }
//                         setState(() {});
//                       })),
//             ),
//           )
//         : Container();
//   }

//   _addInFavoriteSnackBar(FavoriteLocationModel item, int index) {
//     Scaffold.of(context).showSnackBar(SnackBar(
//       content: Text('Добавлено в избранное'),
//       action: SnackBarAction(
//         textColor: KinodomColors.kinodomMainTextColor,
//         label: "Отменить",
//         onPressed: () {
//           if (mounted) {
//             setState(() {
//               item.location.isFavorite = false;
//               _removeFromItem(item, index);
//             });
//           }
//         },
//       ),
//     ));
//   }

//   _removeFromFavoriteSnackBar(FavoriteLocationModel item, int index) {
//     Scaffold.of(context).showSnackBar(SnackBar(
//       content: Text('Удалено из избранного'),
//       action: SnackBarAction(
//         textColor: KinodomColors.kinodomMainTextColor,
//         label: "Отменить",
//         onPressed: () {
//           if (mounted) {
//             setState(() {
//               item.location.isFavorite = true;
//               _addAnItem(item, index);
//             });
//           }
//         },
//       ),
//     ));
//   }

//   void _addAnItem(FavoriteLocationModel item, int index) {
//     int _index = _list.isEmpty ? 0 : index;
//     _list.insert(_index, item);
//     //FIXME: почему-то insertItem() работает некорректно, проблема может быть в асинхроннои получении данных
//     // _animatedListKey.currentState.insertItem(_index);
//     _removeItem = null;
//     _locationBloc.addFavoriteLocation(item.location.lId.toString());
//     //
//     // if (_list.asMap().containsValue(item))
//     //   return;
//     // else
//     //   _locationBloc.addFavoriteLocation(item.location.id);
//   }

//   void _removeFromItem(FavoriteLocationModel item, int index) async {
//     _removeItem = _list.removeAt(index);
//     // _animatedListKey.currentState.removeItem(index, (context, animation) {
//     //   return SizeTransition(
//     //     sizeFactor:
//     //         CurvedAnimation(parent: animation, curve: Interval(0.0, 0.5)),
//     //     axisAlignment: 0.0,
//     //     child: _buildItem(_removeItem, index),
//     //   );
//     // });
//     _locationBloc.removeFavoriteLocation(item.location.lId);
//     //
//     // Future.delayed(const Duration(milliseconds: 4001), () {
//     //   if (_list.asMap().containsValue(_removeItem))
//     //     return;
//     //   else
//     //     _locationBloc.removeFavoriteLocation(item.location.id);
//     // });
//   }

//   Widget _imageSlider(LocationModel item) {
//     var indexImage = 1;
//     var images = item.images;
//     var key = GlobalKey();
//     return StatefulBuilder(
//         key: key,
//         builder: (context, setState) {
//           return Container(
//               height: 180.0,
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       alignment: Alignment.bottomLeft,
//                       children: [
//                         CarouselSlider.builder(
//                             options: CarouselOptions(
//                                 enableInfiniteScroll: images.length > 1,
//                                 height: 180,
//                                 viewportFraction: 1,
//                                 onPageChanged: (index, reason) {
//                                   setState(() {
//                                     _currentImageIndex = index + 1;
//                                     indexImage = index + 1;
//                                   });
//                                 }),
//                             // key: key,
//                             itemCount: images.length,
//                             carouselController: carouselController,
//                             itemBuilder: (context, index) {
//                               return GestureDetector(
//                                 child: Container(
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(),
//                                   child: CachedNetworkImage(
//                                     fit: BoxFit.cover,
//                                     imageUrl: images.toList()[index].url,
//                                     placeholder: (context, url) => Container(
//                                       color: Colors.grey[200],
//                                       child: Center(child: Icon(Icons.image)),
//                                     ),
//                                     errorWidget: (context, url, error) =>
//                                         Icon(Icons.error),
//                                   ),
//                                 ),
//                               );
//                             }),
//                         Visibility(
//                           visible: images.length > 1,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Container(
//                               width: 46,
//                               height: 26,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: Color(0xff000000).withOpacity(0.4),
//                                   borderRadius: BorderRadius.circular(16.0)),
//                               child: Text(
//                                 "$indexImage / ${images.length}",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .subtitle2!
//                                     .copyWith(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ));
//         });
//   }
// }
