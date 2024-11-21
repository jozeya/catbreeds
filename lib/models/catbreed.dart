class CatBreed{
  final String? id;
  final String? name;
  final String? origin;
  final int? intelligence;
  final String? description;
  final int? adaptability;
  final String? imgReference;

  CatBreed.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        name = json['name'],
        origin = json['origin'],
        intelligence = json['intelligence'] ?? 0,
        description = json['description'],
        adaptability= json['adaptability'] ?? 0,
        imgReference = json['reference_image_id'] ;
}