import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:intl/intl.dart';
import 'package:social_eaters/models/place_model.dart';
import 'package:social_eaters/services/local_storage.dart';
import 'package:social_eaters/services/user_service.dart';
import '/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class PlaceCard extends StatefulWidget {
  final Place place;

  const PlaceCard({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    isFavorite = LocalStorage.instance.isItemOnTheFavoriteList(widget.place.id);
  }

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
                widget.place.latitude == null
                    ? const Icon(Icons.place)
                    : const Icon(
                        Icons.place,
                        color: Colors.blue,
                      ),
                Text(widget.place.name ?? ""),
              ],
            ),
            //USER COMMENT
            buildMessage(context),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (isFavorite) {
                      UserService.instance
                          .deletePlaceFromFavorites(widget.place.id);
                    } else {
                      UserService.instance.addPlaceToFavorites(widget.place.id);
                    }

                    //TODO THIS WILL BE DONE IN CONDITIONAL BLOCKS ACCORDING TO STATUS NOW IT WORKS ANYWAY

                    isFavorite = !isFavorite;

                    //TODO ADD TOAST THAT SAYS ADDED TO FAVS HERE
                  });
                },
                icon: isFavorite
                    ? const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    : const Icon(Icons.star_border_outlined)),
            //BUTTON TO OPEN MENU
            IconButton(
                onPressed: () {
                  _launchURL(context);
                },
                icon: const Icon(Icons.menu_book)),
            //USER NAME WHEN THERE IS USER(WHEN IT COMES FROM DB IT HAS A USER FIELD FILLED)
            if (widget.place.user != null) Text(widget.place.user!.name!),
            //DATE FIELD
            Text(DateFormat.yMMMMd().format(widget.place.dateVisited))
          ],
        ),
      ),
    );
  }

  Column buildMessage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (widget.place.userComment != null && widget.place.userComment != "")
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(widget.place.userComment!)),
        context.emptySizedWidthBoxLow,
      ],
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    launch(
      widget.place.menuUrl,
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
