import 'package:async_redux/async_redux.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';

class RankAdvertsAction extends ReduxAction<AppState> {
  //Default constructor for now
  RankAdvertsAction();

  @override
  Future<AppState?> reduce() async {
    //mew list with updated advertRank
    List<AdvertModel> adverts = [];
    double ranking = 0.0;

    //First rank the adverts
    for (AdvertModel advert in state.viewAdverts) {
      ranking += _rankTitle(advert);
      ranking += _photoRank(advert);
      ranking += _rankDescription(advert);
      ranking += _rankDateCreated(advert);

      //create a new advert with updated rank
      AdvertModel ad = advert.copy(
        id: advert.id,
        title: advert.title,
        description: advert.description,
        type: advert.type,
        acceptedBid: advert.acceptedBid,
        domain: advert.domain,
        dateCreated: advert.dateCreated,
        dateClosed: advert.dateClosed,
        advertRank: ranking,
      );
      adverts.add(ad);
      //reset the counter
      ranking = 0.0;
    }
    //Now have to sort the adverts based on the rank.
    adverts = _sortAdverts(adverts);

    return state.copy(viewAdverts: adverts);
  }

  double _rankTitle(AdvertModel advert) {
    List<String>? tradeTypes = state.userDetails?.tradeTypes;
    double ranking = 0;

    //First check if the title contains the tradetype of a tradesman
    for (String trade in tradeTypes!) {
      // if ((advert.title.toLowerCase()).contains(trade.toLowerCase())) {
      if ((trade.toLowerCase()).contains(advert.title.toLowerCase())) {
        ranking += 2;
        break; //exit on first match
      }
    }

    //Next check if there is more than one word in the title
    String title = advert.title.trim(); //remove leading and trailing whitespace
    final splitted = title.split(' '); //get words delimited by space

    if (splitted.length > 1) {
      ranking += 1;
    }

    //Next check the length of the title
    if (title.length > 12 && title.length < 25) {
      ranking += 1;
    }

    return ranking;
  }

  double _photoRank(AdvertModel advert) {
    return 0.0; //stub for now
  }

  double _rankDescription(AdvertModel advert) {
    String description = advert.description!.trim();
    double ranking = 0;

    if (description.length < 100 && description.length > 50) {
      ranking += 1;
    }

    //check if description has any possible numbers that might be used
    //as a hint for dimensions provided.
    if (description.contains(RegExp(r'[0-9]'))) {
      ranking += 1;
    }

    return ranking;
  }

  double _rankDateCreated(AdvertModel advert) {
    double ranking = 0;
    int sevenDay = 604800; //time in seconds
    //example format of date: 27-08-2022

    //get the current date as a unix timestamp
    double currrentDate = (DateTime.now().millisecondsSinceEpoch / 1000);

    if (((advert.dateCreated) / 1000) + sevenDay < currrentDate) {
      ranking += 1;
    } else {
      ranking += 2;
    }

    return ranking;
  }

  List<AdvertModel> _sortAdverts(List<AdvertModel> adverts) {
    adverts.sort((a, b) => b.advertRank!.compareTo(a.advertRank!));
    return adverts;
  }
}

/**
 * A maximum rating of 10 can be achieved.
 * 
 * Ratings are based on Title, Description, Photo and Date created
 * Title = 4 points max, Description = 2 points max
 * Photo = 2 points max, Date Created = 2 points max
 * 
 * Title: Check the following:
 * (a). Length of title: 12 < chars < 25 gets 1 else 0 point
 * (b). More than one word in the Title i.e descriptive Title. 1 point
 * (c). Title contains tradetype of tradesman 2 points
 * 
 * Description: Check the following:
 * (a). Length of the Description. 1 point if 50<length<100
 * (b). Presence of any numbers that could potentially be dimensions or quantity
 *      1 point for this.
 * 
 * Photo: 
 * (a). Presence of Photo equals 2 points straight
 * 
 * Date Created: 
 * (a). Adverts older than 7 days get points else 1 point.
 */

/*
    *Example code on how to sort a list 
final numbers = <String>['one', 'two', 'three', 'four'];
numbers.sort((a, b) => a.length.compareTo(b.length));
print(numbers); // [one, two, four, three] OR [two, one, four, three]
*/
