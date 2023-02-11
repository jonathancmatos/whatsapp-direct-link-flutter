import 'package:intl/intl.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';

class LinkHistoricModel extends LinkHistoric {

  const LinkHistoricModel({required String url, required DateTime createdAt})
      : super(url: url, createdAt: createdAt);

  factory LinkHistoricModel.fromJson(Map<String, dynamic> json) {
    return LinkHistoricModel(
      url: json["url"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "created_at": DateFormat("yyyy-MM-dd hh:mm").format(createdAt),
    };
  }

  @override
  String toString() {
    return "{url:$url, created_at:$createdAt}";
  }
}
