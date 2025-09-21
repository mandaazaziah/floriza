import 'flower.dart';

class FreshFlower extends Flower {
  FreshFlower(String name, double price, String description, String imageUrl)
      : super(name, price, description, imageUrl);

  @override
  String getCareTips() => "Ganti air vas setiap hari agar bunga tetap segar.";
}

class DriedFlower extends Flower {
  DriedFlower(String name, double price, String description, String imageUrl)
      : super(name, price, description, imageUrl);

  @override
  String getCareTips() => "Simpan di tempat kering dan hindari sinar matahari langsung.";
}

class Plant extends Flower {
  Plant(String name, double price, String description, String imageUrl)
      : super(name, price, description, imageUrl);

  @override
  String getCareTips() => "Siram secukupnya dan beri cahaya matahari tidak langsung.";
}
