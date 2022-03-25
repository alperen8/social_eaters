import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:social_eaters/models/place_model.dart';

import '/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  const PlaceCard({
    Key? key,
    required this.place,
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
            //WHEN THERE IS LOCATION INFO THEN THIS ICON WILL BE BLUE
            Row(
              children: [
                place.latitude == null
                    ? const Icon(Icons.place)
                    : const Icon(
                        Icons.place,
                        color: Colors.blue,
                      ),
                Text(place.name ?? ""),
              ],
            ),
            //USER COMMENT
            buildMessage(context),
            //BUTTON TO OPEN MENU
            IconButton(
                onPressed: () {
                  _launchURL(context);
                },
                icon: const Icon(Icons.menu_book)),
            //USER NAME WHEN THERE IS USER(WHEN IT COMES FROM DB IT HAS A USER FIELD FILLED)
            if (place.user != null) Text(place.user!.name!),
            //DATE FIELD
            Text(place.dateVisited.toString())
          ],
        ),
      ),
    );
  }

  Column buildMessage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (place.userComment != null && place.userComment != "")
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(place.userComment!)),
        context.emptySizedWidthBoxLow,
      ],
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    launch(
      place.menuUrl,
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
