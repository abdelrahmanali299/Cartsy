import 'package:fake_store/constant.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/views/widgets/product_colors_section.dart';
import 'package:fake_store/features/home/presentation/views/widgets/read_product_desc.dart';
import 'package:fake_store/features/home/presentation/views/widgets/select_size_section.dart';
import 'package:fake_store/features/on_boarding/presentation/views/widgets/dot.dart';
import 'package:flutter/material.dart';

class ShowProduct extends StatefulWidget {
  const ShowProduct({
    super.key,
    required this.productModel,
    required this.controller,
    this.index,
  });
  final ProductModel productModel;
  final ValueChanged<PageController> controller;
  final int? index;
  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  late PageController _pageController;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    widget.controller(_pageController);

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.productModel.id}_${widget.index}');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[300],
                      ),
                      child: index == 0
                          ? Hero(
                              tag: '${widget.productModel.id}_${widget.index}',
                              child: Image.network(widget.productModel.image),
                            )
                          : ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                productColors[index],
                                BlendMode.modulate,
                              ),
                              child: Image.network(widget.productModel.image),
                            ),
                    );
                  },
                  itemCount: productColors.length,
                ),

                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Dot(isSelected: index == currentPage),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  ProductColorsSection(
                    productModel: widget.productModel,
                    controller: _pageController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          widget.productModel.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Text(
                        '${widget.productModel.price} \$',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SelectSizeSection(),
                  ReadProductDesc(desc: widget.productModel.description),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
