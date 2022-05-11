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
  final bool? _accepted;
  final String? _advertID;
  final String? _tradesmanID;
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
  
  String? get advert {
    return _advert;
  }
  
  bool? get accepted {
    return _accepted;
  }
  
  String get advertID {
    try {
      return _advertID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get tradesmanID {
    try {
      return _tradesmanID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Bid._internal({required this.id, tradesman, advert, accepted, required advertID, required tradesmanID, createdAt, updatedAt}): _tradesman = tradesman, _advert = advert, _accepted = accepted, _advertID = advertID, _tradesmanID = tradesmanID, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Bid({String? id, String? tradesman, String? advert, bool? accepted, required String advertID, required String tradesmanID}) {
    return Bid._internal(
      id: id == null ? UUID.getUUID() : id,
      tradesman: tradesman,
      advert: advert,
      accepted: accepted,
      advertID: advertID,
      tradesmanID: tradesmanID);
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
      _accepted == other._accepted &&
      _advertID == other._advertID &&
      _tradesmanID == other._tradesmanID;
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
    buffer.write("accepted=" + (_accepted != null ? _accepted!.toString() : "null") + ", ");
    buffer.write("advertID=" + "$_advertID" + ", ");
    buffer.write("tradesmanID=" + "$_tradesmanID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Bid copyWith({String? id, String? tradesman, String? advert, bool? accepted, String? advertID, String? tradesmanID}) {
    return Bid._internal(
      id: id ?? this.id,
      tradesman: tradesman ?? this.tradesman,
      advert: advert ?? this.advert,
      accepted: accepted ?? this.accepted,
      advertID: advertID ?? this.advertID,
      tradesmanID: tradesmanID ?? this.tradesmanID);
  }
  
  Bid.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _tradesman = json['tradesman'],
      _advert = json['advert'],
      _accepted = json['accepted'],
      _advertID = json['advertID'],
      _tradesmanID = json['tradesmanID'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'tradesman': _tradesman, 'advert': _advert, 'accepted': _accepted, 'advertID': _advertID, 'tradesmanID': _tradesmanID, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "bid.id");
  static final QueryField TRADESMAN = QueryField(fieldName: "tradesman");
  static final QueryField ADVERT = QueryField(fieldName: "advert");
  static final QueryField ACCEPTED = QueryField(fieldName: "accepted");
  static final QueryField ADVERTID = QueryField(fieldName: "advertID");
  static final QueryField TRADESMANID = QueryField(fieldName: "tradesmanID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Bid";
    modelSchemaDefinition.pluralName = "Bids";
    
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
      key: Bid.TRADESMAN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bid.ADVERT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bid.ACCEPTED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bid.ADVERTID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bid.TRADESMANID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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