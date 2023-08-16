import 'package:college_page/model/user_model.dart';
import 'package:college_page/widget/desktop/home_desktop_header.dart';
import 'package:college_page/widget/mobile/home_mobile_header.dart';
import 'package:college_page/widget/user_profile/friends_widget.dart';
import 'package:college_page/widget/user_profile/user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/component/widgets/responsive_screen.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.selectedUser,});

  final UserModel selectedUser;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ResponsiveScreen(
        mobile: MobileLayout(selectedUser: selectedUser,),
        tablet: TabletLayout(selectedUser: selectedUser,),
        dekstop: DesktopLayout(selectedUser: selectedUser,),
      ),
    );
  }
}

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key, required this.selectedUser,});

  final UserModel selectedUser;

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeMobileHeader(),
        Expanded(
          child: UserProfileWidget(selectedUser: widget.selectedUser,),
        ),
      ],
    );
  }
}

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key, required this.selectedUser,});

  final UserModel selectedUser;

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
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
              children:  [
                Expanded(
                  flex: 4,
                  child: UserProfileWidget(selectedUser: widget.selectedUser,),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: FriendsWidget(userDoc: widget.selectedUser,),
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
  const TabletLayout({super.key, required this.selectedUser,});

  final UserModel selectedUser;
  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
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
              children:  [
                Expanded(
                  flex: 3,
                  child: UserProfileWidget(selectedUser: widget.selectedUser,),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 4,
                  child: FriendsWidget(userDoc: widget.selectedUser,),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
