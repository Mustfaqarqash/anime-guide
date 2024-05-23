class AnimeJson {
  final Pagination? pagination;
  final List<Data> data;

  AnimeJson({
    required this.pagination,
    required this.data,
  });

  factory AnimeJson.fromJson(Map<String, dynamic> json) {
    return AnimeJson(
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class Data {
  final int? malId;
  final String? url;
  final Map<String, Imagee> images;
  final Trailer? trailer;
  final bool? approved;
  final List<Title> titles;
  final String title;
  final String? titleEnglish;
  final String? titleJapanese;
  final List<String> titleSynonyms;
  final String? type;
  final String? source;
  final int? episodes;
  final String? status;
  final bool? airing;
  final Aired? aired;
  final String? duration;
  final String? rating;
  final double? score;
  final int? scoredBy;
  final int? rank;
  final int? popularity;
  final int? members;
  final int? favorites;
  final String? synopsis;
  final String? background;
  final String? season;
  final int? year;
  final Broadcast? broadcast;
  final List<Demographic> producers;
  final List<Demographic> licensors;
  final List<Demographic> studios;
  final List<Demographic> genres;
  final List<dynamic> explicitGenres;
  final List<Demographic> themes;
  final List<Demographic> demographics;

  Data({
    required this.malId,
    required this.url,
    required this.images,
    required this.trailer,
    required this.approved,
    required this.titles,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.titleSynonyms,
    required this.type,
    required this.source,
    required this.episodes,
    required this.status,
    required this.airing,
    required this.aired,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.background,
    required this.season,
    required this.year,
    required this.broadcast,
    required this.producers,
    required this.licensors,
    required this.studios,
    required this.genres,
    required this.explicitGenres,
    required this.themes,
    required this.demographics,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      malId: json["mal_id"],
      url: json["url"],
      images: Map.from(json["images"])
          .map((k, v) => MapEntry<String, Imagee>(k, Imagee.fromJson(v))),
      trailer:
          json["trailer"] == null ? null : Trailer.fromJson(json["trailer"]),
      approved: json["approved"],
      titles: (json["titles"] as List<dynamic>?)
              ?.map((e) => Title.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      title: json["title"],
      titleEnglish: json["title_english"],
      titleJapanese: json["title_japanese"],
      titleSynonyms: json["title_synonyms"] == null
          ? []
          : List<String>.from(json["title_synonyms"]!.cast<String>()),
      type: json["type"],
      source: json["source"],
      episodes: json["episodes"],
      status: json["status"],
      airing: json["airing"],
      aired: json["aired"] == null ? null : Aired.fromJson(json["aired"]),
      duration: json["duration"],
      rating: json["rating"],
      score: json["score"]?.toDouble() ?? 0.0,
      scoredBy: json["scored_by"],
      rank: json["rank"],
      popularity: json["popularity"],
      members: json["members"],
      favorites: json["favorites"],
      synopsis: json["synopsis"],
      background: json["background"],
      season: json["season"],
      year: json["year"],
      broadcast: json["broadcast"] == null
          ? null
          : Broadcast.fromJson(json["broadcast"]),
      producers: (json["producers"] as List<dynamic>?)
              ?.map((e) => Demographic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      licensors: (json["licensors"] as List<dynamic>?)
              ?.map((e) => Demographic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      studios: (json["studios"] as List<dynamic>?)
              ?.map((e) => Demographic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      genres: (json["genres"] as List<dynamic>?)
              ?.map((e) => Demographic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      explicitGenres: json["explicit_genres"] == null
          ? []
          : List<dynamic>.from(json["explicit_genres"]!.cast<dynamic>()),
      themes: (json["themes"] as List<dynamic>?)
              ?.map((e) => Demographic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      demographics: (json["demographics"] as List<dynamic>?)
              ?.map((e) => Demographic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class Aired {
  Aired({
    required this.from,
    required this.to,
    required this.prop,
    required this.string,
  });

  final DateTime? from;
  final DateTime? to;
  final Prop? prop;
  final String? string;

  factory Aired.fromJson(Map<String, dynamic> json) {
    return Aired(
      from: DateTime.tryParse(json["from"] ?? ""),
      to: DateTime.tryParse(json["to"] ?? ""),
      prop: json["prop"] == null ? null : Prop.fromJson(json["prop"]),
      string: json["string"],
    );
  }
}

class Prop {
  Prop({
    required this.from,
    required this.to,
  });

  final From? from;
  final From? to;

  factory Prop.fromJson(Map<String, dynamic> json) {
    return Prop(
      from: json["from"] == null ? null : From.fromJson(json["from"]),
      to: json["to"] == null ? null : From.fromJson(json["to"]),
    );
  }
}

class From {
  From({
    required this.day,
    required this.month,
    required this.year,
  });

  final int? day;
  final int? month;
  final int? year;

  factory From.fromJson(Map<String, dynamic> json) {
    return From(
      day: json["day"],
      month: json["month"],
      year: json["year"],
    );
  }
}

class Broadcast {
  Broadcast({
    required this.day,
    required this.time,
    required this.timezone,
    required this.string,
  });

  final String? day;
  final String? time;
  final String? timezone;
  final String? string;

  factory Broadcast.fromJson(Map<String, dynamic> json) {
    return Broadcast(
      day: json["day"],
      time: json["time"],
      timezone: json["timezone"],
      string: json["string"],
    );
  }
}

class Demographic {
  Demographic({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  final int? malId;
  final String? type;
  final String? name;
  final String? url;

  factory Demographic.fromJson(Map<String, dynamic> json) {
    return Demographic(
      malId: json["mal_id"],
      type: json["type"],
      name: json["name"],
      url: json["url"],
    );
  }
}

class Imagee {
  Imagee({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  final String imageUrl;
  final String? smallImageUrl;
  final String? largeImageUrl;

  factory Imagee.fromJson(Map<String, dynamic> json) {
    return Imagee(
      imageUrl: json["image_url"],
      smallImageUrl: json["small_image_url"],
      largeImageUrl: json["large_image_url"],
    );
  }
}

class Title {
  Title({
    required this.type,
    required this.title,
  });

  final String? type;
  final String? title;

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      type: json["type"],
      title: json["title"],
    );
  }
}

class Trailer {
  Trailer({
    required this.youtubeId,
    required this.url,
    required this.embedUrl,
    required this.images,
  });

  final String? youtubeId;
  final String? url;
  final String? embedUrl;
  final Images? images;

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      youtubeId: json["youtube_id"],
      url: json["url"],
      embedUrl: json["embed_url"],
      images: json["images"] == null ? null : Images.fromJson(json["images"]),
    );
  }
}

class Images {
  Images({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.mediumImageUrl,
    required this.largeImageUrl,
    required this.maximumImageUrl,
  });

  final String? imageUrl;
  final String? smallImageUrl;
  final String? mediumImageUrl;
  final String? largeImageUrl;
  final String? maximumImageUrl;

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      imageUrl: json["image_url"],
      smallImageUrl: json["small_image_url"],
      mediumImageUrl: json["medium_image_url"],
      largeImageUrl: json["large_image_url"],
      maximumImageUrl: json["maximum_image_url"],
    );
  }
}

class Pagination {
  final int? lastVisiblePage;

  Pagination({
    required this.lastVisiblePage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      lastVisiblePage: json['last_visible_page'],
    );
  }
}

class Items {
  Items({
    required this.count,
    required this.total,
    required this.perPage,
  });

  final int? count;
  final int? total;
  final int? perPage;

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      count: json["count"],
      total: json["total"],
      perPage: json["per_page"],
    );
  }
}
