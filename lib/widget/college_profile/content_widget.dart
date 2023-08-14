import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/extension/date_time_extension.dart';
import 'package:college_page/core/theme/app_color.dart';
import 'package:college_page/model/chat_room.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    this.showBackButton = false,
  });

  final bool showBackButton;

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
                  if (showBackButton) ...[
                    IconButton(
                      onPressed: () {
                        // Implement your back button logic
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                      ),
                      splashRadius: 20,
                    ),
                    const SizedBox(width: 16),
                  ],
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/mit.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "College Names",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "@college.ac.in",
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
                        "Join",
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
                      child: const Text("Chat"),
                    ),
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
