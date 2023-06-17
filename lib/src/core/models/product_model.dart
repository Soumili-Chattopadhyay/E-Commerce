class ProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  // Rating? productRating;
  Map<String, dynamic>? rating;
  double? rate;
  int? count;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.rate,
    this.count,
  });

  factory ProductModel.fromJson(Map json) {
    final price = json['price'];
    final rate = json['rating']['rate'];
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (price is int) ? price.toDouble() : price,
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'],
      rate: rate is int? rate.toDouble():rate,
      count: json['rating']['count'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    data['rating'] = rating;
    data['rating']['rate'] = rate;
    data['rating']['count'] = count;

    return data;
  }
}

// class Rating {
//   double rate;
//   int count;

//   Rating({
//     required this.rate,
//     required this.count,
//   });

//   factory Rating.fromJson(Map json) {
//     return Rating(
//       rate: json['rate'],
//       count: json['count'],
//     );
//   }

//   Map<String, dynamic> toJson(){
//     Map<String, dynamic> data = <String, dynamic>{};

//     data['rate'] = rate;
//     data['count'] = count;

//     return data;
//   }
// }
