import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
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
  final ErrorType error;
  final bool change; // used to show that state changed and must rebuild
  final Wait wait; // for progress indicators

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
    required this.error,
    required this.change,
    required this.wait,
  });

  // this methods sets the starting state for the store
  factory AppState.initial() {
    return AppState(
      userDetails: const UserModel(id: "", email: "", userType: ""),
      partialUser: const PartialUser(email: "", group: "", verified: ""),
      adverts: const [],
      bids: const [],
      shortlistBids: const [],
      viewBids: const [],
      activeAd:
          const AdvertModel(id: "", title: "", location: "", dateCreated: ""),
      activeBid: const BidModel(
        id: "",
        userId: "",
        priceLower: 0,
        priceUpper: 0,
        dateCreated: "",
      ),
      error: ErrorType.none,
      change: false,
      wait: Wait(),
    );
  }

  factory AppState.mock() {
    return AppState(
      userDetails: const UserModel(
        id: "0",
        email: "some@email.com",
        name: "Someone",
        cellNo: "0821234567",
        userType: "confirmed",
      ),
      wait: Wait(),
      partialUser: null,
      adverts: const [],
      bids: const [],
      shortlistBids: const [],
      viewBids: const [],
      activeAd: null,
      activeBid: null,
      error: ErrorType.none,
      change: false,
    );
  }
  // easy way to replace store wihtout specifying all paramters
  AppState copy({
    UserModel? userDetails,
    PartialUser? partialUser,
    List<AdvertModel>? adverts,
    List<BidModel>? bids,
    List<BidModel>? shortlistBids,
    List<BidModel>? viewBids,
    BidModel? activeBid,
    AdvertModel? activeAd,
    ErrorType? error,
    bool? loading,
    bool? change,
    Wait? wait,
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
      error: error ?? this.error,
      change: change ?? this.change,
      wait: wait ?? this.wait,
    );
  }
}
