class Sizes {
  int? sft;
  String? bed;
  List<String>? beds;
  String? bath;
  List<String>? baths;
  String? balcony;
  List<String>? balconies;
  Sizes(this.sft, this.bed, this.bath, this.balcony,this.beds,this.baths,this.balconies);
}

// To parse this JSON data, do
//
//     final sizesModel = sizesModelFromJson(jsonString);

// import 'dart:convert';
//
// SizesModel sizesModelFromJson(String str) => SizesModel.fromJson(json.decode(str));
//
// String sizesModelToJson(SizesModel data) => json.encode(data.toJson());

// class SizesModel {
//   SizesModel({
//     this.sft,
//     this.bed,
//     this.bath,
//     this.balcony,
//     this.beds,
//     this.bats,
//     this.balconies,
//   });
//
//   int? sft;
//   String? bed;
//   String? bath;
//   String? balcony;
//   List<String>? beds;
//   List<String>? bats;
//   List<String>? balconies;
//
//   factory SizesModel.fromJson(Map<String, dynamic> json) => SizesModel(
//     sft: json["sft"],
//     bed: json["bed"],
//     bath: json["bath"],
//     balcony: json["balcony"],
//     beds: List<String>.from(json["beds"].map((x) => x)),
//     bats: List<String>.from(json["bats"].map((x) => x)),
//     balconies: List<String>.from(json["balconies"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "sft": sft,
//     "bed": bed,
//     "bath": bath,
//     "balcony": balcony,
//     "beds": List<dynamic>.from(beds!.map((x) => x)),
//     "bats": List<dynamic>.from(bats!.map((x) => x)),
//     "balconies": List<dynamic>.from(balconies!.map((x) => x)),
//   };
// }