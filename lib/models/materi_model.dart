class MateriModel {
  String id;
  String judul;
  String url;

  MateriModel({
    required this.id,
    required this.judul,
    required this.url,
  });

  factory MateriModel.fromJson(Map<String, dynamic> json) => MateriModel(
        id: json["id"],
        judul: json["judul"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "url": url,
      };
}
