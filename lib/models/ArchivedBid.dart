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


/** This is an auto generated class representing the ArchivedBid type in your schema. */
@immutable
class ArchivedBid extends Model {
  static const classType = const _ArchivedBidModelType();
  final String id;
  final String? _tradesman;
  final TemporalDate? _date_created;
  final TemporalDate? _date_closed;
  final int? _price_lower;
  final int? _price_upper;
  final String? _advert;
  final ArchivedAdvert? _accepted_bid;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get tradesman {
    return _tradesman;
  }
  
  TemporalDate? get date_created {
    return _date_created;
  }
  
  TemporalDate? get date_closed {
    return _date_closed;
  }
  
  int? get price_lower {
    return _price_lower;
  }
  
  int? get price_upper {
    return _price_upper;
  }
  
  String get advert {
    try {
      return _advert!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  ArchivedAdvert? get accepted_bid {
    return _accepted_bid;
  }
  
  const ArchivedBid._internal({required this.id, tradesman, date_created, date_closed, price_lower, price_upper, required advert, accepted_bid}): _tradesman = tradesman, _date_created = date_created, _date_closed = date_closed, _price_lower = price_lower, _price_upper = price_upper, _advert = advert, _accepted_bid = accepted_bid;
  
  factory ArchivedBid({String? id, String? tradesman, TemporalDate? date_created, TemporalDate? date_closed, int? price_lower, int? price_upper, required String advert, ArchivedAdvert? accepted_bid}) {
    return ArchivedBid._internal(
      id: id == null ? UUID.getUUID() : id,
      tradesman: tradesman,
      date_created: date_created,
      date_closed: date_closed,
      price_lower: price_lower,
      price_upper: price_upper,
      advert: advert,
      accepted_bid: accepted_bid);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArchivedBid &&
      id == other.id &&
      _tradesman == other._tradesman &&
      _date_created == other._date_created &&
      _date_closed == other._date_closed &&
      _price_lower == other._price_lower &&
      _price_upper == other._price_upper &&
      _advert == other._advert &&
      _accepted_bid == other._accepted_bid;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ArchivedBid {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("tradesman=" + "$_tradesman" + ", ");
    buffer.write("date_created=" + (_date_created != null ? _date_created!.format() : "null") + ", ");
    buffer.write("date_closed=" + (_date_closed != null ? _date_closed!.format() : "null") + ", ");
    buffer.write("price_lower=" + (_price_lower != null ? _price_lower!.toString() : "null") + ", ");
    buffer.write("price_upper=" + (_price_upper != null ? _price_upper!.toString() : "null") + ", ");
    buffer.write("advert=" + "$_advert" + ", ");
    buffer.write("accepted_bid=" + (_accepted_bid != null ? _accepted_bid!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ArchivedBid copyWith({String? id, String? tradesman, TemporalDate? date_created, TemporalDate? date_closed, int? price_lower, int? price_upper, String? advert, ArchivedAdvert? accepted_bid}) {
    return ArchivedBid(
      id: id ?? this.id,
      tradesman: tradesman ?? this.tradesman,
      date_created: date_created ?? this.date_created,
      date_closed: date_closed ?? this.date_closed,
      price_lower: price_lower ?? this.price_lower,
      price_upper: price_upper ?? this.price_upper,
      advert: advert ?? this.advert,
      accepted_bid: accepted_bid ?? this.accepted_bid);
  }
  
  ArchivedBid.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _tradesman = json['tradesman'],
      _date_created = json['date_created'] != null ? TemporalDate.fromString(json['date_created']) : null,
      _date_closed = json['date_closed'] != null ? TemporalDate.fromString(json['date_closed']) : null,
      _price_lower = (json['price_lower'] as num?)?.toInt(),
      _price_upper = (json['price_upper'] as num?)?.toInt(),
      _advert = json['advert'],
      _accepted_bid = json['accepted_bid']?['serializedData'] != null
        ? ArchivedAdvert.fromJson(new Map<String, dynamic>.from(json['accepted_bid']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'tradesman': _tradesman, 'date_created': _date_created?.format(), 'date_closed': _date_closed?.format(), 'price_lower': _price_lower, 'price_upper': _price_upper, 'advert': _advert, 'accepted_bid': _accepted_bid?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "archivedBid.id");
  static final QueryField TRADESMAN = QueryField(fieldName: "tradesman");
  static final QueryField DATE_CREATED = QueryField(fieldName: "date_created");
  static final QueryField DATE_CLOSED = QueryField(fieldName: "date_closed");
  static final QueryField PRICE_LOWER = QueryField(fieldName: "price_lower");
  static final QueryField PRICE_UPPER = QueryField(fieldName: "price_upper");
  static final QueryField ADVERT = QueryField(fieldName: "advert");
  static final QueryField ACCEPTED_BID = QueryField(
    fieldName: "accepted_bid",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ArchivedAdvert).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ArchivedBid";
    modelSchemaDefinition.pluralName = "ArchivedBids";
    
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
      key: ArchivedBid.TRADESMAN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ArchivedBid.DATE_CREATED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ArchivedBid.DATE_CLOSED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ArchivedBid.PRICE_LOWER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ArchivedBid.PRICE_UPPER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ArchivedBid.ADVERT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ArchivedBid.ACCEPTED_BID,
      isRequired: false,
      targetName: "archivedAdvertBidsId",
      ofModelName: (ArchivedAdvert).toString()
    ));
  });
}

class _ArchivedBidModelType extends ModelType<ArchivedBid> {
  const _ArchivedBidModelType();
  
  @override
  ArchivedBid fromJson(Map<String, dynamic> jsonData) {
    return ArchivedBid.fromJson(jsonData);
  }
}