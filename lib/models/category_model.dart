class CategoryModel {
/*
{
  "id": 13,
  "name": "Residential",
  "status": "published",
  "order": 1,
  "image": "24.jpg",
  "is_default": 0,
  "created_at": "2020-09-12 10:31:57",
  "updated_at": "2021-04-04 18:08:29",
  "count" : "6"
} 
*/

  int? id;
  String? name;
  String? status;
  int? order;
  String? image;
  int? isDefault;
  String? createdAt;
  String? updatedAt;
  int? count;

  CategoryModel({
    this.id,
    this.name,
    this.status,
    this.order,
    this.image,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.count,
  });
  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    status = json['status']?.toString();
    order = json['order']?.toInt();
    image = json['image']?.toString();
    isDefault = json['is_default']?.toInt();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    count = json['count']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['order'] = order;
    data['image'] = image;
    data['is_default'] = isDefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['count'] = count;
    return data;
  }
}
