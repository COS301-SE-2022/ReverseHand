import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';
import 'models/advert_model.dart';
import 'models/bid_model.dart';
import 'models/error_type_model.dart';
import 'models/user_models/user_model.dart';
import 'models/user_models/partial_user_model.dart';

@immutable
class AppState {
  // put all app state requiered here
  final UserModel? userDetails;
  final PartialUser? partialUser;
  final List<BidModel> bids; // holds all of the bids i.e viewBids ⊆ bids
  final List<BidModel> shortlistBids;
  final List<BidModel> viewBids; // holds the list of bids to view
  final List<AdvertModel> adverts;
  final BidModel?
      activeBid; // represents the current bid, used for viewing a bid
  final AdvertModel? activeAd; // used for representing the current ad
  // both will change throughout the app
  final List<Suggestion> suggestions;
  final ErrorType error;
  final bool change; // used to show that state changed and must rebuild

//  AppState : {
  // 	user_id : String
  // 	user_details : {
  //  email : String
  //  name : String
  //  cellNo : String
  //  location : Location
  //  domains : [String]
  //  tradeType : [String]
  //  }
  // 	partial_user : {
  //  email : String
  //  password : String
  //  verified : String
  //  group : Location
  //  }
  // 	adverts: []
  // 	bids : []
  // 	shortlisted_bids : [Bid]
  // 	active_ad : Advert
  // 	active_bid : Bid
  // 	suggestions : [Suggestion]
  // 	result : Place
  // 	error : ErrorType
  // 	loading : Bool
//  }

  // constructor must only take named parameters
  const AppState({
    required this.userDetails,
    required this.partialUser,
    required this.adverts,
    required this.bids,
    required this.shortlistBids,
    required this.viewBids,
    required this.activeAd,
    required this.activeBid,
    required this.suggestions,
    required this.error,
    required this.change,
  });

  // this methods sets the starting state for the store
  factory AppState.initial() {
    return const AppState(
      userDetails: UserModel(id: "", userType: ""),
      partialUser: PartialUser(email: "", group: "", verified: ""),
      adverts: [],
      bids: [],
      shortlistBids: [],
      viewBids: [],
      activeAd: AdvertModel(id: "", title: "", location: "", dateCreated: ""),
      activeBid: BidModel(
          id: "", userId: "", priceLower: 0, priceUpper: 0, dateCreated: ""),
      suggestions: [],
      error: ErrorType.none,
      change: false,
    );
  }

  factory AppState.mock() {
    return const AppState(
      userDetails: UserModel(
        id: "0",
        email: "some@email.com",
        name: "Someone",
        cellNo: "0821234567",
        userType: "confirmed",
      ),
      partialUser: null,
      adverts: [],
      bids: [],
      shortlistBids: [],
      viewBids: [],
      activeAd: null,
      activeBid: null,
      suggestions: [],
      error: ErrorType.none,
      change: false,
    );
  }
  // easy way to replace store wihtout specifying all paramters
  AppState replace({
    UserModel? userDetails,
    PartialUser? partialUser,
    List<AdvertModel>? adverts,
    List<BidModel>? bids,
    List<BidModel>? shortlistBids,
    List<BidModel>? viewBids,
    BidModel? activeBid,
    AdvertModel? activeAd,
    List<Suggestion>? suggestions,
    ErrorType? error,
    bool? loading,
    bool? change,
  }) {
    return AppState(
      userDetails: userDetails ?? this.userDetails,
      partialUser: partialUser ?? this.partialUser,
      adverts: adverts ?? this.adverts,
      bids: bids ?? this.bids,
      shortlistBids: shortlistBids ?? this.shortlistBids,
      viewBids: viewBids ?? this.viewBids,
      activeAd: activeAd ?? this.activeAd,
      activeBid: activeBid ?? this.activeBid,
      suggestions: suggestions ?? this.suggestions,
      error: error ?? this.error,
      change: change ?? this.change,
    );
  }
}
