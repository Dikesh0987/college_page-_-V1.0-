import 'package:college_page/model/college_model.dart';
import 'package:college_page/model/user_model.dart';
import 'package:college_page/screens/user_profile/user_profile.dart';
import 'package:college_page/widget/desktop/home_desktop_header.dart';
import 'package:college_page/widget/home/members_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/component/widgets/responsive_screen.dart';
import 'package:college_page/widget/home/chat_room_widget.dart';
import 'package:college_page/widget/home/chats_widget.dart';
import 'package:college_page/widget/mobile/home_mobile_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return const Scaffold(
      body: ResponsiveScreen(
        mobile: MobileLayout(),
        tablet: TabletLayout(),
        dekstop: DesktopLayout(),
      ),
    );
  }
}

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  CollegeModel? _selectedCollege;

  void _handleChatButtonClicked(CollegeModel college) {
    setState(() {
      _selectedCollege = college; // Store the received CollegeModel
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeMobileHeader(),
        Expanded(
          child: ChatsWidget(
            onChatButtonClicked: _handleChatButtonClicked,
          ),
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
  CollegeModel? _selectedCollege, _selectedCollegeMember;
  UserModel? _selectedUser, _selectedUserMember;

  void _handleChatButtonClicked(CollegeModel college) {
    setState(() {
      _selectedCollege = college;
      _selectedCollegeMember = college; // Store the received CollegeModel
    });
  }

  void _handlefriendButtonClicked(UserModel user) {

    Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfile(selectedUser: user,

    )));


    setState(() {
      _selectedUser = user;
    });
  }

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
              children: [
                Expanded(
                  flex: 3,
                  child: ChatsWidget(
                    onChatButtonClicked: _handleChatButtonClicked,
                  ),
                ),
                const VerticalDivider(),
                if (_selectedCollege != null)
                  Expanded(
                    flex: 4,
                    child: ChatRoomWidget(
                      collegeModel: _selectedCollege!,
                    ),
                  ),
                const VerticalDivider(),
                if (_selectedCollege != null)
                  Expanded(
                    flex: 2,
                    child: _selectedCollegeMember != null
                        ? MembersWidget(
                            collegeModel: _selectedCollegeMember,
                            onFriendButtonClicked: _handlefriendButtonClicked,
                          
                          )
                        : CircularProgressIndicator(),
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
  CollegeModel? _selectedCollege;

  void _handleChatButtonClicked(CollegeModel college) {
    setState(() {
      _selectedCollege = college; // Store the received CollegeModel
    });
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
                  flex: 3,
                  child: ChatsWidget(
                    onChatButtonClicked: _handleChatButtonClicked,
                  ),
                ),
                VerticalDivider(),
                if (_selectedCollege != null)
                  Expanded(
                    flex: 4,
                    child: ChatRoomWidget(
                      collegeModel: _selectedCollege!,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
