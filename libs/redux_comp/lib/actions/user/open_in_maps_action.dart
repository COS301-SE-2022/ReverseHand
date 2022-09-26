import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

// opens the maps app to the specified location of the current ad
class OpenInMapsAction extends ReduxAction<AppState> {
  final BuildContext context;

  OpenInMapsAction(this.context);

  @override
  Future<AppState?> reduce() async {
    try {
      final Coordinates adCoords = state.activeAd!.domain.coordinates;
      final Coords coords = Coords(adCoords.lat, adCoords.lng);
      final String advertTitle = state.activeAd!.title;
      final List<AvailableMap> maps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  for (final AvailableMap map in maps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coords,
                        title: advertTitle,
                      ),
                      title: Text(
                        map.mapName,
                        style: const TextStyle(color: Colors.black),
                      ),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }

    return null;
  }
}
