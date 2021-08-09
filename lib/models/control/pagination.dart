import 'dart:convert';

Pagination paginationFromJson(String str) =>
    Pagination.fromJson(json.decode(str));

String paginationToJson(Pagination data) => json.encode(data.toJson());

class Pagination {
  Pagination({
    this.totalRecords,
    this.limit,
    this.page,
    this.totalPage,
  });

  int totalRecords;
  String limit;
  String page;
  int totalPage;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
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
