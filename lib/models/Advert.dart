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


/** This is an auto generated class representing the Advert type in your schema. */
@immutable
class Advert extends Model {
  static const classType = const _AdvertModelType();
  final String id;
  final List<Bid>? _bids;
  final String? _title;
  final String? _description;
  final String? _customer;
  final String? _location;
  final TemporalDate? _date_created;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  List<Bid>? get bids {
    return _bids;
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
  
  const Advert._internal({required this.id, bids, title, description, customer, location, date_created}): _bids = bids, _title = title, _description = description, _customer = customer, _location = location, _date_created = date_created;
  
  factory Advert({String? id, List<Bid>? bids, String? title, String? description, String? customer, String? location, TemporalDate? date_created}) {
    return Advert._internal(
      id: id == null ? UUID.getUUID() : id,
      bids: bids != null ? List<Bid>.unmodifiable(bids) : bids,
      title: title,
      description: description,
      customer: customer,
      location: location,
      date_created: date_created);
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
      _title == other._title &&
      _description == other._description &&
      _customer == other._customer &&
      _location == other._location &&
      _date_created == other._date_created;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Advert {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("customer=" + "$_customer" + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("date_created=" + (_date_created != null ? _date_created!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Advert copyWith({String? id, List<Bid>? bids, String? title, String? description, String? customer, String? location, TemporalDate? date_created}) {
    return Advert(
      id: id ?? this.id,
      bids: bids ?? this.bids,
      title: title ?? this.title,
      description: description ?? this.description,
      customer: customer ?? this.customer,
      location: location ?? this.location,
      date_created: date_created ?? this.date_created);
  }
  
  Advert.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _bids = json['bids'] is List
        ? (json['bids'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Bid.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _title = json['title'],
      _description = json['description'],
      _customer = json['customer'],
      _location = json['location'],
      _date_created = json['date_created'] != null ? TemporalDate.fromString(json['date_created']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'bids': _bids?.map((Bid? e) => e?.toJson()).toList(), 'title': _title, 'description': _description, 'customer': _customer, 'location': _location, 'date_created': _date_created?.format()
  };

  static final QueryField ID = QueryField(fieldName: "advert.id");
  static final QueryField BIDS = QueryField(
    fieldName: "bids",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Bid).toString()));
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField CUSTOMER = QueryField(fieldName: "customer");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField DATE_CREATED = QueryField(fieldName: "date_created");
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
      associatedKey: Bid.ADVERT
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Advert.CUSTOMER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Advert.LOCATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Advert.DATE_CREATED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
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