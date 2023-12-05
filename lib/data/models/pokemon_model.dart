import 'dart:convert';

import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/domain/entities/status.dart';

PokemonModel pokemonModelFromJson(String str) =>
    PokemonModel.fromJson(json.decode(str));

class PokemonModel {
  int? baseExperience;
  int? height;
  int? id;
  List<Move>? moves;
  String? name;
  int? order;
  Species? species;
  List<Stat>? stats;
  List<Type>? types;
  int? weight;
  String? imageUrl;
  String? description;

  PokemonModel({
    this.baseExperience,
    this.height,
    this.id,
    this.moves,
    this.name,
    this.order,
    this.species,
    this.stats,
    this.types,
    this.weight,
    this.imageUrl,
    this.description,
  });

  Pokemon toEntity() {
    List<Status> statList = [];
    List<String> moveList = [];
    List<String> typeList = [];

    //moveList
    moves?.forEach((element) {
      if (element.move?.name != null) {
        moveList.add(element.move!.name!);
      }
    });

    //poke stats
    stats?.forEach((element) {
      if (element.baseStat != null && element.stat?.name != null) {
        statList.add(
          Status(name: element.stat!.name!, value: element.baseStat!),
        );
      }
    });

    //poke types
    types?.forEach((element) {
      if (element.type?.name != null) {
        typeList.add(element.type!.name!);
      }
    });

    return Pokemon(
      id: id!,
      name: name!,
      image: imageUrl!,
      weight: weight!,
      height: height!,
      moves: moveList,
      description: description!,
      stats: statList,
      types: typeList,
    );
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        baseExperience: json["base_experience"],
        height: json["height"],
        id: json["id"],
        moves: json["moves"] == null
            ? []
            : List<Move>.from(json["moves"]!.map((x) => Move.fromJson(x))),
        name: json["name"],
        order: json["order"],
        species:
            json["species"] == null ? null : Species.fromJson(json["species"]),
        stats: json["stats"] == null
            ? []
            : List<Stat>.from(json["stats"]!.map((x) => Stat.fromJson(x))),
        types: json["types"] == null
            ? []
            : List<Type>.from(json["types"]!.map((x) => Type.fromJson(x))),
        weight: json["weight"],
        imageUrl: json["sprites"]["other"]["home"]["front_default"],
        description: "",
      );
}

class Species {
  String? name;
  String? url;

  Species({
    this.name,
    this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
      );
}

class Move {
  Species? move;
  List<VersionGroupDetail>? versionGroupDetails;

  Move({
    this.move,
    this.versionGroupDetails,
  });

  factory Move.fromJson(Map<String, dynamic> json) => Move(
        move: json["move"] == null ? null : Species.fromJson(json["move"]),
        versionGroupDetails: json["version_group_details"] == null
            ? []
            : List<VersionGroupDetail>.from(json["version_group_details"]!
                .map((x) => VersionGroupDetail.fromJson(x))),
      );
}

class VersionGroupDetail {
  int? levelLearnedAt;
  Species? moveLearnMethod;
  Species? versionGroup;

  VersionGroupDetail({
    this.levelLearnedAt,
    this.moveLearnMethod,
    this.versionGroup,
  });

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) =>
      VersionGroupDetail(
        levelLearnedAt: json["level_learned_at"],
        moveLearnMethod: json["move_learn_method"] == null
            ? null
            : Species.fromJson(json["move_learn_method"]),
        versionGroup: json["version_group"] == null
            ? null
            : Species.fromJson(json["version_group"]),
      );
}

class Stat {
  int? baseStat;
  int? effort;
  Species? stat;

  Stat({
    this.baseStat,
    this.effort,
    this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: json["stat"] == null ? null : Species.fromJson(json["stat"]),
      );
}

class Type {
  int? slot;
  Species? type;

  Type({
    this.slot,
    this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: json["type"] == null ? null : Species.fromJson(json["type"]),
      );
}
