
class Dichvu {
  String id;
  String ten_dichvu;

  Dichvu({required this.id, required this.ten_dichvu});

  factory Dichvu.fromJson(Map<String, dynamic> json) {
    return Dichvu(
      id: json['id'] as String,
      ten_dichvu: json['ten_dichvu'] as String,
    );
  }
}