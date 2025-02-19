import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/features/home/data/home_carousal_item_model.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:ecommerce_app/features/home/ui/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(
                              'https://pbs.twimg.com/profile_images/1493704582505144323/Stvh3FSK_400x400.jpg'),
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tarek Alabd',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              'Let\'s go shopping!',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                FlutterCarousel.builder(
                  itemCount: dummyHomeCarouselItems.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16.0),
                      child: CachedNetworkImage(
                        imageUrl: dummyHomeCarouselItems[itemIndex].imgUrl,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                  options: FlutterCarouselOptions(
                    height: 200,
                    showIndicator: true,
                    autoPlay: true,
                    slideIndicator: CircularWaveSlideIndicator(),
                  ),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'New Arrivals',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      'See All',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                GridView.builder(
                  itemCount: dummyProducts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItem(
                      productItem: dummyProducts[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
