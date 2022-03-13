import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

import '/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String placeName;
  final String userComment;
  final DateTime dateCreated;
  final String menuUrl;

  const PlaceCard({
    Key? key,
    required this.placeName,
    required this.userComment,
    required this.dateCreated,
    required this.menuUrl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Container(
        padding: context.paddingLow,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ], color: Colors.white, borderRadius: context.lowBorderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.place),
                Text(placeName),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: buildMessage(context),
            ),
            Text(dateCreated.toString())
          ],
        ),
      ),
    );
  }

  Row buildMessage(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(userComment)),
        context.emptySizedWidthBoxLow,
        IconButton(
            onPressed: () {
              _launchURL(context);
            },
            icon: const Icon(Icons.menu_book))
      ],
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    launch(
      menuUrl,
      customTabsOption: CustomTabsOption(
        toolbarColor: Theme.of(context).primaryColor,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        extraCustomTabs: const <String>[
          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
          'org.mozilla.firefox',
          // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
          'com.microsoft.emmx',
        ],
      ),
      safariVCOption: SafariViewControllerOption(
        preferredBarTintColor: Theme.of(context).primaryColor,
        preferredControlTintColor: Colors.white,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      ),
    );
  }
}
