// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetChatCollection on Isar {
  IsarCollection<Chat> get chats {
    return getCollection('Chat');
  }
}

final ChatSchema = CollectionSchema(
  name: 'Chat',
  schema:
      '{"name":"Chat","idName":"id","properties":[{"name":"chatId","type":"String"},{"name":"chatName","type":"String"},{"name":"created","type":"Long"},{"name":"members","type":"StringList"},{"name":"unreadCount","type":"Long"}],"indexes":[{"name":"chatId","unique":true,"properties":[{"name":"chatId","type":"Hash","caseSensitive":true}]}],"links":[{"name":"lastMessage","target":"Message"}]}',
  nativeAdapter: const _ChatNativeAdapter(),
  webAdapter: const _ChatWebAdapter(),
  idName: 'id',
  propertyIds: {
    'chatId': 0,
    'chatName': 1,
    'created': 2,
    'members': 3,
    'unreadCount': 4
  },
  listProperties: {'members'},
  indexIds: {'chatId': 0},
  indexTypes: {
    'chatId': [
      NativeIndexType.stringHash,
    ]
  },
  linkIds: {'lastMessage': 0},
  backlinkIds: {},
  linkedCollections: ['Message'],
  getId: (obj) {
    if (obj.id == Isar.autoIncrement) {
      return null;
    } else {
      return obj.id;
    }
  },
  setId: (obj, id) => obj.id = id,
  getLinks: (obj) => [obj.lastMessage],
  version: 2,
);

class _ChatWebAdapter extends IsarWebTypeAdapter<Chat> {
  const _ChatWebAdapter();

  @override
  Object serialize(IsarCollection<Chat> collection, Chat object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'chatId', object.chatId);
    IsarNative.jsObjectSet(jsObj, 'chatName', object.chatName);
    IsarNative.jsObjectSet(
        jsObj, 'created', object.created.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'members', object.members);
    IsarNative.jsObjectSet(jsObj, 'unreadCount', object.unreadCount);
    return jsObj;
  }

  @override
  Chat deserialize(IsarCollection<Chat> collection, dynamic jsObj) {
    final object = Chat();
    object.chatId = IsarNative.jsObjectGet(jsObj, 'chatId') ?? '';
    object.chatName = IsarNative.jsObjectGet(jsObj, 'chatName');
    object.created = IsarNative.jsObjectGet(jsObj, 'created') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'created'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0);
    object.id = IsarNative.jsObjectGet(jsObj, 'id');
    object.members = (IsarNative.jsObjectGet(jsObj, 'members') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>() ??
        [];
    object.unreadCount =
        IsarNative.jsObjectGet(jsObj, 'unreadCount') ?? double.negativeInfinity;
    attachLinks(collection.isar, IsarNative.jsObjectGet(jsObj, 'id'), object);
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'chatId':
        return (IsarNative.jsObjectGet(jsObj, 'chatId') ?? '') as P;
      case 'chatName':
        return (IsarNative.jsObjectGet(jsObj, 'chatName')) as P;
      case 'created':
        return (IsarNative.jsObjectGet(jsObj, 'created') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'created'),
                    isUtc: true)
                .toLocal()
            : DateTime.fromMillisecondsSinceEpoch(0)) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
      case 'members':
        return ((IsarNative.jsObjectGet(jsObj, 'members') as List?)
                ?.map((e) => e ?? '')
                .toList()
                .cast<String>() ??
            []) as P;
      case 'unreadCount':
        return (IsarNative.jsObjectGet(jsObj, 'unreadCount') ??
            double.negativeInfinity) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Chat object) {
    object.lastMessage.attach(
      id,
      isar.chats,
      isar.getCollection<Message>('Message'),
      'lastMessage',
      false,
    );
  }
}

class _ChatNativeAdapter extends IsarNativeTypeAdapter<Chat> {
  const _ChatNativeAdapter();

  @override
  void serialize(IsarCollection<Chat> collection, IsarRawObject rawObj,
      Chat object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.chatId;
    final _chatId = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_chatId.length) as int;
    final value1 = object.chatName;
    IsarUint8List? _chatName;
    if (value1 != null) {
      _chatName = IsarBinaryWriter.utf8Encoder.convert(value1);
    }
    dynamicSize += (_chatName?.length ?? 0) as int;
    final value2 = object.created;
    final _created = value2;
    final value3 = object.members;
    dynamicSize += (value3.length) * 8;
    final bytesList3 = <IsarUint8List>[];
    for (var str in value3) {
      final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
      bytesList3.add(bytes);
      dynamicSize += bytes.length as int;
    }
    final _members = bytesList3;
    final value4 = object.unreadCount;
    final _unreadCount = value4;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _chatId);
    writer.writeBytes(offsets[1], _chatName);
    writer.writeDateTime(offsets[2], _created);
    writer.writeStringList(offsets[3], _members);
    writer.writeLong(offsets[4], _unreadCount);
  }

  @override
  Chat deserialize(IsarCollection<Chat> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = Chat();
    object.chatId = reader.readString(offsets[0]);
    object.chatName = reader.readStringOrNull(offsets[1]);
    object.created = reader.readDateTime(offsets[2]);
    object.id = id;
    object.members = reader.readStringList(offsets[3]) ?? [];
    object.unreadCount = reader.readLong(offsets[4]);
    attachLinks(collection.isar, id, object);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readString(offset)) as P;
      case 1:
        return (reader.readStringOrNull(offset)) as P;
      case 2:
        return (reader.readDateTime(offset)) as P;
      case 3:
        return (reader.readStringList(offset) ?? []) as P;
      case 4:
        return (reader.readLong(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Chat object) {
    object.lastMessage.attach(
      id,
      isar.chats,
      isar.getCollection<Message>('Message'),
      'lastMessage',
      false,
    );
  }
}

extension ChatByIndex on IsarCollection<Chat> {
  Future<Chat?> getByChatId(String chatId) {
    return getByIndex('chatId', [chatId]);
  }

  Chat? getByChatIdSync(String chatId) {
    return getByIndexSync('chatId', [chatId]);
  }

  Future<bool> deleteByChatId(String chatId) {
    return deleteByIndex('chatId', [chatId]);
  }

  bool deleteByChatIdSync(String chatId) {
    return deleteByIndexSync('chatId', [chatId]);
  }

  Future<List<Chat?>> getAllByChatId(List<String> chatIdValues) {
    final values = chatIdValues.map((e) => [e]).toList();
    return getAllByIndex('chatId', values);
  }

  List<Chat?> getAllByChatIdSync(List<String> chatIdValues) {
    final values = chatIdValues.map((e) => [e]).toList();
    return getAllByIndexSync('chatId', values);
  }

  Future<int> deleteAllByChatId(List<String> chatIdValues) {
    final values = chatIdValues.map((e) => [e]).toList();
    return deleteAllByIndex('chatId', values);
  }

  int deleteAllByChatIdSync(List<String> chatIdValues) {
    final values = chatIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('chatId', values);
  }
}

extension ChatQueryWhereSort on QueryBuilder<Chat, Chat, QWhere> {
  QueryBuilder<Chat, Chat, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<Chat, Chat, QAfterWhere> anyChatId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'chatId'));
  }
}

extension ChatQueryWhere on QueryBuilder<Chat, Chat, QWhereClause> {
  QueryBuilder<Chat, Chat, QAfterWhereClause> idEqualTo(int? id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterWhereClause> idNotEqualTo(int? id) {
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

  QueryBuilder<Chat, Chat, QAfterWhereClause> idGreaterThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterWhereClause> idLessThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterWhereClause> idBetween(
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

  QueryBuilder<Chat, Chat, QAfterWhereClause> chatIdEqualTo(String chatId) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'chatId',
      lower: [chatId],
      includeLower: true,
      upper: [chatId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterWhereClause> chatIdNotEqualTo(String chatId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'chatId',
        upper: [chatId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'chatId',
        lower: [chatId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'chatId',
        lower: [chatId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'chatId',
        upper: [chatId],
        includeUpper: false,
      ));
    }
  }
}

extension ChatQueryFilter on QueryBuilder<Chat, Chat, QFilterCondition> {
  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'chatId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'chatId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'chatId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'chatId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'chatId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'chatId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatIdContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'chatId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'chatId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatNameIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'chatName',
      value: null,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'chatName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatNameGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'chatName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatNameLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'chatName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatNameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'chatName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'chatName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'chatName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatNameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'chatName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> chatNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'chatName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> createdEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'created',
      value: value,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> createdGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'created',
      value: value,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> createdLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'created',
      value: value,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> createdBetween(
    DateTime lower,
    DateTime upper, {
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

  QueryBuilder<Chat, Chat, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Chat, Chat, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Chat, Chat, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Chat, Chat, QAfterFilterCondition> membersAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'members',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> membersAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'members',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> membersAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'members',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> membersAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'members',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> membersAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'members',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> membersAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'members',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> membersAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'members',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> membersAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'members',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> unreadCountEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'unreadCount',
      value: value,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> unreadCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'unreadCount',
      value: value,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> unreadCountLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'unreadCount',
      value: value,
    ));
  }

  QueryBuilder<Chat, Chat, QAfterFilterCondition> unreadCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'unreadCount',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension ChatQueryLinks on QueryBuilder<Chat, Chat, QFilterCondition> {
  QueryBuilder<Chat, Chat, QAfterFilterCondition> lastMessage(
      FilterQuery<Message> q) {
    return linkInternal(
      isar.messages,
      q,
      'lastMessage',
    );
  }
}

extension ChatQueryWhereSortBy on QueryBuilder<Chat, Chat, QSortBy> {
  QueryBuilder<Chat, Chat, QAfterSortBy> sortByChatId() {
    return addSortByInternal('chatId', Sort.asc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> sortByChatIdDesc() {
    return addSortByInternal('chatId', Sort.desc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> sortByChatName() {
    return addSortByInternal('chatName', Sort.asc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> sortByChatNameDesc() {
    return addSortByInternal('chatName', Sort.desc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> sortByCreated() {
    return addSortByInternal('created', Sort.asc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> sortByCreatedDesc() {
    return addSortByInternal('created', Sort.desc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> sortByUnreadCount() {
    return addSortByInternal('unreadCount', Sort.asc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> sortByUnreadCountDesc() {
    return addSortByInternal('unreadCount', Sort.desc);
  }
}

extension ChatQueryWhereSortThenBy on QueryBuilder<Chat, Chat, QSortThenBy> {
  QueryBuilder<Chat, Chat, QAfterSortBy> thenByChatId() {
    return addSortByInternal('chatId', Sort.asc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> thenByChatIdDesc() {
    return addSortByInternal('chatId', Sort.desc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> thenByChatName() {
    return addSortByInternal('chatName', Sort.asc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> thenByChatNameDesc() {
    return addSortByInternal('chatName', Sort.desc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> thenByCreated() {
    return addSortByInternal('created', Sort.asc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> thenByCreatedDesc() {
    return addSortByInternal('created', Sort.desc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> thenByUnreadCount() {
    return addSortByInternal('unreadCount', Sort.asc);
  }

  QueryBuilder<Chat, Chat, QAfterSortBy> thenByUnreadCountDesc() {
    return addSortByInternal('unreadCount', Sort.desc);
  }
}

extension ChatQueryWhereDistinct on QueryBuilder<Chat, Chat, QDistinct> {
  QueryBuilder<Chat, Chat, QDistinct> distinctByChatId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('chatId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Chat, Chat, QDistinct> distinctByChatName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('chatName', caseSensitive: caseSensitive);
  }

  QueryBuilder<Chat, Chat, QDistinct> distinctByCreated() {
    return addDistinctByInternal('created');
  }

  QueryBuilder<Chat, Chat, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Chat, Chat, QDistinct> distinctByUnreadCount() {
    return addDistinctByInternal('unreadCount');
  }
}

extension ChatQueryProperty on QueryBuilder<Chat, Chat, QQueryProperty> {
  QueryBuilder<Chat, String, QQueryOperations> chatIdProperty() {
    return addPropertyNameInternal('chatId');
  }

  QueryBuilder<Chat, String?, QQueryOperations> chatNameProperty() {
    return addPropertyNameInternal('chatName');
  }

  QueryBuilder<Chat, DateTime, QQueryOperations> createdProperty() {
    return addPropertyNameInternal('created');
  }

  QueryBuilder<Chat, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Chat, List<String>, QQueryOperations> membersProperty() {
    return addPropertyNameInternal('members');
  }

  QueryBuilder<Chat, int, QQueryOperations> unreadCountProperty() {
    return addPropertyNameInternal('unreadCount');
  }
}
