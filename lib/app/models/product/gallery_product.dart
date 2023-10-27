class GalleryProduct{
  int? id;
  String? thumbnail;


  GalleryProduct({this.id, this.thumbnail});

  factory GalleryProduct.fromJson(Map<String, dynamic> json) => GalleryProduct(
    id: json["id"],
    thumbnail: json["thumbnail"],
  );
}