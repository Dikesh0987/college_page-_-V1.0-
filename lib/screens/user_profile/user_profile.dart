import 'package:college_page/widget/desktop/home_desktop_header.dart';
import 'package:college_page/widget/mobile/home_mobile_header.dart';
import 'package:college_page/widget/user_profile/friends_widget.dart';
import 'package:college_page/widget/user_profile/user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/component/widgets/responsive_screen.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

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
          child: UserProfileWidget(),
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
        HomeDesktopHeader(),
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
                  child: UserProfileWidget(),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: FriendsWidget(),
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
              children: const [
                Expanded(
                  flex: 3,
                  child: UserProfileWidget(),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 4,
                  child: FriendsWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
