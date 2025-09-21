import 'service.dart';

class CustomBouquet extends Service {
  CustomBouquet(String title, String iconPath, String description)
      : super(title, iconPath, description);

  @override
  String getServiceTips() => "Pesan buket sesuai keinginanmu.";
}

class DecorationService extends Service {
  DecorationService(String title, String iconPath, String description)
      : super(title, iconPath, description);

  @override
  String getServiceTips() => "Kami membantu dekorasi event agar lebih berkesan.";
}
