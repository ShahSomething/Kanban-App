import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/core/extensions/context.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BoardView();
  }
}

class BoardView extends StatefulWidget {
  const BoardView({super.key});

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  late AppFlowyBoardController boardController;
  late AppFlowyBoardScrollController boardScrollController;

  @override
  void initState() {
    boardController = AppFlowyBoardController(
      onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        debugPrint('Move item from $fromIndex to $toIndex');
      },
      onMoveGroupItem: (groupId, fromIndex, toIndex) {
        debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
      },
      onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
      },
    );
    boardScrollController = AppFlowyBoardScrollController();

    final group1 = AppFlowyGroupData(
      id: '1',
      name: 'Todo',
      items: [
        TextItem('Card 1'),
        TextItem('Card 2'),
        RichTextItem(title: 'Card 3', subtitle: 'Aug 1, 2020 4:05 PM'),
        TextItem('Card 4'),
        TextItem('Card 5'),
      ],
    );
    final group2 = AppFlowyGroupData(
      id: '2',
      name: 'In Progress',
      items: <AppFlowyGroupItem>[
        TextItem('Card 6'),
        RichTextItem(title: 'Card 7', subtitle: 'Aug 1, 2020 4:05 PM'),
        RichTextItem(title: 'Card 8', subtitle: 'Aug 1, 2020 4:05 PM'),
      ],
    );

    final group3 = AppFlowyGroupData(
      id: '3',
      name: 'Done',
      items: [],
    );

    boardController
      ..addGroup(group1)
      ..addGroup(group2)
      ..addGroup(group3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: context.secondaryColor.withOpacity(0.7),
      boardCornerRadius: 20.r,
      groupCornerRadius: 20.r,
      groupFooterPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Board'),
        backgroundColor: context.secondaryColor.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 50.h,
          bottom: context.bottomBarHeight + 40.h,
        ),
        child: AppFlowyBoard(
          controller: boardController,
          cardBuilder: (context, group, groupItem) {
            return AppFlowyGroupCard(
              key: ValueKey(groupItem.id),
              decoration: BoxDecoration(
                color: context.backgroundColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: _buildCard(groupItem),
            );
          },
          boardScrollController: boardScrollController,
          headerBuilder: (context, columnData) {
            return AppFlowyGroupHeader(
              icon: Text(
                getEmoji(
                  columnData.headerData.groupId,
                ),
              ),
              title: Flexible(
                fit: FlexFit.tight,
                child: Text(
                  textAlign: TextAlign.center,
                  columnData.headerData.groupName,
                  style: context.label20700,
                ),
              ),
              addIcon: Icon(Icons.add, size: 20.r),
              //moreIcon: Icon(Icons.more_horiz, size: 20.r),
              height: 60.h,
              margin: config.groupFooterPadding,
            );
          },
          groupConstraints: BoxConstraints.tightFor(width: 0.8.sw),
          config: config,
        ),
      ),
    );
  }

  String getEmoji(String status) {
    switch (status) {
      case '1':
        return '🔴';
      case '2':
        return '🧑🏻‍💻';
      case '3':
        return '✅';
      default:
        return '';
    }
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is TextItem) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Text(
            item.s,
            style: context.label12500.copyWith(),
          ),
        ),
      );
    }

    if (item is RichTextItem) {
      return RichTextCard(item: item);
    }

    throw UnimplementedError();
  }
}

class RichTextCard extends StatefulWidget {
  final RichTextItem item;
  const RichTextCard({
    required this.item,
    super.key,
  });

  @override
  State<RichTextCard> createState() => _RichTextCardState();
}

class _RichTextCardState extends State<RichTextCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.title,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              widget.item.subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class TextItem extends AppFlowyGroupItem {
  final String s;

  TextItem(this.s);

  @override
  String get id => s;
}

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String subtitle;

  RichTextItem({required this.title, required this.subtitle});

  @override
  String get id => title;
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
