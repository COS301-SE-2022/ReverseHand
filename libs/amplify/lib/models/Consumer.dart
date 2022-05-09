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


/** This is an auto generated class representing the Consumer type in your schema. */
@immutable
class Consumer extends Model {
  static const classType = const _ConsumerModelType();
  final String id;
  final String? _email;
  final String? _password;
  final String? _name;
  final String? _surname;
  final List<Advert>? _adverts;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get email {
    return _email;
  }
  
  String? get password {
    return _password;
  }
  
  String? get name {
    return _name;
  }
  
  String? get surname {
    return _surname;
  }
  
  List<Advert>? get adverts {
    return _adverts;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Consumer._internal({required this.id, email, password, name, surname, adverts, createdAt, updatedAt}): _email = email, _password = password, _name = name, _surname = surname, _adverts = adverts, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Consumer({String? id, String? email, String? password, String? name, String? surname, List<Advert>? adverts}) {
    return Consumer._internal(
      id: id == null ? UUID.getUUID() : id,
      email: email,
      password: password,
      name: name,
      surname: surname,
      adverts: adverts != null ? List<Advert>.unmodifiable(adverts) : adverts);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Consumer &&
      id == other.id &&
      _email == other._email &&
      _password == other._password &&
      _name == other._name &&
      _surname == other._surname &&
      DeepCollectionEquality().equals(_adverts, other._adverts);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Consumer {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("password=" + "$_password" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("surname=" + "$_surname" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Consumer copyWith({String? id, String? email, String? password, String? name, String? surname, List<Advert>? adverts}) {
    return Consumer._internal(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      adverts: adverts ?? this.adverts);
  }
  
  Consumer.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _email = json['email'],
      _password = json['password'],
      _name = json['name'],
      _surname = json['surname'],
      _adverts = json['adverts'] is List
        ? (json['adverts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Advert.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'email': _email, 'password': _password, 'name': _name, 'surname': _surname, 'adverts': _adverts?.map((Advert? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "consumer.id");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PASSWORD = QueryField(fieldName: "password");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField SURNAME = QueryField(fieldName: "surname");
  static final QueryField ADVERTS = QueryField(
    fieldName: "adverts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Advert).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Consumer";
    modelSchemaDefinition.pluralName = "Consumers";
    
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
      key: Consumer.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Consumer.PASSWORD,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Consumer.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Consumer.SURNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Consumer.ADVERTS,
      isRequired: false,
      ofModelName: (Advert).toString(),
      associatedKey: Advert.CONSUMERID
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

class _ConsumerModelType extends ModelType<Consumer> {
  const _ConsumerModelType();
  
  @override
  Consumer fromJson(Map<String, dynamic> jsonData) {
    return Consumer.fromJson(jsonData);
  }
}