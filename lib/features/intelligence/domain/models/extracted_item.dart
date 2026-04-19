import 'package:equatable/equatable.dart';

enum ExtractedType { actionItem, deadline, keyword, contact }

class ExtractedItem extends Equatable {
  final String content;
  final ExtractedType type;
  final int offset;
  final int length;

  const ExtractedItem({
    required this.content,
    required this.type,
    required this.offset,
    required this.length,
  });

  @override
  List<Object?> get props => [content, type, offset, length];
}
