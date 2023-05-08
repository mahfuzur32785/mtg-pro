import 'dart:convert';

class MarketMaterialResponseModel {
  MarketMaterialResponseModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int currentPage;
  final List<MarketMaterialModel> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  MarketMaterialResponseModel copyWith({
    int? currentPage,
    List<MarketMaterialModel>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      MarketMaterialResponseModel(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory MarketMaterialResponseModel.fromRawJson(String str) => MarketMaterialResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketMaterialResponseModel.fromJson(Map<String, dynamic> json) => MarketMaterialResponseModel(
    currentPage: json["current_page"],
    data: List<MarketMaterialModel>.from(json["data"].map((x) => MarketMaterialModel.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class MarketMaterialModel {
  MarketMaterialModel({
    required this.id,
    required this.title,
    required this.orderId,
    required this.image,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.authorName,
    required this.file,
  });

  final int id;
  final String title;
  final int orderId;
  final String image;
  final String description;
  final int status;
  final DateTime createdAt;
  final dynamic createdBy;
  final DateTime updatedAt;
  final dynamic updatedBy;
  final String authorName;
  final String file;

  MarketMaterialModel copyWith({
    int? id,
    String? title,
    int? orderId,
    String? image,
    String? description,
    int? status,
    DateTime? createdAt,
    dynamic createdBy,
    DateTime? updatedAt,
    dynamic updatedBy,
    String? authorName,
    String? file,
  }) =>
      MarketMaterialModel(
        id: id ?? this.id,
        title: title ?? this.title,
        orderId: orderId ?? this.orderId,
        image: image ?? this.image,
        description: description ?? this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
        authorName: authorName ?? this.authorName,
        file: file ?? this.file,
      );

  factory MarketMaterialModel.fromRawJson(String str) => MarketMaterialModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketMaterialModel.fromJson(Map<String, dynamic> json) => MarketMaterialModel(
    id: json["id"],
    title: json["title"],
    orderId: json["order_id"],
    image: json["image"],
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    updatedAt: DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"],
    authorName: json["author_name"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "order_id": orderId,
    "image": image,
    "description": description,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "created_by": createdBy,
    "updated_at": updatedAt.toIso8601String(),
    "updated_by": updatedBy,
    "author_name": authorName,
    "file": file,
  };
}
