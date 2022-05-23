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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ArchivedAdvert type in your schema. */
@immutable
class ArchivedAdvert extends Model {
  static const classType = const _ArchivedAdvertModelType();
  final String id;
  final String? _title;
  final String? _description;
  final String? _customer;
  final String? _location;
  final TemporalDate? _date_created;
  final TemporalDate? _date_closed;
  final List<ArchivedBid>? _bids;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get title {
    return _title;
  }
  
  String? get description {
    return _description;
  }
  
  String? get customer {
    return _customer;
  }
  
  String? get location {
    return _location;
  }
  
  TemporalDate? get date_created {
    return _date_created;
  }
  
  TemporalDate? get date_closed {
    return _date_closed;
  }
  
  List<ArchivedBid>? get bids {
    return _bids;
  }
  
  const ArchivedAdvert._internal({required this.id, title, description, customer, location, date_created, date_closed, bids}): _title = title, _description = description, _customer = customer, _location = location, _date_created = date_created, _date_closed = date_closed, _bids = bids;
  
  factory ArchivedAdvert({String? id, String? title, String? description, String? customer, String? location, TemporalDate? date_created, TemporalDate? date_closed, List<ArchivedBid>? bids}) {
    return ArchivedAdvert._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      description: description,
      customer: customer,
      location: location,
      date_created: date_created,
      date_closed: date_closed,
      bids: bids != null ? List<ArchivedBid>.unmodifiable(bids) : bids);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArchivedAdvert &&
      id == other.id &&
      _title == other._title &&
      _description == other._description &&
      _customer == other._customer &&
      _location == other._location &&
      _date_created == other._date_created &&
      _date_closed == other._date_closed &&
      DeepCollectionEquality().equals(_bids, other._bids);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ArchivedAdvert {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("customer=" + "$_customer" + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("date_created=" + (_date_created != null ? _date_created!.format() : "null") + ", ");
    buffer.write("date_closed=" + (_date_closed != null ? _date_closed!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ArchivedAdvert copyWith({String? id, String? title, String? description, String? customer, String? location, TemporalDate? date_created, TemporalDate? date_closed, List<ArchivedBid>? bids}) {
    return ArchivedAdvert(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      customer: customer ?? this.customer,
      location: location ?? this.location,
      date_created: date_created ?? this.date_created,
      date_closed: date_closed ?? this.date_closed,
      bids: bids ?? this.bids);
  }
  
  ArchivedAdvert.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _description = json['description'],
      _customer = json['customer'],
      _location = json['location'],
      _date_created = json['date_created'] != null ? TemporalDate.fromString(json['date_created']) : null,
      _date_closed = json['date_closed'] != null ? TemporalDate.fromString(json['date_closed']) : null,
      _bids = json['bids'] is List
        ? (json['bids'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ArchivedBid.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'description': _description, 'customer': _customer, 'location': _location, 'date_created': _date_created?.format(), 'date_closed': _date_closed?.format(), 'bids': _bids?.map((ArchivedBid? e) => e?.toJson()).toList()
  };

  static final QueryField ID = QueryField(fieldName: "archivedAdvert.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField CUSTOMER = QueryField(fieldName: "customer");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField DATE_CREATED = QueryField(fieldName: "date_created");
  static final QueryField DATE_CLOSED = QueryField(fieldName: "date_closed");
  static final QueryField BIDS = QueryField(
    fieldName: "bids",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ArchivedBid).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ArchivedAdvert";
    modelSchemaDefinition.pluralName = "ArchivedAdverts";
    
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
      key: ArchivedAdvert.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ArchivedAdvert.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ArchivedAdvert.CUSTOMER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ArchivedAdvert.LOCATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ArchivedAdvert.DATE_CREATED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ArchivedAdvert.DATE_CLOSED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: ArchivedAdvert.BIDS,
      isRequired: false,
      ofModelName: (ArchivedBid).toString(),
      associatedKey: ArchivedBid.ADVERT
    ));
  });
}

class _ArchivedAdvertModelType extends ModelType<ArchivedAdvert> {
  const _ArchivedAdvertModelType();
  
  @override
  ArchivedAdvert fromJson(Map<String, dynamic> jsonData) {
    return ArchivedAdvert.fromJson(jsonData);
  }
}