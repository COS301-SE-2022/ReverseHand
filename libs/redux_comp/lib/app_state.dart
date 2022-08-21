import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/admin/admin_model.dart';
import 'package:redux_comp/models/chat/chat_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/models/review_model.dart';
import 'models/advert_model.dart';
import 'models/bid_model.dart';
import 'models/error_type_model.dart';
import 'models/geolocation/location_model.dart';
import 'models/user_models/cognito_auth_model.dart';
import 'models/user_models/user_model.dart';
import 'models/user_models/partial_user_model.dart';

@immutable
class AppState {
  // put all app state requiered here
  final CognitoAuthModel? authModel;
  final UserModel? userDetails;
  final PartialUser? partialUser;
  final List<BidModel> bids; // holds all of the bids i.e viewBids ⊆ bids
  final List<BidModel> shortlistBids;
  final List<BidModel> viewBids; // holds the list of bids to view
  final List<AdvertModel> adverts;
  final List<AdvertModel> viewAdverts;
  final BidModel?
      activeBid; // represents the current bid, used for viewing a bid
  final AdvertModel? activeAd; // used for representing the current ad
  final Location? locationResult;
  // both will change throughout the app
  final ErrorType error;
  final bool change; // used to show that state changed and must rebuild
  final Wait wait; // for progress indicators
  final List<ReviewModel> reviews; //holds the list of a users reviews.

  // chat functionality
  final List<ChatModel> chats; // all chats
  final ChatModel chat; // the current active chat

  //admin functionality
  final AdminModel admin;

  // constructor must only take named parameters
  const AppState({
    required this.authModel,
    required this.userDetails,
    required this.partialUser,
    required this.adverts,
    required this.viewAdverts,
    required this.bids,
    required this.shortlistBids,
    required this.viewBids,
    required this.activeAd,
    required this.activeBid,
    required this.locationResult,
    required this.error,
    required this.change,
    required this.wait,
    required this.chats,
    required this.chat,
    required this.reviews,
    required this.admin,
  });

  // this methods sets the starting state for the store
  factory AppState.initial() {
    return AppState(
      authModel: null,
      userDetails: const UserModel(
          id: "", email: "", userType: "", externalProvider: false),
      partialUser: const PartialUser(email: "", group: "", verified: ""),
      adverts: const [],
      viewAdverts: const [],
      bids: const [],
      shortlistBids: const [],
      viewBids: const [],
      reviews: const [],
      activeAd: const AdvertModel(
        id: "",
        title: "",
        domain:
            Domain(city: "city", coordinates: Coordinates(lat: 22, lng: 21)),
        dateCreated: 0,
      ),
      activeBid: const BidModel(
        id: "",
        userId: "",
        priceLower: 0,
        priceUpper: 0,
        dateCreated: "",
      ),
      locationResult: null,
      error: ErrorType.none,
      change: false,
      wait: Wait(),
      chats: const [],
      chat: const ChatModel(
        consumerName: "",
        tradesmanName: "",
        consumerId: "",
        tradesmanId: "",
        messages: [],
      ),
      admin: const AdminModel(reportedCustomers: []),
    );
  }

  factory AppState.mock() {
    return AppState(
      userDetails: const UserModel(
        id: "0",
        email: "some@email.com",
        name: "Someone",
        cellNo: "0821234567",
        userType: "customer",
        externalProvider: false,
      ),
      wait: Wait(),
      authModel: null,
      partialUser: null,
      adverts: const [],
      viewAdverts: const [],
      bids: const [],
      shortlistBids: const [],
      viewBids: const [],
      reviews: const [],
      activeAd: null,
      activeBid: null,
      locationResult: null,
      error: ErrorType.none,
      change: false,
      chats: const [],
      chat: const ChatModel(
        consumerName: "",
        tradesmanName: "",
        consumerId: "",
        tradesmanId: "",
        messages: [],
      ),
      admin: const AdminModel(reportedCustomers: []),
    );
  }
  // easy way to replace store wihtout specifying all paramters
  AppState copy({
    CognitoAuthModel? authModel,
    UserModel? userDetails,
    PartialUser? partialUser,
    List<AdvertModel>? adverts,
    List<AdvertModel>? viewAdverts,
    List<BidModel>? bids,
    List<BidModel>? shortlistBids,
    List<BidModel>? viewBids,
    List<ReviewModel>? reviews,
    BidModel? activeBid,
    AdvertModel? activeAd,
    Location? locationResult,
    ErrorType? error,
    bool? loading,
    bool? change,
    Wait? wait,
    List<ChatModel>? chats,
    ChatModel? chat,
    AdminModel? admin
  }) {
    return AppState(
      authModel: authModel ?? this.authModel,
      userDetails: userDetails ?? this.userDetails,
      partialUser: partialUser ?? this.partialUser,
      adverts: adverts ?? this.adverts,
      viewAdverts: viewAdverts ?? this.viewAdverts,
      bids: bids ?? this.bids,
      reviews: reviews ?? this.reviews,
      shortlistBids: shortlistBids ?? this.shortlistBids,
      viewBids: viewBids ?? this.viewBids,
      activeAd: activeAd ?? this.activeAd,
      activeBid: activeBid ?? this.activeBid,
      locationResult: locationResult ?? this.locationResult,
      error: error ?? this.error,
      change: change ?? this.change,
      wait: wait ?? this.wait,
      chats: chats ?? this.chats,
      chat: chat ?? this.chat,
      admin: admin ?? this.admin,
    );
  }
}
