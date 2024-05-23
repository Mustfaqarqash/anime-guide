class CharactersModel {
  final List<Datume> data;

  CharactersModel({required this.data});

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    List<Datume> dataList = [];
    if (json['data'] != null) {
      dataList = (json['data'] as List)
          .map((v) => Datume.fromJson(v as Map<String, dynamic>))
          .toList();
    }
    return CharactersModel(data: dataList);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class Datume {
  Character? character;
  String? role;
  int? favorites;
  List<VoiceActors>? voiceActors;

  Datume({this.character, this.role, this.favorites, this.voiceActors});

  Datume.fromJson(Map<String, dynamic> json) {
    character = json['character'] != null
        ? Character.fromJson(json['character'])
        : null;
    role = json['role'];
    favorites = json['favorites'];
    if (json['voice_actors'] != null) {
      voiceActors = <VoiceActors>[];
      json['voice_actors'].forEach((v) {
        voiceActors!.add(VoiceActors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (character != null) {
      data['character'] = character!.toJson();
    }
    data['role'] = role;
    data['favorites'] = favorites;
    if (voiceActors != null) {
      data['voice_actors'] = voiceActors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Character {
  int? malId;
  String? url;
  Imagesee? images;
  String? name;

  Character({this.malId, this.url, this.images, this.name});

  Character.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    images = json['images'] != null ? Imagesee.fromJson(json['images']) : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mal_id'] = malId;
    data['url'] = url;
    if (images != null) {
      data['images'] = images!.toJson();
    }
    data['name'] = name;
    return data;
  }
}

class Imagesee {
  Jpg? jpg;
  Webp? webp;

  Imagesee({this.jpg, this.webp});

  Imagesee.fromJson(Map<String, dynamic> json) {
    jpg = json['jpg'] != null ? Jpg.fromJson(json['jpg']) : null;
    webp = json['webp'] != null ? Webp.fromJson(json['webp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jpg != null) {
      data['jpg'] = jpg!.toJson();
    }
    if (webp != null) {
      data['webp'] = webp!.toJson();
    }
    return data;
  }
}

class Jpg {
  String? imageUrl;

  Jpg({this.imageUrl});

  Jpg.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    return data;
  }
}

class Webp {
  String? imageUrl;
  String? smallImageUrl;

  Webp({this.imageUrl, this.smallImageUrl});

  Webp.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['small_image_url'] = smallImageUrl;
    return data;
  }
}

class VoiceActors {
  Character? person;
  String? language;

  VoiceActors({this.person, this.language});

  VoiceActors.fromJson(Map<String, dynamic> json) {
    person = json['person'] != null ? Character.fromJson(json['person']) : null;
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (person != null) {
      data['person'] = person!.toJson();
    }
    data['language'] = language;
    return data;
  }
}

class Images {
  Jpg? jpg;

  Images({this.jpg});

  Images.fromJson(Map<String, dynamic> json) {
    jpg = json['jpg'] != null ? Jpg.fromJson(json['jpg']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jpg != null) {
      data['jpg'] = jpg!.toJson();
    }
    return data;
  }
}
