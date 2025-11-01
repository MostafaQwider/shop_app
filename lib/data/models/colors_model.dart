
import '../../domain/entities/colors_entity.dart';

class ColorsModel {
  final ColorsEntity entity;

  ColorsModel({required this.entity});

  factory ColorsModel.fromJson(Map<String, dynamic> json) {
    return ColorsModel(
      entity: ColorsEntity(
        id: json['id'],
        name: json['name'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'name': entity.name,
    };
  }

  factory ColorsModel.fromEntity(ColorsEntity entity) {
    return ColorsModel(entity: entity);
  }

  ColorsEntity toEntity() {
    return entity;
  }
}
