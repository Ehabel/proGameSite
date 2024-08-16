class PopularGamesModel {
  int? _count;
  String? _next;
  String? _previous;
  List<Results>? _results;

  PopularGamesModel(
      {int? count, String? next, String? previous, List<Results>? results}) {
    if (count != null) {
      this._count = count;
    }
    if (next != null) {
      this._next = next;
    }
    if (previous != null) {
      this._previous = previous;
    }
    if (results != null) {
      this._results = results;
    }
  }

  int? get count => _count;
  set count(int? count) => _count = count;
  String? get next => _next;
  set next(String? next) => _next = next;
  String? get previous => _previous;
  set previous(String? previous) => _previous = previous;
  List<Results>? get results => _results;
  set results(List<Results>? results) => _results = results;

  PopularGamesModel.fromJson(Map<String, dynamic> json) {
    _count = json['count'];
    _next = json['next'];
    _previous = json['previous'];
    if (json['results'] != null) {
      _results = <Results>[];
      json['results'].forEach((v) {
        _results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this._count;
    data['next'] = this._next;
    data['previous'] = this._previous;
    if (this._results != null) {
      data['results'] = this._results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? _id;
  String? _slug;
  String? _name;
  String? _released;
  bool? _tba;
  String? _backgroundImage;
  double? _rating;
  int? _ratingTop;
  List<Ratings>? _ratings;
  int? _ratingsCount;
  int? _reviewsTextCount;
  int? _added;
  AddedByStatus? _addedByStatus;
  int? _metacritic;
  int? _playtime;
  int? _suggestionsCount;
  String? _updated;
  EsrbRating? _esrbRating;
  List<Platforms>? _platforms;

  Results(
      {int? id,
        String? slug,
        String? name,
        String? released,
        bool? tba,
        String? backgroundImage,
        double? rating,
        int? ratingTop,
        List<Ratings>? ratings,
        int? ratingsCount,
        int? reviewsTextCount,
        int? added,
        AddedByStatus? addedByStatus,
        int? metacritic,
        int? playtime,
        int? suggestionsCount,
        String? updated,
        EsrbRating? esrbRating,
        List<Platforms>? platforms}) {
    if (id != null) {
      this._id = id;
    }
    if (slug != null) {
      this._slug = slug;
    }
    if (name != null) {
      this._name = name;
    }
    if (released != null) {
      this._released = released;
    }
    if (tba != null) {
      this._tba = tba;
    }
    if (backgroundImage != null) {
      this._backgroundImage = backgroundImage;
    }
    if (rating != null) {
      this._rating = rating;
    }
    if (ratingTop != null) {
      this._ratingTop = ratingTop;
    }
    if (ratings != null) {
      this._ratings = ratings;
    }
    if (ratingsCount != null) {
      this._ratingsCount = ratingsCount;
    }
    if (reviewsTextCount != null) {
      this._reviewsTextCount = reviewsTextCount;
    }
    if (added != null) {
      this._added = added;
    }
    if (addedByStatus != null) {
      this._addedByStatus = addedByStatus;
    }
    if (metacritic != null) {
      this._metacritic = metacritic;
    }
    if (playtime != null) {
      this._playtime = playtime;
    }
    if (suggestionsCount != null) {
      this._suggestionsCount = suggestionsCount;
    }
    if (updated != null) {
      this._updated = updated;
    }
    if (esrbRating != null) {
      this._esrbRating = esrbRating;
    }
    if (platforms != null) {
      this._platforms = platforms;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get slug => _slug;
  set slug(String? slug) => _slug = slug;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get released => _released;
  set released(String? released) => _released = released;
  bool? get tba => _tba;
  set tba(bool? tba) => _tba = tba;
  String? get backgroundImage => _backgroundImage;
  set backgroundImage(String? backgroundImage) =>
      _backgroundImage = backgroundImage;
  double? get rating => _rating;
  set rating(double? rating) => _rating = rating;
  int? get ratingTop => _ratingTop;
  set ratingTop(int? ratingTop) => _ratingTop = ratingTop;
  List<Ratings>? get ratings => _ratings;
  set ratings(List<Ratings>? ratings) => _ratings = ratings;
  int? get ratingsCount => _ratingsCount;
  set ratingsCount(int? ratingsCount) => _ratingsCount = ratingsCount;
  int? get reviewsTextCount => _reviewsTextCount;
  set reviewsTextCount(int? reviewsTextCount) =>
      _reviewsTextCount = reviewsTextCount;
  int? get added => _added;
  set added(int? added) => _added = added;
  AddedByStatus? get addedByStatus => _addedByStatus;
  set addedByStatus(AddedByStatus? addedByStatus) =>
      _addedByStatus = addedByStatus;
  int? get metacritic => _metacritic;
  set metacritic(int? metacritic) => _metacritic = metacritic;
  int? get playtime => _playtime;
  set playtime(int? playtime) => _playtime = playtime;
  int? get suggestionsCount => _suggestionsCount;
  set suggestionsCount(int? suggestionsCount) =>
      _suggestionsCount = suggestionsCount;
  String? get updated => _updated;
  set updated(String? updated) => _updated = updated;
  EsrbRating? get esrbRating => _esrbRating;
  set esrbRating(EsrbRating? esrbRating) => _esrbRating = esrbRating;
  List<Platforms>? get platforms => _platforms;
  set platforms(List<Platforms>? platforms) => _platforms = platforms;

  Results.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _slug = json['slug'];
    _name = json['name'];
    _released = json['released'];
    _tba = json['tba'];
    _backgroundImage = json['background_image'];
    _rating = json['rating'];
    _ratingTop = json['rating_top'];
    if (json['ratings'] != null) {
      _ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        _ratings!.add(new Ratings.fromJson(v));
      });
    }
    _ratingsCount = json['ratings_count'];
    _reviewsTextCount = json['reviews_text_count'];
    _added = json['added'];
    _addedByStatus = json['added_by_status'] != null
        ? new AddedByStatus.fromJson(json['added_by_status'])
        : null;
    _metacritic = json['metacritic'];
    _playtime = json['playtime'];
    _suggestionsCount = json['suggestions_count'];
    _updated = json['updated'];
    _esrbRating = json['esrb_rating'] != null
        ? new EsrbRating.fromJson(json['esrb_rating'])
        : null;
    if (json['platforms'] != null) {
      _platforms = <Platforms>[];
      json['platforms'].forEach((v) {
        _platforms!.add(new Platforms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['slug'] = this._slug;
    data['name'] = this._name;
    data['released'] = this._released;
    data['tba'] = this._tba;
    data['background_image'] = this._backgroundImage;
    data['rating'] = this._rating;
    data['rating_top'] = this._ratingTop;
    if (this._ratings != null) {
      data['ratings'] = this._ratings!.map((v) => v.toJson()).toList();
    }
    data['ratings_count'] = this._ratingsCount;
    data['reviews_text_count'] = this._reviewsTextCount;
    data['added'] = this._added;
    if (this._addedByStatus != null) {
      data['added_by_status'] = this._addedByStatus!.toJson();
    }
    data['metacritic'] = this._metacritic;
    data['playtime'] = this._playtime;
    data['suggestions_count'] = this._suggestionsCount;
    data['updated'] = this._updated;
    if (this._esrbRating != null) {
      data['esrb_rating'] = this._esrbRating!.toJson();
    }
    if (this._platforms != null) {
      data['platforms'] = this._platforms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ratings {
  int? _id;
  String? _title;
  int? _count;
  double? _percent;

  Ratings({int? id, String? title, int? count, double? percent}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (count != null) {
      this._count = count;
    }
    if (percent != null) {
      this._percent = percent;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  int? get count => _count;
  set count(int? count) => _count = count;
  double? get percent => _percent;
  set percent(double? percent) => _percent = percent;

  Ratings.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _count = json['count'];
    _percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['count'] = this._count;
    data['percent'] = this._percent;
    return data;
  }
}

class AddedByStatus {
  int? _yet;
  int? _owned;
  int? _beaten;
  int? _toplay;
  int? _dropped;
  int? _playing;

  AddedByStatus(
      {int? yet,
        int? owned,
        int? beaten,
        int? toplay,
        int? dropped,
        int? playing}) {
    if (yet != null) {
      this._yet = yet;
    }
    if (owned != null) {
      this._owned = owned;
    }
    if (beaten != null) {
      this._beaten = beaten;
    }
    if (toplay != null) {
      this._toplay = toplay;
    }
    if (dropped != null) {
      this._dropped = dropped;
    }
    if (playing != null) {
      this._playing = playing;
    }
  }

  int? get yet => _yet;
  set yet(int? yet) => _yet = yet;
  int? get owned => _owned;
  set owned(int? owned) => _owned = owned;
  int? get beaten => _beaten;
  set beaten(int? beaten) => _beaten = beaten;
  int? get toplay => _toplay;
  set toplay(int? toplay) => _toplay = toplay;
  int? get dropped => _dropped;
  set dropped(int? dropped) => _dropped = dropped;
  int? get playing => _playing;
  set playing(int? playing) => _playing = playing;

  AddedByStatus.fromJson(Map<String, dynamic> json) {
    _yet = json['yet'];
    _owned = json['owned'];
    _beaten = json['beaten'];
    _toplay = json['toplay'];
    _dropped = json['dropped'];
    _playing = json['playing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yet'] = this._yet;
    data['owned'] = this._owned;
    data['beaten'] = this._beaten;
    data['toplay'] = this._toplay;
    data['dropped'] = this._dropped;
    data['playing'] = this._playing;
    return data;
  }
}

class EsrbRating {
  int? _id;
  String? _slug;
  String? _name;

  EsrbRating({int? id, String? slug, String? name}) {
    if (id != null) {
      this._id = id;
    }
    if (slug != null) {
      this._slug = slug;
    }
    if (name != null) {
      this._name = name;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get slug => _slug;
  set slug(String? slug) => _slug = slug;
  String? get name => _name;
  set name(String? name) => _name = name;

  EsrbRating.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _slug = json['slug'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['slug'] = this._slug;
    data['name'] = this._name;
    return data;
  }
}

class Platforms {
  EsrbRating? _platform;
  String? _releasedAt;
  Requirements? _requirements;

  Platforms(
      {EsrbRating? platform, String? releasedAt, Requirements? requirements}) {
    if (platform != null) {
      this._platform = platform;
    }
    if (releasedAt != null) {
      this._releasedAt = releasedAt;
    }
    if (requirements != null) {
      this._requirements = requirements;
    }
  }

  EsrbRating? get platform => _platform;
  set platform(EsrbRating? platform) => _platform = platform;
  String? get releasedAt => _releasedAt;
  set releasedAt(String? releasedAt) => _releasedAt = releasedAt;
  Requirements? get requirements => _requirements;
  set requirements(Requirements? requirements) => _requirements = requirements;

  Platforms.fromJson(Map<String, dynamic> json) {
    _platform = json['platform'] != null
        ? new EsrbRating.fromJson(json['platform'])
        : null;
    _releasedAt = json['released_at'];
    _requirements = json['requirements'] != null
        ? new Requirements.fromJson(json['requirements'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._platform != null) {
      data['platform'] = this._platform!.toJson();
    }
    data['released_at'] = this._releasedAt;
    if (this._requirements != null) {
      data['requirements'] = this._requirements!.toJson();
    }
    return data;
  }
}

class Requirements {
  String? _minimum;
  String? _recommended;

  Requirements({String? minimum, String? recommended}) {
    if (minimum != null) {
      this._minimum = minimum;
    }
    if (recommended != null) {
      this._recommended = recommended;
    }
  }

  String? get minimum => _minimum;
  set minimum(String? minimum) => _minimum = minimum;
  String? get recommended => _recommended;
  set recommended(String? recommended) => _recommended = recommended;

  Requirements.fromJson(Map<String, dynamic> json) {
    _minimum = json['minimum'];
    _recommended = json['recommended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum'] = this._minimum;
    data['recommended'] = this._recommended;
    return data;
  }
}
