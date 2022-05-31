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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Bid type in your schema. */
@immutable
class Bid extends Model {
  static const classType = const _BidModelType();
  final String id;
  final String? _tradesman;
  final String? _advert;
  final int? _price_lower;
  final int? _price_upper;
  final TemporalDate? _date_created;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get tradesman {
    return _tradesman;
  }
  
  String get advert {
    try {
      return _advert!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get price_lower {
    return _price_lower;
  }
  
  int? get price_upper {
    return _price_upper;
  }
  
  TemporalDate? get date_created {
    return _date_created;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Bid._internal({required this.id, tradesman, required advert, price_lower, price_upper, date_created, createdAt, updatedAt}): _tradesman = tradesman, _advert = advert, _price_lower = price_lower, _price_upper = price_upper, _date_created = date_created, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Bid({String? id, String? tradesman, required String advert, int? price_lower, int? price_upper, TemporalDate? date_created}) {
    return Bid._internal(
      id: id == null ? UUID.getUUID() : id,
      tradesman: tradesman,
      advert: advert,
      price_lower: price_lower,
      price_upper: price_upper,
      date_created: date_created);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bid &&
      id == other.id &&
      _tradesman == other._tradesman &&
      _advert == other._advert &&
      _price_lower == other._price_lower &&
      _price_upper == other._price_upper &&
      _date_created == other._date_created;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Bid {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("tradesman=" + "$_tradesman" + ", ");
    buffer.write("advert=" + "$_advert" + ", ");
    buffer.write("price_lower=" + (_price_lower != null ? _price_lower!.toString() : "null") + ", ");
    buffer.write("price_upper=" + (_price_upper != null ? _price_upper!.toString() : "null") + ", ");
    buffer.write("date_created=" + (_date_created != null ? _date_created!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Bid copyWith({String? id, String? tradesman, String? advert, int? price_lower, int? price_upper, TemporalDate? date_created}) {
    return Bid._internal(
      id: id ?? this.id,
      tradesman: tradesman ?? this.tradesman,
      advert: advert ?? this.advert,
      price_lower: price_lower ?? this.price_lower,
      price_upper: price_upper ?? this.price_upper,
      date_created: date_created ?? this.date_created);
  }
  
  Bid.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _tradesman = json['tradesman'],
      _advert = json['advert'],
      _price_lower = (json['price_lower'] as num?)?.toInt(),
      _price_upper = (json['price_upper'] as num?)?.toInt(),
      _date_created = json['date_created'] != null ? TemporalDate.fromString(json['date_created']) : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'tradesman': _tradesman, 'advert': _advert, 'price_lower': _price_lower, 'price_upper': _price_upper, 'date_created': _date_created?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "bid.id");
  static final QueryField TRADESMAN = QueryField(fieldName: "tradesman");
  static final QueryField ADVERT = QueryField(fieldName: "advert");
  static final QueryField PRICE_LOWER = QueryField(fieldName: "price_lower");
  static final QueryField PRICE_UPPER = QueryField(fieldName: "price_upper");
  static final QueryField DATE_CREATED = QueryField(fieldName: "date_created");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Bid";
    modelSchemaDefinition.pluralName = "Bids";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: const [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bid.TRADESMAN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bid.ADVERT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bid.PRICE_LOWER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bid.PRICE_UPPER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bid.DATE_CREATED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _BidModelType extends ModelType<Bid> {
  const _BidModelType();
  
  @override
  Bid fromJson(Map<String, dynamic> jsonData) {
    return Bid.fromJson(jsonData);
  }
}