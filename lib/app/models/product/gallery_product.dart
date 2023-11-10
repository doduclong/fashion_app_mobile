class GalleryProduct{
  int? id;
  String? image;


  GalleryProduct({this.id, this.image});

  factory GalleryProduct.fromJson(Map<String, dynamic> json) => GalleryProduct(
    id: json["id"],
    image: json["image"],
  );
}