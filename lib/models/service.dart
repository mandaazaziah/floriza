class Service {
  String _title;
  String _iconPath;
  String _description;

  Service(this._title, this._iconPath, this._description);

  // Getter
  String get title => _title;
  String get iconPath => _iconPath;
  String get description => _description;

  // Bisa override nanti
  String getServiceTips() => "Layanan kami membantu mewujudkan kebutuhan Anda.";
}
