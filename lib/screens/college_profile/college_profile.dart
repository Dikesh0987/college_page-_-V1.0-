import 'package:college_page/model/college_model.dart';
import 'package:college_page/widget/college_profile/college_members.dart';
import 'package:college_page/widget/college_profile/content_widget.dart';
import 'package:college_page/widget/desktop/home_desktop_header.dart';
import 'package:college_page/widget/mobile/home_mobile_header.dart';
import 'package:flutter/material.dart';
import 'package:college_page/core/component/widgets/responsive_screen.dart';

class CollegeProfile extends StatelessWidget {
  final CollegeModel collegeModel;

  CollegeProfile({super.key, required this.collegeModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveScreen(
        mobile: MobileLayout(collegeModel: collegeModel),
        tablet: TabletLayout(collegeModel: collegeModel),
       dekstop: DesktopLayout(collegeModel: collegeModel),
      ),
    );
  }
}

class MobileLayout extends StatelessWidget {
  final CollegeModel collegeModel;

  const MobileLayout({super.key, required this.collegeModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeMobileHeader(),
        Expanded(
          child: ContentWidget(
            collegeDoc: collegeModel,
          ),
        ),
      ],
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, required this.collegeModel});

  final CollegeModel collegeModel;

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
                  flex: 4,
                  child: ContentWidget(
                    collegeDoc: collegeModel,
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: CollegeMembersWidget(collegeDoc: collegeModel,),
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
  final CollegeModel collegeModel;

  const TabletLayout({super.key, required this.collegeModel});

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
                  child: ContentWidget(
                    collegeDoc: collegeModel,
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 4,
                          child: CollegeMembersWidget(collegeDoc: collegeModel,),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
