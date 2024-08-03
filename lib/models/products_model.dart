class ProductsModel{
  String? id;
  String? name;
  String? image;

  ProductsModel.fromJson(String id, Map<String,dynamic> json){
    this.id = id;
    name = json['name'];
    image = json['image'];
  }
}