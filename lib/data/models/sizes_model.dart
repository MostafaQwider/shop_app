
import '../../domain/entities/sizes_entity.dart';

class SizesModel {
  final SizesEntity entity;

  SizesModel({required this.entity});

  factory SizesModel.fromJson(Map<String, dynamic> json) {
    return SizesModel(
      entity: SizesEntity(
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

  factory SizesModel.fromEntity(SizesEntity entity) {
    return SizesModel(entity: entity);
  }

  SizesEntity toEntity() {
    return entity;
  }
}
