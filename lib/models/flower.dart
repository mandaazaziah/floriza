class Flower {
  String _name;
  double _price;
  String _description;
  String _imageUrl;

  Flower(this._name, this._price, this._description, this._imageUrl);

  String get name => _name;
  double get price => _price;
  String get description => _description;
  String get imageUrl => _imageUrl;

  get image => null;

  String getCareTips() => "Rawat bunga agar tetap segar.";
}
