import 'package:college_page/model/college_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/theme/app_color.dart';
import 'package:college_page/model/chat_room.dart';

class ChatRoomWidget extends StatefulWidget {
  final CollegeModel collegeModel;

  ChatRoomWidget({required this.collegeModel});

  @override
  State<ChatRoomWidget> createState() => _ChatRoomWidgetState();
}

class _ChatRoomWidgetState extends State<ChatRoomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(""),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/collegeprofile');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.collegeModel.collegeName,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "d",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: Icon(
                        Icons.call_outlined,
                        color: Theme.of(context).textTheme.button?.color,
                      ),
                      label: Text(
                        "Call",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text("View Profile"),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     reverse: true,
            //     padding: const EdgeInsets.all(24),
            //     itemCount: 1,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Align(
            //             alignment: Alignment.center,
            //             child: Container(
            //               padding: const EdgeInsets.symmetric(
            //                 horizontal: 16,
            //                 vertical: 8,
            //               ),
            //               margin: const EdgeInsets.symmetric(
            //                 vertical: 8,
            //               ),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(16),
            //                 color: AppColor.primaryColor.withOpacity(0.1),
            //               ),
            //               child: Text(
            //                 "fds",
            //                 style: Theme.of(context).textTheme.bodySmall,
            //               ),
            //             ),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.symmetric(
            //     horizontal: 24,
            //     vertical: 16,
            //   ),
            //   padding: const EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     border: Border.all(
            //       color: Theme.of(context).dividerColor,
            //     ),
            //   ),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       IconButton(
            //         onPressed: () {},
            //         splashRadius: 20,
            //         icon: const Icon(
            //           Icons.emoji_emotions_outlined,
            //           size: 20,
            //         ),
            //       ),
            //       const SizedBox(width: 4),
            //       IconButton(
            //         onPressed: () {},
            //         splashRadius: 20,
            //         icon: const Icon(
            //           CupertinoIcons.photo,
            //           size: 20,
            //         ),
            //       ),
            //       const SizedBox(width: 8),
            //       Expanded(
            //         child: TextField(
            //           minLines: 1,
            //           maxLines: 5,
            //           decoration: const InputDecoration(
            //             border: InputBorder.none,
            //             hintText: "Message....",
            //           ),
            //           style: Theme.of(context).textTheme.bodyMedium,
            //         ),
            //       ),
            //       const SizedBox(width: 4),
            //       IconButton(
            //         onPressed: () {},
            //         splashRadius: 20,
            //         icon: const Icon(
            //           CupertinoIcons.paperplane,
            //           size: 20,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class MyChat extends StatelessWidget {
  const MyChat({super.key, this.chat});

  final Chat? chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
            color: AppColor.primaryColor,
          ),
          child: Text(
            chat?.message ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColor.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${chat?.messageTimestamp.hour ?? "-"}:${chat?.messageTimestamp.minute ?? "-"}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.done_all,
                size: 18,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class OthersChat extends StatelessWidget {
  const OthersChat({super.key, this.chat});

  final Chat? chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: AppColor.primaryColor.withOpacity(0.2),
          ),
          child: Text(
            chat?.message ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 16),
          child: Text(
            "${chat?.messageTimestamp.hour ?? "-"}:${chat?.messageTimestamp.minute ?? "-"}",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
