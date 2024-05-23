class AnimeGenre {
  List<AnimeTypeData>? data;

  AnimeGenre({this.data});

  AnimeGenre.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AnimeTypeData>[];
      json['data'].forEach((v) {
        data!.add(AnimeTypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnimeTypeData {
  int? malId;
  String? name;
  String? url;
  int? count;

  AnimeTypeData({this.malId, this.name, this.url, this.count});

  AnimeTypeData.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    name = json['name'];
    url = json['url'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mal_id'] = malId;
    data['name'] = name;
    data['url'] = url;
    data['count'] = count;
    return data;
  }
}
