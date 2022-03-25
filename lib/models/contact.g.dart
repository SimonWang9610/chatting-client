// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetContactCollection on Isar {
  IsarCollection<Contact> get contacts {
    return getCollection('Contact');
  }
}

final ContactSchema = CollectionSchema(
  name: 'Contact',
  schema:
      '{"name":"Contact","idName":"id","properties":[{"name":"accepted","type":"Long"},{"name":"avatar","type":"String"},{"name":"contactId","type":"String"},{"name":"created","type":"Long"},{"name":"deleted","type":"Bool"},{"name":"email","type":"String"},{"name":"isFriend","type":"Bool"},{"name":"isInviter","type":"Bool"},{"name":"nickname","type":"String"}],"indexes":[{"name":"contactId","unique":true,"properties":[{"name":"contactId","type":"Hash","caseSensitive":true}]},{"name":"email","unique":true,"properties":[{"name":"email","type":"Hash","caseSensitive":true}]}],"links":[]}',
  nativeAdapter: const _ContactNativeAdapter(),
  webAdapter: const _ContactWebAdapter(),
  idName: 'id',
  propertyIds: {
    'accepted': 0,
    'avatar': 1,
    'contactId': 2,
    'created': 3,
    'deleted': 4,
    'email': 5,
    'isFriend': 6,
    'isInviter': 7,
    'nickname': 8
  },
  listProperties: {},
  indexIds: {'contactId': 0, 'email': 1},
  indexTypes: {
    'contactId': [
      NativeIndexType.stringHash,
    ],
    'email': [
      NativeIndexType.stringHash,
    ]
  },
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.id == Isar.autoIncrement) {
      return null;
    } else {
      return obj.id;
    }
  },
  setId: (obj, id) => obj.id = id,
  getLinks: (obj) => [],
  version: 2,
);

class _ContactWebAdapter extends IsarWebTypeAdapter<Contact> {
  const _ContactWebAdapter();

  @override
  Object serialize(IsarCollection<Contact> collection, Contact object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(
        jsObj, 'accepted', object.accepted?.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'avatar', object.avatar);
    IsarNative.jsObjectSet(jsObj, 'contactId', object.contactId);
    IsarNative.jsObjectSet(
        jsObj, 'created', object.created?.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'deleted', object.deleted);
    IsarNative.jsObjectSet(jsObj, 'email', object.email);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'isFriend', object.isFriend);
    IsarNative.jsObjectSet(jsObj, 'isInviter', object.isInviter);
    IsarNative.jsObjectSet(jsObj, 'nickname', object.nickname);
    return jsObj;
  }

  @override
  Contact deserialize(IsarCollection<Contact> collection, dynamic jsObj) {
    final object = Contact();
    object.accepted = IsarNative.jsObjectGet(jsObj, 'accepted') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'accepted'),
                isUtc: true)
            .toLocal()
        : null;
    object.avatar = IsarNative.jsObjectGet(jsObj, 'avatar');
    object.contactId = IsarNative.jsObjectGet(jsObj, 'contactId') ?? '';
    object.created = IsarNative.jsObjectGet(jsObj, 'created') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'created'),
                isUtc: true)
            .toLocal()
        : null;
    object.deleted = IsarNative.jsObjectGet(jsObj, 'deleted') ?? false;
    object.email = IsarNative.jsObjectGet(jsObj, 'email') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id');
    object.isFriend = IsarNative.jsObjectGet(jsObj, 'isFriend') ?? false;
    object.isInviter = IsarNative.jsObjectGet(jsObj, 'isInviter') ?? false;
    object.nickname = IsarNative.jsObjectGet(jsObj, 'nickname') ?? '';
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'accepted':
        return (IsarNative.jsObjectGet(jsObj, 'accepted') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'accepted'),
                    isUtc: true)
                .toLocal()
            : null) as P;
      case 'avatar':
        return (IsarNative.jsObjectGet(jsObj, 'avatar')) as P;
      case 'contactId':
        return (IsarNative.jsObjectGet(jsObj, 'contactId') ?? '') as P;
      case 'created':
        return (IsarNative.jsObjectGet(jsObj, 'created') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'created'),
                    isUtc: true)
                .toLocal()
            : null) as P;
      case 'deleted':
        return (IsarNative.jsObjectGet(jsObj, 'deleted') ?? false) as P;
      case 'email':
        return (IsarNative.jsObjectGet(jsObj, 'email') ?? '') as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
      case 'isFriend':
        return (IsarNative.jsObjectGet(jsObj, 'isFriend') ?? false) as P;
      case 'isInviter':
        return (IsarNative.jsObjectGet(jsObj, 'isInviter') ?? false) as P;
      case 'nickname':
        return (IsarNative.jsObjectGet(jsObj, 'nickname') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Contact object) {}
}

class _ContactNativeAdapter extends IsarNativeTypeAdapter<Contact> {
  const _ContactNativeAdapter();

  @override
  void serialize(IsarCollection<Contact> collection, IsarRawObject rawObj,
      Contact object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.accepted;
    final _accepted = value0;
    final value1 = object.avatar;
    IsarUint8List? _avatar;
    if (value1 != null) {
      _avatar = IsarBinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += (_avatar?.length ?? 0) as int;
    final value2 = object.contactId;
    final _contactId = IsarBinaryWriter.utf8Encoder.convert(value2);
    dynamicSize += (_contactId.length) as int;
    final value3 = object.created;
    final _created = value3;
    final value4 = object.deleted;
    final _deleted = value4;
    final value5 = object.email;
    final _email = IsarBinaryWriter.utf8Encoder.convert(value5);
    dynamicSize += (_email.length) as int;
    final value6 = object.isFriend;
    final _isFriend = value6;
    final value7 = object.isInviter;
    final _isInviter = value7;
    final value8 = object.nickname;
    final _nickname = IsarBinaryWriter.utf8Encoder.convert(value8);
    dynamicSize += (_nickname.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeDateTime(offsets[0], _accepted);
    writer.writeBytes(offsets[1], _avatar);
    writer.writeBytes(offsets[2], _contactId);
    writer.writeDateTime(offsets[3], _created);
    writer.writeBool(offsets[4], _deleted);
    writer.writeBytes(offsets[5], _email);
    writer.writeBool(offsets[6], _isFriend);
    writer.writeBool(offsets[7], _isInviter);
    writer.writeBytes(offsets[8], _nickname);
  }

  @override
  Contact deserialize(IsarCollection<Contact> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = Contact();
    object.accepted = reader.readDateTimeOrNull(offsets[0]);
    object.avatar = reader.readStringOrNull(offsets[1]);
    object.contactId = reader.readString(offsets[2]);
    object.created = reader.readDateTimeOrNull(offsets[3]);
    object.deleted = reader.readBool(offsets[4]);
    object.email = reader.readString(offsets[5]);
    object.id = id;
    object.isFriend = reader.readBool(offsets[6]);
    object.isInviter = reader.readBool(offsets[7]);
    object.nickname = reader.readString(offsets[8]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 1:
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readString(offset)) as P;
      case 3:
        return (reader.readDateTimeOrNull(offset)) as P;
      case 4:
        return (reader.readBool(offset)) as P;
      case 5:
        return (reader.readString(offset)) as P;
      case 6:
        return (reader.readBool(offset)) as P;
      case 7:
        return (reader.readBool(offset)) as P;
      case 8:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Contact object) {}
}

extension ContactByIndex on IsarCollection<Contact> {
  Future<Contact?> getByContactId(String contactId) {
    return getByIndex('contactId', [contactId]);
  }

  Contact? getByContactIdSync(String contactId) {
    return getByIndexSync('contactId', [contactId]);
  }

  Future<bool> deleteByContactId(String contactId) {
    return deleteByIndex('contactId', [contactId]);
  }

  bool deleteByContactIdSync(String contactId) {
    return deleteByIndexSync('contactId', [contactId]);
  }

  Future<List<Contact?>> getAllByContactId(List<String> contactIdValues) {
    final values = contactIdValues.map((e) => [e]).toList();
    return getAllByIndex('contactId', values);
  }

  List<Contact?> getAllByContactIdSync(List<String> contactIdValues) {
    final values = contactIdValues.map((e) => [e]).toList();
    return getAllByIndexSync('contactId', values);
  }

  Future<int> deleteAllByContactId(List<String> contactIdValues) {
    final values = contactIdValues.map((e) => [e]).toList();
    return deleteAllByIndex('contactId', values);
  }

  int deleteAllByContactIdSync(List<String> contactIdValues) {
    final values = contactIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('contactId', values);
  }

  Future<Contact?> getByEmail(String email) {
    return getByIndex('email', [email]);
  }

  Contact? getByEmailSync(String email) {
    return getByIndexSync('email', [email]);
  }

  Future<bool> deleteByEmail(String email) {
    return deleteByIndex('email', [email]);
  }

  bool deleteByEmailSync(String email) {
    return deleteByIndexSync('email', [email]);
  }

  Future<List<Contact?>> getAllByEmail(List<String> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return getAllByIndex('email', values);
  }

  List<Contact?> getAllByEmailSync(List<String> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return getAllByIndexSync('email', values);
  }

  Future<int> deleteAllByEmail(List<String> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return deleteAllByIndex('email', values);
  }

  int deleteAllByEmailSync(List<String> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('email', values);
  }
}

extension ContactQueryWhereSort on QueryBuilder<Contact, Contact, QWhere> {
  QueryBuilder<Contact, Contact, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<Contact, Contact, QAfterWhere> anyContactId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'contactId'));
  }

  QueryBuilder<Contact, Contact, QAfterWhere> anyEmail() {
    return addWhereClauseInternal(const WhereClause(indexName: 'email'));
  }
}

extension ContactQueryWhere on QueryBuilder<Contact, Contact, QWhereClause> {
  QueryBuilder<Contact, Contact, QAfterWhereClause> idEqualTo(int? id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> idNotEqualTo(int? id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> idGreaterThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> idLessThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> idBetween(
    int? lowerId,
    int? upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerId],
      includeLower: includeLower,
      upper: [upperId],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> contactIdEqualTo(
      String contactId) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'contactId',
      lower: [contactId],
      includeLower: true,
      upper: [contactId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> contactIdNotEqualTo(
      String contactId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'contactId',
        upper: [contactId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'contactId',
        lower: [contactId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'contactId',
        lower: [contactId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'contactId',
        upper: [contactId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> emailEqualTo(String email) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'email',
      lower: [email],
      includeLower: true,
      upper: [email],
      includeUpper: true,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> emailNotEqualTo(
      String email) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'email',
        upper: [email],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'email',
        lower: [email],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'email',
        lower: [email],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'email',
        upper: [email],
        includeUpper: false,
      ));
    }
  }
}

extension ContactQueryFilter
    on QueryBuilder<Contact, Contact, QFilterCondition> {
  QueryBuilder<Contact, Contact, QAfterFilterCondition> acceptedIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'accepted',
      value: null,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> acceptedEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'accepted',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> acceptedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'accepted',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> acceptedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'accepted',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> acceptedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'accepted',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> avatarIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'avatar',
      value: null,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> avatarEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'avatar',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> avatarGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'avatar',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> avatarLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'avatar',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> avatarBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'avatar',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> avatarStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'avatar',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> avatarEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'avatar',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> avatarContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'avatar',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> avatarMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'avatar',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> contactIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'contactId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> contactIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'contactId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> contactIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'contactId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> contactIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'contactId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> contactIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'contactId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> contactIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'contactId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> contactIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'contactId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> contactIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'contactId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> createdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'created',
      value: null,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> createdEqualTo(
      DateTime? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'created',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> createdGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'created',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> createdLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'created',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> createdBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'created',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> deletedEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'deleted',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> emailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> emailGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> emailLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> emailBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'email',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'email',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> idLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> isFriendEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isFriend',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> isInviterEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isInviter',
      value: value,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nicknameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'nickname',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nicknameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'nickname',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nicknameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'nickname',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nicknameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'nickname',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nicknameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'nickname',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nicknameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'nickname',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nicknameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'nickname',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nicknameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'nickname',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ContactQueryLinks
    on QueryBuilder<Contact, Contact, QFilterCondition> {}

extension ContactQueryWhereSortBy on QueryBuilder<Contact, Contact, QSortBy> {
  QueryBuilder<Contact, Contact, QAfterSortBy> sortByAccepted() {
    return addSortByInternal('accepted', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByAcceptedDesc() {
    return addSortByInternal('accepted', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByAvatar() {
    return addSortByInternal('avatar', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByAvatarDesc() {
    return addSortByInternal('avatar', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByContactId() {
    return addSortByInternal('contactId', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByContactIdDesc() {
    return addSortByInternal('contactId', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByCreated() {
    return addSortByInternal('created', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByCreatedDesc() {
    return addSortByInternal('created', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByEmail() {
    return addSortByInternal('email', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByEmailDesc() {
    return addSortByInternal('email', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByIsFriend() {
    return addSortByInternal('isFriend', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByIsFriendDesc() {
    return addSortByInternal('isFriend', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByIsInviter() {
    return addSortByInternal('isInviter', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByIsInviterDesc() {
    return addSortByInternal('isInviter', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByNickname() {
    return addSortByInternal('nickname', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByNicknameDesc() {
    return addSortByInternal('nickname', Sort.desc);
  }
}

extension ContactQueryWhereSortThenBy
    on QueryBuilder<Contact, Contact, QSortThenBy> {
  QueryBuilder<Contact, Contact, QAfterSortBy> thenByAccepted() {
    return addSortByInternal('accepted', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByAcceptedDesc() {
    return addSortByInternal('accepted', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByAvatar() {
    return addSortByInternal('avatar', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByAvatarDesc() {
    return addSortByInternal('avatar', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByContactId() {
    return addSortByInternal('contactId', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByContactIdDesc() {
    return addSortByInternal('contactId', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByCreated() {
    return addSortByInternal('created', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByCreatedDesc() {
    return addSortByInternal('created', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByDeleted() {
    return addSortByInternal('deleted', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByDeletedDesc() {
    return addSortByInternal('deleted', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByEmail() {
    return addSortByInternal('email', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByEmailDesc() {
    return addSortByInternal('email', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByIsFriend() {
    return addSortByInternal('isFriend', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByIsFriendDesc() {
    return addSortByInternal('isFriend', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByIsInviter() {
    return addSortByInternal('isInviter', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByIsInviterDesc() {
    return addSortByInternal('isInviter', Sort.desc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByNickname() {
    return addSortByInternal('nickname', Sort.asc);
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByNicknameDesc() {
    return addSortByInternal('nickname', Sort.desc);
  }
}

extension ContactQueryWhereDistinct
    on QueryBuilder<Contact, Contact, QDistinct> {
  QueryBuilder<Contact, Contact, QDistinct> distinctByAccepted() {
    return addDistinctByInternal('accepted');
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByAvatar(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('avatar', caseSensitive: caseSensitive);
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByContactId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('contactId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByCreated() {
    return addDistinctByInternal('created');
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByDeleted() {
    return addDistinctByInternal('deleted');
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('email', caseSensitive: caseSensitive);
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByIsFriend() {
    return addDistinctByInternal('isFriend');
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByIsInviter() {
    return addDistinctByInternal('isInviter');
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByNickname(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('nickname', caseSensitive: caseSensitive);
  }
}

extension ContactQueryProperty
    on QueryBuilder<Contact, Contact, QQueryProperty> {
  QueryBuilder<Contact, DateTime?, QQueryOperations> acceptedProperty() {
    return addPropertyNameInternal('accepted');
  }

  QueryBuilder<Contact, String?, QQueryOperations> avatarProperty() {
    return addPropertyNameInternal('avatar');
  }

  QueryBuilder<Contact, String, QQueryOperations> contactIdProperty() {
    return addPropertyNameInternal('contactId');
  }

  QueryBuilder<Contact, DateTime?, QQueryOperations> createdProperty() {
    return addPropertyNameInternal('created');
  }

  QueryBuilder<Contact, bool, QQueryOperations> deletedProperty() {
    return addPropertyNameInternal('deleted');
  }

  QueryBuilder<Contact, String, QQueryOperations> emailProperty() {
    return addPropertyNameInternal('email');
  }

  QueryBuilder<Contact, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Contact, bool, QQueryOperations> isFriendProperty() {
    return addPropertyNameInternal('isFriend');
  }

  QueryBuilder<Contact, bool, QQueryOperations> isInviterProperty() {
    return addPropertyNameInternal('isInviter');
  }

  QueryBuilder<Contact, String, QQueryOperations> nicknameProperty() {
    return addPropertyNameInternal('nickname');
  }
}
