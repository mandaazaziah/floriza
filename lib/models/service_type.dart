import 'service.dart';

class CustomBouquet extends Service {
  CustomBouquet(String name, double price, String description)
      : super(name, price, description);

  @override
  String getServiceInfo() => "Rancang buket sesuai permintaan pelanggan.";
}

class Decoration extends Service {
  Decoration(String name, double price, String description)
      : super(name, price, description);

  @override
  String getServiceInfo() => "Dekorasi bunga untuk event & pernikahan.";
}

class Delivery extends Service {
  Delivery(String name, double price, String description)
      : super(name, price, description);

  @override
  String getServiceInfo() => "Pengiriman bunga cepat & aman.";
}
