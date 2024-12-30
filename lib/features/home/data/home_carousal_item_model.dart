class HomeCarouselItemModel {
  final String id;
  final String imgUrl;

  HomeCarouselItemModel({
    required this.id,
    required this.imgUrl,
  });
}

List<HomeCarouselItemModel> dummyHomeCarouselItems = [
  HomeCarouselItemModel(
    id: '1',
    imgUrl:
        'https://marketplace.canva.com/EAFMdLQAxDU/1/0/1600w/canva-white-and-gray-modern-real-estate-modern-home-banner-NpQukS8X1oo.jpg',
  ),
  HomeCarouselItemModel(
    id: '2',
    imgUrl:
        'https://edit.org/photos/img/blog/mbp-template-banner-online-store-free.jpg-840.jpg',
  ),
  HomeCarouselItemModel(
    id: '3',
    imgUrl:
        'https://casalsonline.es/wp-content/uploads/2018/12/CASALS-ONLINE-18-DICIEMBRE.png',
  ),
  HomeCarouselItemModel(
    id: '4',
    imgUrl:
        'https://e0.pxfuel.com/wallpapers/606/84/desktop-wallpaper-ecommerce-website-design-company-noida-e-commerce-banner-design-e-commerce.jpg',
  ),
];