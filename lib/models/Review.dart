/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Review type in your schema. */
@immutable
class Review extends Model {
  static const classType = const _ReviewModelType();
  final String id;
  final int? _rating;
  final String? _comment;
  final String? _tradesman;
  final String? _date_created;
  final ArchivedAdvert? _advert;
  final String? _reviewAdvertId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  int? get rating {
    return _rating;
  }
  
  String? get comment {
    return _comment;
  }
  
  String? get tradesman {
    return _tradesman;
  }
  
  String? get date_created {
    return _date_created;
  }
  
  ArchivedAdvert? get advert {
    return _advert;
  }
  
  String? get reviewAdvertId {
    return _reviewAdvertId;
  }
  
  const Review._internal({required this.id, rating, comment, tradesman, date_created, advert, reviewAdvertId}): _rating = rating, _comment = comment, _tradesman = tradesman, _date_created = date_created, _advert = advert, _reviewAdvertId = reviewAdvertId;
  
  factory Review({String? id, int? rating, String? comment, String? tradesman, String? date_created, ArchivedAdvert? advert, String? reviewAdvertId}) {
    return Review._internal(
      id: id == null ? UUID.getUUID() : id,
      rating: rating,
      comment: comment,
      tradesman: tradesman,
      date_created: date_created,
      advert: advert,
      reviewAdvertId: reviewAdvertId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Review &&
      id == other.id &&
      _rating == other._rating &&
      _comment == other._comment &&
      _tradesman == other._tradesman &&
      _date_created == other._date_created &&
      _advert == other._advert &&
      _reviewAdvertId == other._reviewAdvertId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Review {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("rating=" + (_rating != null ? _rating!.toString() : "null") + ", ");
    buffer.write("comment=" + "$_comment" + ", ");
    buffer.write("tradesman=" + "$_tradesman" + ", ");
    buffer.write("date_created=" + "$_date_created" + ", ");
    buffer.write("reviewAdvertId=" + "$_reviewAdvertId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Review copyWith({String? id, int? rating, String? comment, String? tradesman, String? date_created, ArchivedAdvert? advert, String? reviewAdvertId}) {
    return Review(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      tradesman: tradesman ?? this.tradesman,
      date_created: date_created ?? this.date_created,
      advert: advert ?? this.advert,
      reviewAdvertId: reviewAdvertId ?? this.reviewAdvertId);
  }
  
  Review.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _rating = (json['rating'] as num?)?.toInt(),
      _comment = json['comment'],
      _tradesman = json['tradesman'],
      _date_created = json['date_created'],
      _advert = json['advert']?['serializedData'] != null
        ? ArchivedAdvert.fromJson(new Map<String, dynamic>.from(json['advert']['serializedData']))
        : null,
      _reviewAdvertId = json['reviewAdvertId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'rating': _rating, 'comment': _comment, 'tradesman': _tradesman, 'date_created': _date_created, 'advert': _advert?.toJson(), 'reviewAdvertId': _reviewAdvertId
  };

  static final QueryField ID = QueryField(fieldName: "review.id");
  static final QueryField RATING = QueryField(fieldName: "rating");
  static final QueryField COMMENT = QueryField(fieldName: "comment");
  static final QueryField TRADESMAN = QueryField(fieldName: "tradesman");
  static final QueryField DATE_CREATED = QueryField(fieldName: "date_created");
  static final QueryField ADVERT = QueryField(
    fieldName: "advert",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ArchivedAdvert).toString()));
  static final QueryField REVIEWADVERTID = QueryField(fieldName: "reviewAdvertId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Review";
    modelSchemaDefinition.pluralName = "Reviews";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Review.RATING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Review.COMMENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Review.TRADESMAN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Review.DATE_CREATED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Review.ADVERT,
      isRequired: false,
      ofModelName: (ArchivedAdvert).toString(),
      associatedKey: ArchivedAdvert.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Review.REVIEWADVERTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _ReviewModelType extends ModelType<Review> {
  const _ReviewModelType();
  
  @override
  Review fromJson(Map<String, dynamic> jsonData) {
    return Review.fromJson(jsonData);
  }
}