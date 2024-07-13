class DalleResponseModel {
  final int created;
  final List<DataItem> data;

  DalleResponseModel({required this.created, required this.data});

  factory DalleResponseModel.fromJson(Map<String, dynamic> json) {
    return DalleResponseModel(
      created: json['created'],
      data: (json['data'] as List).map((i) => DataItem.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created': created,
      'data': data.map((i) => i.toJson()).toList(),
    };
  }
}

class DataItem {
  final String url;

  DataItem({required this.url});

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
