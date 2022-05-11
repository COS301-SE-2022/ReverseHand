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
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Advert type in your schema. */
@immutable
class Advert extends Model {
  static const classType = const _AdvertModelType();
  final String id;
  final List<Bid>? _bids;
  final String? _consumerID;
  final String? _title;
  final String? _description;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  List<Bid>? get bids {
    return _bids;
  }
  
  String get consumerID {
    try {
      return _consumerID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get title {
    return _title;
  }
  
  String? get description {
    return _description;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Advert._internal({required this.id, bids, required consumerID, title, description, createdAt, updatedAt}): _bids = bids, _consumerID = consumerID, _title = title, _description = description, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Advert({String? id, List<Bid>? bids, required String consumerID, String? title, String? description}) {
    return Advert._internal(
      id: id == null ? UUID.getUUID() : id,
      bids: bids != null ? List<Bid>.unmodifiable(bids) : bids,
      consumerID: consumerID,
      title: title,
      description: description);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Advert &&
      id == other.id &&
      DeepCollectionEquality().equals(_bids, other._bids) &&
      _consumerID == other._consumerID &&
      _title == other._title &&
      _description == other._description;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Advert {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("consumerID=" + "$_consumerID" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Advert copyWith({String? id, List<Bid>? bids, String? consumerID, String? title, String? description}) {
    return Advert._internal(
      id: id ?? this.id,
      bids: bids ?? this.bids,
      consumerID: consumerID ?? this.consumerID,
      title: title ?? this.title,
      description: description ?? this.description);
  }
  
  Advert.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _bids = json['bids'] is List
        ? (json['bids'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Bid.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _consumerID = json['consumerID'],
      _title = json['title'],
      _description = json['description'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'bids': _bids?.map((Bid? e) => e?.toJson()).toList(), 'consumerID': _consumerID, 'title': _title, 'description': _description, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "advert.id");
  static final QueryField BIDS = QueryField(
    fieldName: "bids",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Bid).toString()));
  static final QueryField CONSUMERID = QueryField(fieldName: "consumerID");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Advert";
    modelSchemaDefinition.pluralName = "Adverts";
    
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Advert.BIDS,
      isRequired: false,
      ofModelName: (Bid).toString(),
      associatedKey: Bid.ADVERTID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Advert.CONSUMERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Advert.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Advert.DESCRIPTION,
      isRequired: false,
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

class _AdvertModelType extends ModelType<Advert> {
  const _AdvertModelType();
  
  @override
  Advert fromJson(Map<String, dynamic> jsonData) {
    return Advert.fromJson(jsonData);
  }
}