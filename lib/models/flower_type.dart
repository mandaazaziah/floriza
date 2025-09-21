import 'flower.dart';

class FreshFlower extends Flower {
  FreshFlower(String name, double price, String description, String imageUrl)
      : super(name, price, description, imageUrl);

  @override
  String getCareTips() => "Simpan di vas dengan air bersih, ganti setiap 2 hari.";
}

class DriedFlower extends Flower {
  DriedFlower(String name, double price, String description, String imageUrl)
      : super(name, price, description, imageUrl);

  @override
  String getCareTips() => "Letakkan di ruangan kering agar tidak berjamur.";
}

class Plant extends Flower {
  Plant(String name, double price, String description, String imageUrl)
      : super(name, price, description, imageUrl);

  @override
  String getCareTips() => "Butuh cahaya cukup dan disiram 1–2x seminggu.";
}
