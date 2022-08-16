class Pokemon {
  int id;
  String num;
  String name;
  String img;
  List<String> type;

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        num = json['num'],
        name = json['name'],
        img = json['img'],
        type = json['type'].cast<String>();

  Pokemon.notFound()
      : id = 0,
        num = '???',
        name = '???',
        img = '',
        type = ['???'];
}

class PokemonCharsDesc {
  final List<ObjectWithDesc> descriptions;

  PokemonCharsDesc({required this.descriptions});

  factory PokemonCharsDesc.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['descriptions'] as List;
    List<ObjectWithDesc> imagesList =
        list.map((i) => ObjectWithDesc.fromJson(i)).toList();
    return PokemonCharsDesc(
      descriptions: imagesList,
    );
  }
}

class ObjectWithDesc {
  String description;
  Language language;
  ObjectWithDesc({required this.description, required this.language});

  factory ObjectWithDesc.fromJson(Map<String, dynamic> parsedJson) {
    return ObjectWithDesc(
      description: parsedJson['description'],
      language: Language.fromJson(parsedJson['language']),
    );
  }
}

class Language {
  String name;
  String url;

  Language({required this.name, required this.url});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['name'],
      url: json['url'],
    );
  }
}
