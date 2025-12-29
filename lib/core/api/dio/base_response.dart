import 'dart:convert';

import 'package:equatable/equatable.dart';

class BaseResponse<T> extends Equatable {
  final bool? status;

  // final String? errNum;
  final String? msg;
  final T? data;
  final PaginationModel? pagination;

  const BaseResponse({
    this.status,
    // this.errNum,
    this.msg,
    this.data,
    this.pagination,
  });

  // copyWith
  BaseResponse<T> copyWith({
    bool? status,
    // String? errNum,
    String? msg,
    T? data,
    PaginationModel? pagination,
  }) {
    return BaseResponse<T>(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      statusKey: status,
      // errNumKey: errNum,
      msgKey: msg,
      dataKey: jsonEncode(data),
      paginationKey: jsonEncode(pagination),
    };
  }

  static const statusKey = 'status';
  static const msgKey = 'message';
  static const dataKey = 'data';
  static const paginationKey = 'pagination';

  @override
  List<Object?> get props => [
    status,
    // errNum,
    msg,
    data,
  ];
}

class PaginationModel extends Equatable {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int from;
  final int to;
  final int total;

  const PaginationModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.from,
    required this.to,
    required this.total,
  });

  static const maxPerPage = 10;

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      from: json['from'] ?? 0,
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [currentPage, lastPage, perPage, from, to, total];
}
