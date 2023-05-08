
import 'dart:convert';

class MyOrderModel {
  MyOrderModel({
    required this.id,
    required this.orderNumber,
    required this.quantity,
    required this.discount,
    required this.couponDiscount,
    required this.couponId,
    required this.totalPrice,
    required this.paymentFee,
    required this.vat,
    required this.shippingCost,
    required this.grandTotal,
    required this.discountPercentage,
    required this.userId,
    required this.orderDate,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.status,
    required this.userName,
    required this.orderDetails,
  });

  final int id;
  final String orderNumber;
  final int quantity;
  final int discount;
  final int couponDiscount;
  final int couponId;
  final int totalPrice;
  final int paymentFee;
  final int vat;
  final int shippingCost;
  final int grandTotal;
  final int discountPercentage;
  final int userId;
  final String orderDate;
  final String paymentMethod;
  final bool paymentStatus;
  final String createdAt;
  final String updatedAt;
  final int type;
  final int status;
  final String userName;
  final List<OrderDetail> orderDetails;

  MyOrderModel copyWith({
    int? id,
    String? orderNumber,
    int? quantity,
    int? discount,
    int? couponDiscount,
    int? couponId,
    int? totalPrice,
    int? paymentFee,
    int? vat,
    int? shippingCost,
    int? grandTotal,
    int? discountPercentage,
    int? userId,
    String? orderDate,
    String? paymentMethod,
    bool? paymentStatus,
    String? createdAt,
    String? updatedAt,
    int? type,
    int? status,
    String? userName,
    List<OrderDetail>? orderDetails,
  }) =>
      MyOrderModel(
        id: id ?? this.id,
        orderNumber: orderNumber ?? this.orderNumber,
        quantity: quantity ?? this.quantity,
        discount: discount ?? this.discount,
        couponDiscount: couponDiscount ?? this.couponDiscount,
        couponId: couponId ?? this.couponId,
        totalPrice: totalPrice ?? this.totalPrice,
        paymentFee: paymentFee ?? this.paymentFee,
        vat: vat ?? this.vat,
        shippingCost: shippingCost ?? this.shippingCost,
        grandTotal: grandTotal ?? this.grandTotal,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        userId: userId ?? this.userId,
        orderDate: orderDate ?? this.orderDate,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        type: type ?? this.type,
        status: status ?? this.status,
        userName: userName ?? this.userName,
        orderDetails: orderDetails ?? this.orderDetails,
      );

  factory MyOrderModel.fromRawJson(String str) => MyOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
    id: json["id"] ?? 0,
    orderNumber: json["order_number"]??'',
    quantity: json["quantity"] ?? 0,
    discount: json["discount"] ?? 0,
    couponDiscount: json["coupon_discount"] ?? 0,
    couponId: json["coupon_id"] ?? 0,
    totalPrice: json["total_price"] ?? 0,
    paymentFee: json["payment_fee"] ?? 0,
    vat: json["vat"] ?? 0,
    shippingCost: json["shipping_cost"] ?? 0,
    grandTotal: json["grand_total"] ?? 0,
    discountPercentage: json["discount_percentage"] ?? 0,
    userId: json["user_id"] ?? 0,
    orderDate: json["order_date"] ?? '',
    paymentMethod: json["payment_method"] ?? 0,
    paymentStatus: json["payment_status"] ?? false,
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    type: json["type"] ?? 0,
    status: json["status"] ?? 0,
    userName: json["user_name"] ?? '',
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"].map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_number": orderNumber,
    "quantity": quantity,
    "discount": discount,
    "coupon_discount": couponDiscount,
    "coupon_id": couponId,
    "total_price": totalPrice,
    "payment_fee": paymentFee,
    "vat": vat,
    "shipping_cost": shippingCost,
    "grand_total": grandTotal,
    "discount_percentage": discountPercentage,
    "user_id": userId,
    "order_date": orderDate,
    "payment_method": paymentMethod,
    "payment_status": paymentStatus,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "type": type,
    "status": status,
    "user_name": userName,
    "order_details": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
  };
}

class OrderDetail {
  OrderDetail({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.freeCredit,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.product,
  });

  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final int unitPrice;
  final int freeCredit;
  final String createdAt;
  final int createdBy;
  final String updatedAt;
  final Product product;

  OrderDetail copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? quantity,
    int? unitPrice,
    int? freeCredit,
    String? createdAt,
    int? createdBy,
    String? updatedAt,
    Product? product,
  }) =>
      OrderDetail(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        freeCredit: freeCredit ?? this.freeCredit,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        product: product ?? this.product,
      );

  factory OrderDetail.fromRawJson(String str) => OrderDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"],
    freeCredit: json["free_credit"],
    createdAt: json["created_at"],
    createdBy: json["created_by"],
    updatedAt: json["updated_at"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "quantity": quantity,
    "unit_price": unitPrice,
    "free_credit": freeCredit,
    "created_at": createdAt,
    "created_by": createdBy,
    "updated_at": updatedAt,
    "product": product.toJson(),
  };
}

class Product {
  Product({
    required this.id,
    required this.productName,
    required this.productSlug,
    required this.thumbnail,
    required this.details,
    required this.unitPrice,
    required this.unitPriceRegular,
    required this.productType,
    required this.vat,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.shippingCost,
    required this.createdBy,
    required this.updatedBy,
  });

  final int id;
  final String productName;
  final String productSlug;
  final String thumbnail;
  final String details;
  final int unitPrice;
  final int unitPriceRegular;
  final int productType;
  final int vat;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int shippingCost;
  final int createdBy;
  final int updatedBy;

  Product copyWith({
    int? id,
    String? productName,
    String? productSlug,
    String? thumbnail,
    String? details,
    int? unitPrice,
    int? unitPriceRegular,
    int? productType,
    int? vat,
    int? status,
    String? createdAt,
    String? updatedAt,
    int? shippingCost,
    int? createdBy,
    int? updatedBy,
  }) =>
      Product(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        productSlug: productSlug ?? this.productSlug,
        thumbnail: thumbnail ?? this.thumbnail,
        details: details ?? this.details,
        unitPrice: unitPrice ?? this.unitPrice,
        unitPriceRegular: unitPriceRegular ?? this.unitPriceRegular,
        productType: productType ?? this.productType,
        vat: vat ?? this.vat,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        shippingCost: shippingCost ?? this.shippingCost,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productName: json["product_name"] ?? '',
    productSlug: json["product_slug"] ?? '',
    thumbnail: json["thumbnail"] ?? '',
    details: json["details"] ?? '',
    unitPrice: json["unit_price"] ?? 0,
    unitPriceRegular: json["unit_price_regular"] ?? 0,
    productType: json["product_type"] ?? 0,
    vat: json["vat"] ?? 0,
    status: json["status"] ?? 0,
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    shippingCost: json["shipping_cost"] ?? 0,
    createdBy: json["created_by"] ?? 0,
    updatedBy: json["updated_by"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "product_slug": productSlug,
    "thumbnail": thumbnail,
    "details": details,
    "unit_price": unitPrice,
    "unit_price_regular": unitPriceRegular,
    "product_type": productType,
    "vat": vat,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "shipping_cost": shippingCost,
    "created_by": createdBy,
    "updated_by": updatedBy,
  };
}
