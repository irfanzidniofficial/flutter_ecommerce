import 'dart:convert';

class ListOrderResponseModel {
  List<Order>? data;
  Meta? meta;

  ListOrderResponseModel({
    this.data,
    this.meta,
  });

  factory ListOrderResponseModel.fromJson(String str) =>
      ListOrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListOrderResponseModel.fromMap(Map<String, dynamic> json) =>
      ListOrderResponseModel(
        data: json["data"] == null
            ? []
            : List<Order>.from(json["data"]!.map((x) => Order.fromMap(x))),
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "meta": meta?.toMap(),
      };
}

class Order {
  int? id;
  Attributes? attributes;

  Order({
    this.id,
    this.attributes,
  });

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        attributes: json["attributes"] == null
            ? null
            : Attributes.fromMap(json["attributes"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": attributes?.toMap(),
      };
}

class Attributes {
  List<Item>? items;
  int? totalPrice;
  String? deliveryAddress;
  String? courierName;
  int? shippingCost;
  String? statusOrder;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishedAt;
  int? userId;

  Attributes({
    this.items,
    this.totalPrice,
    this.deliveryAddress,
    this.courierName,
    this.shippingCost,
    this.statusOrder,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.userId,
  });

  factory Attributes.fromJson(String str) =>
      Attributes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attributes.fromMap(Map<String, dynamic> json) => Attributes(
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
        totalPrice: json["totalPrice"],
        deliveryAddress: json["deliveryAddress"],
        courierName: json["courierName"],
        shippingCost: json["shippingCost"],
        statusOrder: json["statusOrder"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toMap())),
        "totalPrice": totalPrice,
        "deliveryAddress": deliveryAddress,
        "courierName": courierName,
        "shippingCost": shippingCost,
        "statusOrder": statusOrder,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
        "userId": userId,
      };
}

class Item {
  int? id;
  String? productName;
  int? price;
  int? qty;

  Item({
    this.id,
    this.productName,
    this.price,
    this.qty,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        productName: json["productName"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productName": productName,
        "price": price,
        "qty": qty,
      };
}

class Meta {
  Pagination? pagination;

  Meta({
    this.pagination,
  });

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromMap(json["pagination"]),
      );

  Map<String, dynamic> toMap() => {
        "pagination": pagination?.toMap(),
      };
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination({
    this.page,
    this.pageSize,
    this.pageCount,
    this.total,
  });

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
      };
}
