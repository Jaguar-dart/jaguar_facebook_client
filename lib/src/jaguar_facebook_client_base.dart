// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'dart:convert';

class UserFieldSelector {
  UserFieldSelector();

  Set<String> _fields = new Set<String>();

  static const String idField = 'id';

  static const String aboutField = 'about';

  static const String birthdayField = 'birthday';

  static const String emailField = 'email';

  static const String firstNameField = 'first_name';

  static const String genderField = 'gender';

  static const String lastNameField = 'last_name';

  static const String nameField = 'name';

  static const String nameFormatField = 'name_format';

  static const String relationshipStatusField = 'relationship_status';

  static const String religionField = 'religion';

  static const String websiteField = 'website';

  bool contains(String field) => _fields.contains(field);

  void addAbout() {
    _fields.add(aboutField);
  }

  void addBirthday() {
    _fields.add(birthdayField);
  }

  void addFirstName() {
    _fields.add(firstNameField);
  }

  void addGender() {
    _fields.add(genderField);
  }

  void addLastName() {
    _fields.add(lastNameField);
  }

  void addName() {
    _fields.add(nameField);
  }

  void addNameFormat() {
    _fields.add(nameFormatField);
  }

  void addRelationshipStatus() {
    _fields.add(relationshipStatusField);
  }

  void addReligion() {
    _fields.add(religionField);
  }

  void addWebsite() {
    _fields.add(websiteField);
  }
}

class UserResult {
  final UserFieldSelector fields;

  final Map map;

  UserResult(this.map, this.fields);

  dynamic checkAndGetField(String field) {
    if (!field.contains(field)) {
      throw new Exception('Field not selected for the query!');
    }
    return map[field];
  }

  String get id => map[UserFieldSelector.idField];

  String get about => checkAndGetField(UserFieldSelector.aboutField);

  String get birthday => checkAndGetField(UserFieldSelector.birthdayField);

  String get email => checkAndGetField(UserFieldSelector.emailField);

  String get firstName => checkAndGetField(UserFieldSelector.firstNameField);

  String get gender => checkAndGetField(UserFieldSelector.genderField);

  String get lastName => checkAndGetField(UserFieldSelector.lastNameField);

  String get name => checkAndGetField(UserFieldSelector.nameField);

  String get nameFormatField =>
      checkAndGetField(UserFieldSelector.nameFormatField);

  String get relationshipStatus =>
      checkAndGetField(UserFieldSelector.relationshipStatusField);

  String get religion => checkAndGetField(UserFieldSelector.religionField);

  String get website => checkAndGetField(UserFieldSelector.websiteField);
}

class GraphApi {
  final oauth2.Client client;

  GraphApi(this.client);

  Future<UserResult> getMe({UserFieldSelector fields}) async {
    final resp = await client.get('https://graph.facebook.com/v2.8/me');
    dynamic map = JSON.decode(resp.body);
    if(map is! Map) {
      throw new Exception('Map expected found ${map.runtimeType}');
    }
    return new UserResult(map, fields);
  }
}
