import 'dart:convert';

class MetaData {
  MetaData({
    this.totalRecords,
    this.limit,
    this.page,
    this.totalPage,
  });

  int totalRecords;
  String limit;
  String page;
  int totalPage;

  MetaData copyWith({
    int totalRecords,
    String limit,
    String page,
    int totalPage,
  }) =>
      MetaData(
        totalRecords: totalRecords ?? this.totalRecords,
        limit: limit ?? this.limit,
        page: page ?? this.page,
        totalPage: totalPage ?? this.totalPage,
      );

  factory MetaData.fromRawJson(String str) =>
      MetaData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        totalRecords:
            json["total_records"] == null ? null : json["total_records"],
        limit: json["limit"] == null ? null : json["limit"],
        page: json["page"] == null ? null : json["page"],
        totalPage: json["total_page"] == null ? null : json["total_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_records": totalRecords == null ? null : totalRecords,
        "limit": limit == null ? null : limit,
        "page": page == null ? null : page,
        "total_page": totalPage == null ? null : totalPage,
      };
}
