const String tableFavourites = 'favourites';

// column names for the favourites table
class FavouritesFieldNames {
  // all fields
  static final fields = [
    id,
    nickname,
    num,
    name,
    img,
  ];
  static const String id = '_id';
  static const String nickname = 'nickname';
  static const String num = 'num';
  static const String name = 'name';
  static const String img = 'img';
}

// db model
class Favourite {
  final int? id;
  final String nickname;
  final String num;
  final String name;
  final String img;

  Favourite(
      {this.id,
      required this.nickname,
      required this.num,
      required this.name,
      required this.img});

  Map<String, Object?> toJson() => {
        FavouritesFieldNames.id: id,
        FavouritesFieldNames.nickname: nickname,
        FavouritesFieldNames.num: num,
        FavouritesFieldNames.name: name,
        FavouritesFieldNames.img: img,
      };

  static Favourite fromJson(Map<String, Object?> json) => Favourite(
        id: json[FavouritesFieldNames.id] as int?,
        nickname: json[FavouritesFieldNames.nickname] as String,
        num: json[FavouritesFieldNames.num] as String,
        name: json[FavouritesFieldNames.name] as String,
        img: json[FavouritesFieldNames.img] as String,
      );

  Favourite copyWith(
          {int? id,
          String? nickname,
          String? num,
          String? name,
          String? img}) =>
      Favourite(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        num: num ?? this.num,
        name: name ?? this.name,
        img: img ?? this.img,
      );
}
