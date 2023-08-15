import 'package:college_page/widget/colleges/colleges_widget.dart';
import 'package:college_page/widget/desktop/home_desktop_header.dart';
import 'package:college_page/widget/home/chats_widget.dart';
import 'package:college_page/widget/home/members_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/component/widgets/responsive_screen.dart';
import 'package:college_page/widget/home/chat_room_widget.dart';
import 'package:college_page/widget/mobile/home_mobile_header.dart';

class CollegesScreen extends StatefulWidget {
  const CollegesScreen({super.key});

  @override
  State<CollegesScreen> createState() => _CollegesScreenState();
}

class _CollegesScreenState extends State<CollegesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveScreen(
        mobile: MobileLayout(),
        tablet: TabletLayout(),
        dekstop: DesktopLayout(),
      ),
    );
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HomeMobileHeader(),
        Expanded(
          child: CollegesWidget(),
        ),
      ],
    );
  }
}

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  void _rebuildChatRoom() {
    setState(() {}); // Trigger a rebuild of the ChatRoomWidget
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeDesktopHeader(),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24),
          child: Text(
            "Colleges",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ChatsWidget(onChatButtonClicked: (String ) {  },
                 
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 4,
                  child: CollegesWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TabletLayout extends StatefulWidget {
  const TabletLayout({super.key});

  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
  @override
  Widget build(BuildContext context) {
    void _rebuildChatRoom() {
      setState(() {}); // Trigger a rebuild of the ChatRoomWidget
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeDesktopHeader(),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24),
          child: Text(
            "Colleges",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ChatsWidget(onChatButtonClicked: (String ) {  },),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 4,
                  child: CollegesWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
