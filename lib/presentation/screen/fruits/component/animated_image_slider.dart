import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart';
import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/image_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class AnimatedImageSlider extends StatefulWidget {
  final List<Images> images;
  final bool isBookMar;
  final VoidCallback onPress;
  const AnimatedImageSlider({
    super.key,
    required this.images,
    required this.onPress,
    required this.isBookMar,
  });

  @override
  State<AnimatedImageSlider> createState() => _AnimatedImageSliderState();
}

class _AnimatedImageSliderState extends State<AnimatedImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLandscape = constraints.maxWidth > constraints.maxHeight;
        return SizedBox(
          height: height,
          width: isLandscape ? height / 2 : double.infinity,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  final imageUrl = widget.images[index].url;

                  if (imageUrl == null || imageUrl.isEmpty) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageConstant.noproduct),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }

                  return CachedNetworkImage(
                    cacheManager: GetIt.I<CacheManager>(),
                    imageUrl: imageUrl,
                    fit: BoxFit.fill,
                    //fit: BoxFit.fit,
                    width: double.infinity,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(color: Colors.white),
                    ),
                    cacheKey: imageUrl.split("?").first,
                    useOldImageOnUrlChange: true,
                    errorWidget: (context, url, error) =>
                        Image.asset(ImageConstant.noproduct, fit: BoxFit.cover),
                  );
                },
              ),
              Positioned(
                top: 20.fSize,
                right: 20.fSize,
                child: IconButton(
                  onPressed: widget.onPress,
                  icon: Icon(
                    widget.isBookMar ? Icons.bookmark : LucideIcons.bookmark,
                    size: 30.fSize,
                    color: widget.isBookMar
                        ? ColorConstant.primaryMainColor
                        : ColorConstant.blcakColor,
                  ),
                ),
              ),

              Positioned(
                bottom: 20.fSize,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.images.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8.fSize,
                      width: _currentPage == index ? 24.fSize : 8.fSize,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.green
                            : Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
