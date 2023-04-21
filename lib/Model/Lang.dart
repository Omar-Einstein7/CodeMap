class Lang {
  int? id;
  String? name;
  String? URl;



  Lang(
      {this.id,
        this.name,
        this.URl,

      });

  Lang.fromJson(Map<String, dynamic> json) {
    id = json['LangId'];
    name = json['Name'];
    URl = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LangId'] = this.id;
    data['Name'] = this.name;
    data['URL'] = this.URl;

    return data;
  }
}

