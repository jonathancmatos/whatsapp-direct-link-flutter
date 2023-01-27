import 'package:equatable/equatable.dart';

class LinkHistoric extends Equatable{
  final String url;
  final DateTime createdAt;

  const LinkHistoric({
    required this.url,
    required this.createdAt,
  });
  
  @override
  List<Object?> get props => [url, createdAt];

}
