class Pokemon {
   int id;
   String num;
   String name;
   String img;
   List<String> type;

  Pokemon.fromJson(Map<String, dynamic> json): 
    id = json['id'],
    num = json['num'],
    name = json['name'],
    img = json['img'],
    type = json['type'].cast<String>(); 
}
