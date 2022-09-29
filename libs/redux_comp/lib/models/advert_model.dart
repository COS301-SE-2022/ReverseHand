import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';

@immutable
class AdvertModel {
  final String id;
  final String title;
  final String userId;
  final String? description;
  final String type;
  final String? acceptedBid;
  final Domain domain;
  final double dateCreated;
  final double? dateClosed;
  final double? advertRank;
  final int imageCount;
  final List<String> images; // image urls for an advert

  const AdvertModel({
    required this.id,
    required this.title,
    required this.userId,
    this.images = const [],
    this.description,
    required this.type,
    this.acceptedBid,
    required this.domain,
    required this.dateCreated,
    required this.imageCount,
    this.dateClosed,
    this.advertRank,
  });

  AdvertModel copy({
    String? id,
    String? customerId,
    String? title,
    String? userId,
    String? description,
    String? type,
    String? acceptedBid,
    Domain? domain,
    double? dateCreated,
    double? dateClosed,
    double? advertRank,
    List<String>? images,
    int? imageCount,
  }) {
    return AdvertModel(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      images: images ?? this.images,
      type: type ?? this.type,
      acceptedBid: acceptedBid ?? this.acceptedBid,
      domain: domain ?? this.domain,
      dateCreated: dateCreated ?? this.dateCreated,
      dateClosed: dateClosed ?? this.dateClosed,
      advertRank: advertRank ?? this.advertRank,
      imageCount: imageCount ?? this.imageCount,
    );
  }

  factory AdvertModel.fromJson(obj) {
    final AdvertModel advert = AdvertModel(
      id: obj['id'],
      title: obj['title'],
      userId: obj['customer_id'],
      description: obj['description'],
      type: obj['type'],
      acceptedBid: obj['accepted_bid'],
      domain: Domain.fromJson(obj['domain']),
      dateCreated: obj['date_created'].toDouble(),
      dateClosed: obj['date_closed']?.toDouble(),
      imageCount: obj['images'],
    );

    double ranking = 0.0;
    ranking += _rankTitle(advert);
    ranking += _photoRank(advert);
    ranking += _rankDescription(advert);
    ranking += _rankDateCreated(advert);

    return advert.copy(advertRank: ranking);
  }

  @override
  operator ==(Object other) =>
      other is AdvertModel &&
      id == other.id &&
      title == other.title &&
      description == other.description &&
      type == other.type &&
      acceptedBid == other.acceptedBid &&
      domain == other.domain &&
      dateCreated == other.dateCreated &&
      dateClosed == other.dateClosed &&
      advertRank == other.advertRank &&
      images == other.images &&
      imageCount == other.imageCount;

  @override
  int get hashCode => Object.hash(
        id,
        title,
        description,
        type,
        acceptedBid,
        domain,
        dateCreated,
        dateClosed,
        advertRank,
        Object.hashAll(images),
        imageCount,
      );

  static double _rankTitle(AdvertModel advert) {
    double ranking = 0;

    //First check if the title contains the tradetype of a tradesman
    // if ((advert.title.toLowerCase()).contains(trade.toLowerCase())) {
    if ((advert.type.toLowerCase()).contains(advert.title.toLowerCase())) {
      ranking += 2;
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

  static double _photoRank(AdvertModel advert) {
    if (advert.imageCount == 0) {
      return 0.0;
    } else if (advert.imageCount == 1) {
      return 1.0;
    } else if (advert.imageCount >= 2) {
      return 2.0;
    }
    return 0.0; //default
  }

  static double _rankDescription(AdvertModel advert) {
    if (advert.description == null) return 0;

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

  static double _rankDateCreated(AdvertModel advert) {
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