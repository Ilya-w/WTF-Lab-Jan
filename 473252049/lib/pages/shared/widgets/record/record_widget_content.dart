import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import '../../../category/cubit/records_cubit.dart';
import '../message_text.dart';
import 'record_category_name.dart';
import 'record_image.dart';
import 'record_info_row.dart';

class RecordWidgetContent extends StatelessWidget {
  final bool isFavorite;
  final Alignment bubbleAlignment;
  final File image;
  final String message;
  final bool isDateRecord;
  final List<RecordWithCategory> records;
  final DateTime createDateTime;
  final bool withCategory;
  final String categoryName;
  final int categoryId;
  final bool isOnSearchPage;
  final Color color;

  const RecordWidgetContent({
    Key key,
    @required this.isFavorite,
    @required this.bubbleAlignment,
    @required this.image,
    @required this.message,
    @required this.isDateRecord,
    @required this.records,
    @required this.createDateTime,
    @required this.withCategory,
    @required this.categoryName,
    @required this.categoryId,
    this.isOnSearchPage,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Bubble(
        padding: BubbleEdges.zero,
        radius: Radius.circular(8),
        color: color,
        alignment: bubbleAlignment,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Column(
              crossAxisAlignment: bubbleAlignment == Alignment.centerRight
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (image != null) RecordImage(image: image),
                Padding(
                  padding: EdgeInsets.only(
                    top: image == null ? 0 : 2,
                  ),
                  child: Column(
                    crossAxisAlignment: bubbleAlignment == Alignment.centerRight
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (message.isNotEmpty && !isDateRecord)
                        MessageText(
                          key: UniqueKey(),
                          message: message,
                          records: records,
                          isOnSearchPage: isOnSearchPage,
                        ),
                      if (isDateRecord)
                        Text(
                          message,
                          textAlign: TextAlign.center,
                        ),
                      if (!isDateRecord)
                        RecordInfoRow(
                          bubbleAlignment: bubbleAlignment,
                          isFavorite: isFavorite,
                          recordCreateDateTime: createDateTime,
                        ),
                      if (!isDateRecord && withCategory)
                        RecordCategoryName(
                          categoryName: categoryName,
                          categoryId: categoryId,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
