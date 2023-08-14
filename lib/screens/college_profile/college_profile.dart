import 'package:college_page/widget/college_profile/college_members.dart';
import 'package:college_page/widget/college_profile/content_widget.dart';
import 'package:college_page/widget/desktop/home_desktop_header.dart';
import 'package:college_page/widget/mobile/home_mobile_header.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/component/widgets/responsive_screen.dart';

class CollegeProfile extends StatelessWidget {
  const CollegeProfile({super.key});

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
    // final state = // Get your ChatRoomsCubit state or initialize it

    // if (state.selectedChatRoom != null) {
    //   return const ChatRoomWidget(showBackButton: true);
    // }

    return Column(
      children: const [
        HomeMobileHeader(),
        Expanded(
          child: ContentWidget(),
        ),
      ],
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeDesktopHeader(),
        // Padding(
        //   padding: const EdgeInsets.only(top: 24, left: 24),
        //   child: Text(
        //     "Colleges",
        //     style: Theme.of(context).textTheme.titleLarge,
        //   ),
        // ),
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
              children: const [
                Expanded(
                  flex: 4,
                  child: ContentWidget(),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: CollegeMembersWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeDesktopHeader(),
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
              children: const [
                Expanded(
                  flex: 3,
                  child: ContentWidget(),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 4,
                  child: CollegeMembersWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
