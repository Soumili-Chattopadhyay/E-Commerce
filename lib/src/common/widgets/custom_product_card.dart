import 'package:flutter/material.dart';

class CustomProductCard extends StatefulWidget {
  VoidCallback onCardTap;
  String productImage;
  String productTitle;
  double productPrice;
  VoidCallback onLikeTap;
  bool likedProduct;

  CustomProductCard({
    required this.onCardTap,
    required this.productImage,
    required this.productTitle,
    required this.productPrice,
    required this.onLikeTap,
    required this.likedProduct,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomProductCard> createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      height: 225.0,
      width: 175.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: GestureDetector(
        onTap: widget.onCardTap,
        child: Card(
          elevation: 12.0,
          color: const Color(0xFFFFFFFF),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image(
                    width: 75.0,
                    height: 50.0,
                    image: NetworkImage(
                      widget.productImage,
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    child: Text(
                      widget.productTitle,
                      textScaleFactor: 0.9,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    child: Text(
                      '\$${widget.productPrice}',
                      textScaleFactor: 1.0,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: widget.onLikeTap,
                    child: Container(
                      height: 25.0,
                      width: 25.0,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: (widget.likedProduct)
                          ? const Icon(
                              Icons.favorite,
                              size: 20.0,
                              color: Color(0xFFFF006E),
                            )
                          : const Icon(
                              Icons.favorite_border,
                              size: 20.0,
                              color: Color(0xFFFF006E),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
