import 'package:flutter/material.dart';
import 'package:redux_comp/models/advert_model.dart';
import '../bid_model.dart';
import '../geolocation/place_model.dart';

@immutable
class UserModel {
  final String id;
  final String? email;
  final String? name;
  final String? cellNo;
  final List<dynamic>? domains;
  final List<dynamic>? tradeTypes;
  final String userType;
  final Place? place;
  final List<BidModel> bids; // holds all of the bids i.e viewBids ⊆ bids
  final List<BidModel> shortlistBids;
  final List<BidModel> viewBids; // holds the list of bids to view
  final List<AdvertModel> adverts;
  final BidModel?
      activeBid; // represents the current bid, used for viewing a bid
  final AdvertModel? activeAd; // used for representing the current ad
  // both will change throughout the app

  const UserModel({
    required this.id,
    this.email,
    this.name,
    this.cellNo,
    this.domains,
    this.tradeTypes,
    required this.userType,
    this.place,
    required this.bids,
    required this.shortlistBids,
    required this.viewBids,
    required this.adverts,
    this.activeBid,
    this.activeAd,
  });

  UserModel copy({
    String? id,
    String? email,
    String? name,
    String? cellNo,
    List<dynamic>? domains,
    List<dynamic>? tradeTypes,
    String? userType,
    Place? place,
    List<BidModel>? bids,
    List<BidModel>? shortlistBids,
    List<BidModel>? viewBids,
    List<AdvertModel>? adverts,
    BidModel? activeBid,
    AdvertModel? activeAd,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      cellNo: cellNo ?? this.cellNo,
      domains: domains ?? this.domains,
      tradeTypes: tradeTypes ?? this.tradeTypes,
      userType: userType ?? this.userType,
      place: place ?? this.place,
      bids: bids ?? this.bids,
      shortlistBids: shortlistBids ?? this.shortlistBids,
      viewBids: viewBids ?? this.viewBids,
      adverts: adverts ?? this.adverts,
      activeBid: activeBid ?? this.activeBid,
      activeAd: activeAd ?? this.activeAd,
    );
  }
}
