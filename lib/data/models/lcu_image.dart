import 'package:equatable/equatable.dart';

class LcuImage extends Equatable {
  final String url;
  final Map<String, String> headers;

  const LcuImage({
    required this.url,
    required this.headers,
  });

  @override
  List<Object?> get props => [url, headers];
}
