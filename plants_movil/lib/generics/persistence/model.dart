class BaseModel {
  int? id;
  DateTime? created;
  DateTime? updated;
  DateTime? deleted;

  // String toJson([model]) => json.encode(model ?? this);

  BaseModel([this.id, this.created, this.updated, this.deleted]);
  BaseModel.fromMap(Map<String, dynamic> jsonMap) {
    fromMap(jsonMap);
  }

  fromMap(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    created = DateTime.tryParse(jsonMap['created']);
    updated = DateTime.tryParse(jsonMap['updated']);
    deleted = DateTime.tryParse(jsonMap['deleted'] ?? '');
  }
}
