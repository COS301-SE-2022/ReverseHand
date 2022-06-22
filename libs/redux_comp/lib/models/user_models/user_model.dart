import 'package:flutter/material.dart';
import 'package:redux_comp/models/advert_model.dart';
import '../bid_model.dart';

@immutable
class UserModel {
  final String id;
  final String email;
  final String name;
  final String userType;
  final List<BidModel> bids;
  final List<BidModel> shortlistBids;
  final List<BidModel> viewBids; // holds the list of bids to view
  final List<AdvertModel> adverts;
  final BidModel?
      activeBid; // represents the current bid, used for viewing a bid
  final AdvertModel? activeAd; // used for representing the current ad
  // both will change throughout the app

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.userType,
    required this.bids,
    required this.shortlistBids,
    required this.viewBids,
    required this.adverts,
    this.activeBid,
    this.activeAd,
  });

  UserModel replace({
    String? id,
    String? email,
    String? name,
    String? userType,
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
      userType: userType ?? this.userType,
      bids: bids ?? this.bids,
      shortlistBids: shortlistBids ?? this.shortlistBids,
      viewBids: viewBids ?? this.viewBids,
      adverts: adverts ?? this.adverts,
      activeBid: activeBid ?? this.activeBid,
      activeAd: activeAd ?? this.activeAd,
    );
  }
}
