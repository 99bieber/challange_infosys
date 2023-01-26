import 'package:challange_infosys/models/image_model.dart';

class ProductModel {
  int? id;
  String? title;
  String? deskription;
  double? price;
  String? category;
  String? images;

  ProductModel({
    this.id,
    this.title,
    this.deskription,
    this.price,
    this.category,
    this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = double.parse(json['price'].toString());
    images = json['thumbnail'].toString();
    deskription = json['description'];
    category = json['category'];

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnail': images,
      'description': deskription,
      'category': category,
      
    };
  }
}

