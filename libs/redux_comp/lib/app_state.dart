import 'dart:async';
import 'dart:io';
import 'package:amplify_api/amplify_api.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/admin/admin_model.dart';
import 'package:redux_comp/models/chat/chat_model.dart';
import 'package:redux_comp/models/chat/message_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/models/review_model.dart';
import 'package:redux_comp/models/user_models/notification_model.dart';
import 'package:redux_comp/models/user_models/statistics_model.dart';
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
  final List<File> advertImages; // images for an advert

  final Location? locationResult;
  // both will change throughout the app
  final ErrorType error;
  final bool change; // used to show that state changed and must rebuild
  final Wait wait; // for progress indicators
  final List<ReviewModel> reviews; //holds the list of a users reviews.
  final int sum; //this represents the sum of a users reviews
  final List<String> advertsWon; //adverts tradesman won.

  // chat functionality
  final List<ChatModel> chats; // all chats
  final ChatModel? chat; // the current active chat if null than no active chat
  final List<MessageModel>
      messages; // list of messages for current active chats
  final StreamSubscription<GraphQLResponse<dynamic>>?
      messageSubscription; // subscription to keep track fo messages

  //admin functionality
  final AdminModel admin;

  // images
  final File? userProfileImage;

  // paystack keys
  final String paystackSecretKey;
  final String paystackPublicKey;

  final List<NotificationModel> notifications;

  // constructor must only take named parameters
  const AppState({
    required this.authModel,
    required this.userDetails,
    required this.partialUser,
    required this.adverts,
    required this.viewAdverts,
    required this.advertImages,
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
    required this.messages,
    required this.messageSubscription,
    required this.reviews,
    required this.sum,
    required this.advertsWon,
    required this.admin,
    required this.userProfileImage,
    required this.paystackSecretKey,
    required this.paystackPublicKey,
    required this.notifications,
  });

  // this methods sets the starting state for the store
  factory AppState.initial() {
    return AppState(
      authModel: null,
      userDetails: const UserModel(
        id: "",
        email: "",
        userType: "",
        externalProvider: false,
        statistics: StatisticsModel(
          ratingSum: 0,
          ratingCount: 0,
          created: 0,
          finished: 0,
        ),
      ),
      partialUser: const PartialUser(email: "", group: "", verified: ""),
      adverts: const [],
      advertsWon: const [],
      sum: 0,
      viewAdverts: const [],
      bids: const [],
      shortlistBids: const [],
      viewBids: const [],
      reviews: const [],
      activeAd: const AdvertModel(
        id: "",
        type: "none",
        title: "",
        domain: Domain(
            city: "city",
            province: "province",
            coordinates: Coordinates(lat: 22, lng: 21)),
        dateCreated: 0,
      ),
      advertImages: const [],
      activeBid: const BidModel(
        id: "",
        userId: "",
        priceLower: 0,
        priceUpper: 0,
        dateCreated: 0,
        shortlisted: false,
      ),
      locationResult: null,
      error: ErrorType.none,
      change: false,
      wait: Wait(),
      chats: const [],
      chat: null,
      messages: const [],
      messageSubscription: null,
      admin: const AdminModel(reportedCustomers: []),
      userProfileImage: null,
      paystackPublicKey: "",
      paystackSecretKey: "",
      notifications: const [],
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
    List<MessageModel>? messages,
    StreamSubscription<GraphQLResponse<dynamic>>? messageSubscription,
    AdminModel? admin,
    List<String>? advertsWon,
    int? sum,
    StatisticsModel? userStatistics,
    File? userProfileImage,
    String? paystackPublicKey,
    String? paystackSecretKey,
    List<NotificationModel>? notifications,
    List<File>? advertImages,
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
      messages: messages ?? this.messages,
      messageSubscription: messageSubscription ?? this.messageSubscription,
      admin: admin ?? this.admin,
      sum: sum ?? this.sum,
      advertsWon: advertsWon ?? this.advertsWon,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      paystackPublicKey: paystackPublicKey ?? this.paystackPublicKey,
      paystackSecretKey: paystackSecretKey ?? this.paystackSecretKey,
      notifications: notifications ?? this.notifications,
      advertImages: advertImages ?? this.advertImages,
    );
  }
}
