class CartModel {
  List<CartUser> dataList;

  CartModel({
    required this.dataList,
  });

  CartModel.fromJson(List<dynamic> json)
      : dataList = List<CartUser>.from(
      json.map((x) => CartUser.fromJson(x)).toList());

  List<dynamic> toJson() {
    return dataList.map((x) => x.toJson()).toList();
  }
}

class CartUser {
  Users? user;
  Users? proUser;
  String? orderDate;
  double? amount;
  double? quantity;
  String? status;
  int? orderId;

  CartUser(
      {this.user,
        this.proUser,
        this.orderDate,
        this.amount,
        this.quantity,
        this.status,
        this.orderId});

  CartUser.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
    proUser =
    json['proUser'] != null ? new Users.fromJson(json['proUser']) : null;
    orderDate = json['orderDate'];
    amount = json['amount'];
    quantity = json['quantity'];
    status = json['status'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.proUser != null) {
      data['proUser'] = this.proUser!.toJson();
    }
    data['orderDate'] = this.orderDate;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['order_id'] = this.orderId;
    return data;
  }
}

class Users {
  int? id;
  String? fName;
  String? lName;
  String? password;
  String? email;
  String? picture;
  List<Images>? images;
  String? description;
  double? rating;
  bool? pro;

  Users(
      {this.id,
        this.fName,
        this.lName,
        this.password,
        this.email,
        this.picture,
        this.images,
        this.description,
        this.rating,
        this.pro});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fName'];
    lName = json['lName'];
    password = json['password'];
    email = json['email'];
    picture = json['picture'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    description = json['description'];
    rating = json['rating'];
    pro = json['pro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['picture'] = this.picture;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['pro'] = this.pro;
    return data;
  }
}

class Images {
  int? id;
  String? filename;
  User? user;

  Images({this.id, this.filename, this.user});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filename'] = this.filename;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? fName;
  String? lName;
  String? password;
  String? email;
  String? picture;
  String? description;
  double? rating;
  bool? pro;

  User(
      {this.id,
        this.fName,
        this.lName,
        this.password,
        this.email,
        this.picture,
        this.description,
        this.rating,
        this.pro});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fName'];
    lName = json['lName'];
    password = json['password'];
    email = json['email'];
    picture = json['picture'];
    description = json['description'];
    rating = json['rating'];
    pro = json['pro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['pro'] = this.pro;
    return data;
  }
}