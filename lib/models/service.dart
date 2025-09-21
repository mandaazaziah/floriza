class Service {
  String _name;
  double _price;
  String _description;

  Service(this._name, this._price, this._description);

  String get name => _name;
  double get price => _price;
  String get description => _description;

  String getServiceInfo() => "Layanan umum Floriza.";
}
