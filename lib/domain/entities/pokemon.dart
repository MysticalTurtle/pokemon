import 'package:pokedex/domain/entities/status.dart';

class Pokemon {
  final int id;
  final String name;
  final String image;
  final int weight;
  final int height;
  final List<String> moves;
  final String description;
  final List<Status> stats;
  final List<String> types;

  const Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.weight,
    required this.height,
    required this.moves,
    required this.description,
    required this.stats,
    required this.types,
  });

  factory Pokemon.fromMap(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      weight: json['weight'],
      height: json['height'],
      moves: json["moves"],
      description: json['description'],
      stats: List<Status>.from(json["stats"].map((x) => x)),
      types: json["types"],
    );
  }

  //to json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'weight': weight,
      'height': height,
      'moves': moves,
      'description': description,
      'stats': List<Status>.from(stats.map((x) => x.toMap())),
      'types': types,
    };
  }
}
