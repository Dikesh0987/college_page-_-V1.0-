import 'package:college_page/widget/home/chat_room_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/extension/date_time_extension.dart';
import 'package:college_page/core/theme/app_color.dart';
import 'package:college_page/model/chat_room.dart';

class CollegesWidget extends StatelessWidget {
  const CollegesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Find Colleges",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(CupertinoIcons.search),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: dummyChatRoom.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
            ),
            itemBuilder: (context, index) {
              return ChatRoomItem(
                room: dummyChatRoom[index],
                isSelected: false, // Set isSelected as appropriate
              );
            },
          ),
        )
      ],
    );
  }
}

class ChatRoomItem extends StatelessWidget {
  const ChatRoomItem({
    super.key,
    required this.room,
    required this.isSelected,
  });

  final ChatRoom room;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/collegeprofile');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor.withOpacity(0.05) : null,
        ),
        foregroundDecoration: BoxDecoration(
          border: isSelected
              ? Border(
                  left: BorderSide(
                    color: AppColor.primaryColor,
                    width: 4,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Visibility(
              visible: room.hasUnreadMessage,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: Stack(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    room.picture,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (room.isOnline)
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              room.name,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              room.username,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(CupertinoIcons.add),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
