// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetMessageCollection on Isar {
  IsarCollection<Message> get messages {
    return getCollection('Message');
  }
}

final MessageSchema = CollectionSchema(
  name: 'Message',
  schema:
      '{"name":"Message","idName":"id","properties":[{"name":"chatId","type":"String"},{"name":"content","type":"String"},{"name":"created","type":"Long"},{"name":"creator","type":"String"},{"name":"messageId","type":"String"},{"name":"type","type":"String"}],"indexes":[{"name":"messageId","unique":true,"properties":[{"name":"messageId","type":"Hash","caseSensitive":true}]}],"links":[]}',
  nativeAdapter: const _MessageNativeAdapter(),
  webAdapter: const _MessageWebAdapter(),
  idName: 'id',
  propertyIds: {
    'chatId': 0,
    'content': 1,
    'created': 2,
    'creator': 3,
    'messageId': 4,
    'type': 5
  },
  listProperties: {},
  indexIds: {'messageId': 0},
  indexTypes: {
    'messageId': [
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

class _MessageWebAdapter extends IsarWebTypeAdapter<Message> {
  const _MessageWebAdapter();

  @override
  Object serialize(IsarCollection<Message> collection, Message object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'chatId', object.chatId);
    IsarNative.jsObjectSet(jsObj, 'content', object.content);
    IsarNative.jsObjectSet(
        jsObj, 'created', object.created.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'creator', object.creator);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'messageId', object.messageId);
    IsarNative.jsObjectSet(jsObj, 'type', object.type);
    return jsObj;
  }

  @override
  Message deserialize(IsarCollection<Message> collection, dynamic jsObj) {
    final object = Message();
    object.chatId = IsarNative.jsObjectGet(jsObj, 'chatId') ?? '';
    object.content = IsarNative.jsObjectGet(jsObj, 'content') ?? '';
    object.created = IsarNative.jsObjectGet(jsObj, 'created') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'created'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0);
    object.creator = IsarNative.jsObjectGet(jsObj, 'creator') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id');
    object.messageId = IsarNative.jsObjectGet(jsObj, 'messageId') ?? '';
    object.type = IsarNative.jsObjectGet(jsObj, 'type') ?? '';
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'chatId':
        return (IsarNative.jsObjectGet(jsObj, 'chatId') ?? '') as P;
      case 'content':
        return (IsarNative.jsObjectGet(jsObj, 'content') ?? '') as P;
      case 'created':
        return (IsarNative.jsObjectGet(jsObj, 'created') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'created'),
                    isUtc: true)
                .toLocal()
            : DateTime.fromMillisecondsSinceEpoch(0)) as P;
      case 'creator':
        return (IsarNative.jsObjectGet(jsObj, 'creator') ?? '') as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
      case 'messageId':
        return (IsarNative.jsObjectGet(jsObj, 'messageId') ?? '') as P;
      case 'type':
        return (IsarNative.jsObjectGet(jsObj, 'type') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Message object) {}
}

class _MessageNativeAdapter extends IsarNativeTypeAdapter<Message> {
  const _MessageNativeAdapter();

  @override
  void serialize(IsarCollection<Message> collection, IsarRawObject rawObj,
      Message object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.chatId;
    final _chatId = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_chatId.length) as int;
    final value1 = object.content;
    final _content = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_content.length) as int;
    final value2 = object.created;
    final _created = value2;
    final value3 = object.creator;
    final _creator = IsarBinaryWriter.utf8Encoder.convert(value3);
    dynamicSize += (_creator.length) as int;
    final value4 = object.messageId;
    final _messageId = IsarBinaryWriter.utf8Encoder.convert(value4);
    dynamicSize += (_messageId.length) as int;
    final value5 = object.type;
    final _type = IsarBinaryWriter.utf8Encoder.convert(value5);
    dynamicSize += (_type.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _chatId);
    writer.writeBytes(offsets[1], _content);
    writer.writeDateTime(offsets[2], _created);
    writer.writeBytes(offsets[3], _creator);
    writer.writeBytes(offsets[4], _messageId);
    writer.writeBytes(offsets[5], _type);
  }

  @override
  Message deserialize(IsarCollection<Message> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = Message();
    object.chatId = reader.readString(offsets[0]);
    object.content = reader.readString(offsets[1]);
    object.created = reader.readDateTime(offsets[2]);
    object.creator = reader.readString(offsets[3]);
    object.id = id;
    object.messageId = reader.readString(offsets[4]);
    object.type = reader.readString(offsets[5]);
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
        return (reader.readString(offset)) as P;
      case 2:
        return (reader.readDateTime(offset)) as P;
      case 3:
        return (reader.readString(offset)) as P;
      case 4:
        return (reader.readString(offset)) as P;
      case 5:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Message object) {}
}

extension MessageByIndex on IsarCollection<Message> {
  Future<Message?> getByMessageId(String messageId) {
    return getByIndex('messageId', [messageId]);
  }

  Message? getByMessageIdSync(String messageId) {
    return getByIndexSync('messageId', [messageId]);
  }

  Future<bool> deleteByMessageId(String messageId) {
    return deleteByIndex('messageId', [messageId]);
  }

  bool deleteByMessageIdSync(String messageId) {
    return deleteByIndexSync('messageId', [messageId]);
  }

  Future<List<Message?>> getAllByMessageId(List<String> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return getAllByIndex('messageId', values);
  }

  List<Message?> getAllByMessageIdSync(List<String> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return getAllByIndexSync('messageId', values);
  }

  Future<int> deleteAllByMessageId(List<String> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return deleteAllByIndex('messageId', values);
  }

  int deleteAllByMessageIdSync(List<String> messageIdValues) {
    final values = messageIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('messageId', values);
  }
}

extension MessageQueryWhereSort on QueryBuilder<Message, Message, QWhere> {
  QueryBuilder<Message, Message, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<Message, Message, QAfterWhere> anyMessageId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'messageId'));
  }
}

extension MessageQueryWhere on QueryBuilder<Message, Message, QWhereClause> {
  QueryBuilder<Message, Message, QAfterWhereClause> idEqualTo(int? id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Message, Message, QAfterWhereClause> idNotEqualTo(int? id) {
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

  QueryBuilder<Message, Message, QAfterWhereClause> idGreaterThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<Message, Message, QAfterWhereClause> idLessThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<Message, Message, QAfterWhereClause> idBetween(
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

  QueryBuilder<Message, Message, QAfterWhereClause> messageIdEqualTo(
      String messageId) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'messageId',
      lower: [messageId],
      includeLower: true,
      upper: [messageId],
      includeUpper: true,
    ));
  }

  QueryBuilder<Message, Message, QAfterWhereClause> messageIdNotEqualTo(
      String messageId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'messageId',
        upper: [messageId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'messageId',
        lower: [messageId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'messageId',
        lower: [messageId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'messageId',
        upper: [messageId],
        includeUpper: false,
      ));
    }
  }
}

extension MessageQueryFilter
    on QueryBuilder<Message, Message, QFilterCondition> {
  QueryBuilder<Message, Message, QAfterFilterCondition> chatIdEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> chatIdGreaterThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> chatIdLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> chatIdBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> chatIdStartsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> chatIdEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> chatIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'chatId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> chatIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'chatId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> contentGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> contentLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'content',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'content',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> createdEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'created',
      value: value,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> createdGreaterThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> createdLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> createdBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> creatorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'creator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> creatorGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'creator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> creatorLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'creator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> creatorBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'creator',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> creatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'creator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> creatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'creator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> creatorContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'creator',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> creatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'creator',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> messageIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'messageId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'messageId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'messageId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'messageId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'messageId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'messageId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'messageId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'messageId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> typeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'type',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'type',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'type',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension MessageQueryLinks
    on QueryBuilder<Message, Message, QFilterCondition> {}

extension MessageQueryWhereSortBy on QueryBuilder<Message, Message, QSortBy> {
  QueryBuilder<Message, Message, QAfterSortBy> sortByChatId() {
    return addSortByInternal('chatId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByChatIdDesc() {
    return addSortByInternal('chatId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByContent() {
    return addSortByInternal('content', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByContentDesc() {
    return addSortByInternal('content', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByCreated() {
    return addSortByInternal('created', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByCreatedDesc() {
    return addSortByInternal('created', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByCreator() {
    return addSortByInternal('creator', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByCreatorDesc() {
    return addSortByInternal('creator', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByMessageId() {
    return addSortByInternal('messageId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByMessageIdDesc() {
    return addSortByInternal('messageId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByType() {
    return addSortByInternal('type', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByTypeDesc() {
    return addSortByInternal('type', Sort.desc);
  }
}

extension MessageQueryWhereSortThenBy
    on QueryBuilder<Message, Message, QSortThenBy> {
  QueryBuilder<Message, Message, QAfterSortBy> thenByChatId() {
    return addSortByInternal('chatId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByChatIdDesc() {
    return addSortByInternal('chatId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByContent() {
    return addSortByInternal('content', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByContentDesc() {
    return addSortByInternal('content', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByCreated() {
    return addSortByInternal('created', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByCreatedDesc() {
    return addSortByInternal('created', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByCreator() {
    return addSortByInternal('creator', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByCreatorDesc() {
    return addSortByInternal('creator', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByMessageId() {
    return addSortByInternal('messageId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByMessageIdDesc() {
    return addSortByInternal('messageId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByType() {
    return addSortByInternal('type', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByTypeDesc() {
    return addSortByInternal('type', Sort.desc);
  }
}

extension MessageQueryWhereDistinct
    on QueryBuilder<Message, Message, QDistinct> {
  QueryBuilder<Message, Message, QDistinct> distinctByChatId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('chatId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('content', caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByCreated() {
    return addDistinctByInternal('created');
  }

  QueryBuilder<Message, Message, QDistinct> distinctByCreator(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('creator', caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Message, Message, QDistinct> distinctByMessageId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('messageId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('type', caseSensitive: caseSensitive);
  }
}

extension MessageQueryProperty
    on QueryBuilder<Message, Message, QQueryProperty> {
  QueryBuilder<Message, String, QQueryOperations> chatIdProperty() {
    return addPropertyNameInternal('chatId');
  }

  QueryBuilder<Message, String, QQueryOperations> contentProperty() {
    return addPropertyNameInternal('content');
  }

  QueryBuilder<Message, DateTime, QQueryOperations> createdProperty() {
    return addPropertyNameInternal('created');
  }

  QueryBuilder<Message, String, QQueryOperations> creatorProperty() {
    return addPropertyNameInternal('creator');
  }

  QueryBuilder<Message, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Message, String, QQueryOperations> messageIdProperty() {
    return addPropertyNameInternal('messageId');
  }

  QueryBuilder<Message, String, QQueryOperations> typeProperty() {
    return addPropertyNameInternal('type');
  }
}
