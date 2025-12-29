import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class SendSupportMessageParams extends Equatable {
  final String content;
  final int? packageId;
  final List<String> attachments;

  const SendSupportMessageParams({
    required this.content,
    required this.attachments,
    required this.packageId,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      'comment': content,
      for (var i = 0; i < attachments.length; i++)
        'attachments[$i]': await MultipartFile.fromFile(attachments[i]),
    };
  }

  @override
  List<Object?> get props => [content, attachments, packageId];
}
