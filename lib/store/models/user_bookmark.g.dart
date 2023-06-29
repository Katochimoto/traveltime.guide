// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bookmark.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserBookmarkCollection on Isar {
  IsarCollection<UserBookmark> get userBookmarks => this.collection();
}

const UserBookmarkSchema = CollectionSchema(
  name: r'UserBookmark',
  id: 7291537136674944162,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.string,
    ),
    r'objectId': PropertySchema(
      id: 1,
      name: r'objectId',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 2,
      name: r'type',
      type: IsarType.byte,
      enumMap: _UserBookmarktypeEnumValueMap,
    )
  },
  estimateSize: _userBookmarkEstimateSize,
  serialize: _userBookmarkSerialize,
  deserialize: _userBookmarkDeserialize,
  deserializeProp: _userBookmarkDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'type': IndexSchema(
      id: 5117122708147080838,
      name: r'type',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'type',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'objectId_type': IndexSchema(
      id: -3293624225731155148,
      name: r'objectId_type',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'objectId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'type',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userBookmarkGetId,
  getLinks: _userBookmarkGetLinks,
  attach: _userBookmarkAttach,
  version: '3.1.0+1',
);

int _userBookmarkEstimateSize(
  UserBookmark object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.objectId.length * 3;
  return bytesCount;
}

void _userBookmarkSerialize(
  UserBookmark object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.id);
  writer.writeString(offsets[1], object.objectId);
  writer.writeByte(offsets[2], object.type.index);
}

UserBookmark _userBookmarkDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserBookmark(
    id: reader.readString(offsets[0]),
    objectId: reader.readString(offsets[1]),
    type: _UserBookmarktypeValueEnumMap[reader.readByteOrNull(offsets[2])] ??
        UserBookmarkType.point,
  );
  return object;
}

P _userBookmarkDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (_UserBookmarktypeValueEnumMap[reader.readByteOrNull(offset)] ??
          UserBookmarkType.point) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserBookmarktypeEnumValueMap = {
  'point': 0,
  'route': 1,
  'article': 2,
};
const _UserBookmarktypeValueEnumMap = {
  0: UserBookmarkType.point,
  1: UserBookmarkType.route,
  2: UserBookmarkType.article,
};

Id _userBookmarkGetId(UserBookmark object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _userBookmarkGetLinks(UserBookmark object) {
  return [];
}

void _userBookmarkAttach(
    IsarCollection<dynamic> col, Id id, UserBookmark object) {}

extension UserBookmarkByIndex on IsarCollection<UserBookmark> {
  Future<UserBookmark?> getByObjectIdType(
      String objectId, UserBookmarkType type) {
    return getByIndex(r'objectId_type', [objectId, type]);
  }

  UserBookmark? getByObjectIdTypeSync(String objectId, UserBookmarkType type) {
    return getByIndexSync(r'objectId_type', [objectId, type]);
  }

  Future<bool> deleteByObjectIdType(String objectId, UserBookmarkType type) {
    return deleteByIndex(r'objectId_type', [objectId, type]);
  }

  bool deleteByObjectIdTypeSync(String objectId, UserBookmarkType type) {
    return deleteByIndexSync(r'objectId_type', [objectId, type]);
  }

  Future<List<UserBookmark?>> getAllByObjectIdType(
      List<String> objectIdValues, List<UserBookmarkType> typeValues) {
    final len = objectIdValues.length;
    assert(
        typeValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([objectIdValues[i], typeValues[i]]);
    }

    return getAllByIndex(r'objectId_type', values);
  }

  List<UserBookmark?> getAllByObjectIdTypeSync(
      List<String> objectIdValues, List<UserBookmarkType> typeValues) {
    final len = objectIdValues.length;
    assert(
        typeValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([objectIdValues[i], typeValues[i]]);
    }

    return getAllByIndexSync(r'objectId_type', values);
  }

  Future<int> deleteAllByObjectIdType(
      List<String> objectIdValues, List<UserBookmarkType> typeValues) {
    final len = objectIdValues.length;
    assert(
        typeValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([objectIdValues[i], typeValues[i]]);
    }

    return deleteAllByIndex(r'objectId_type', values);
  }

  int deleteAllByObjectIdTypeSync(
      List<String> objectIdValues, List<UserBookmarkType> typeValues) {
    final len = objectIdValues.length;
    assert(
        typeValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([objectIdValues[i], typeValues[i]]);
    }

    return deleteAllByIndexSync(r'objectId_type', values);
  }

  Future<Id> putByObjectIdType(UserBookmark object) {
    return putByIndex(r'objectId_type', object);
  }

  Id putByObjectIdTypeSync(UserBookmark object, {bool saveLinks = true}) {
    return putByIndexSync(r'objectId_type', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByObjectIdType(List<UserBookmark> objects) {
    return putAllByIndex(r'objectId_type', objects);
  }

  List<Id> putAllByObjectIdTypeSync(List<UserBookmark> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'objectId_type', objects, saveLinks: saveLinks);
  }
}

extension UserBookmarkQueryWhereSort
    on QueryBuilder<UserBookmark, UserBookmark, QWhere> {
  QueryBuilder<UserBookmark, UserBookmark, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhere> anyType() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'type'),
      );
    });
  }
}

extension UserBookmarkQueryWhere
    on QueryBuilder<UserBookmark, UserBookmark, QWhereClause> {
  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause> typeEqualTo(
      UserBookmarkType type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type',
        value: [type],
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause> typeNotEqualTo(
      UserBookmarkType type) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [],
              upper: [type],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [type],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [type],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [],
              upper: [type],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause> typeGreaterThan(
    UserBookmarkType type, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'type',
        lower: [type],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause> typeLessThan(
    UserBookmarkType type, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'type',
        lower: [],
        upper: [type],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause> typeBetween(
    UserBookmarkType lowerType,
    UserBookmarkType upperType, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'type',
        lower: [lowerType],
        includeLower: includeLower,
        upper: [upperType],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause>
      objectIdEqualToAnyType(String objectId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'objectId_type',
        value: [objectId],
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause>
      objectIdNotEqualToAnyType(String objectId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'objectId_type',
              lower: [],
              upper: [objectId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'objectId_type',
              lower: [objectId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'objectId_type',
              lower: [objectId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'objectId_type',
              lower: [],
              upper: [objectId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause>
      objectIdTypeEqualTo(String objectId, UserBookmarkType type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'objectId_type',
        value: [objectId, type],
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause>
      objectIdEqualToTypeNotEqualTo(String objectId, UserBookmarkType type) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'objectId_type',
              lower: [objectId],
              upper: [objectId, type],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'objectId_type',
              lower: [objectId, type],
              includeLower: false,
              upper: [objectId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'objectId_type',
              lower: [objectId, type],
              includeLower: false,
              upper: [objectId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'objectId_type',
              lower: [objectId],
              upper: [objectId, type],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause>
      objectIdEqualToTypeGreaterThan(
    String objectId,
    UserBookmarkType type, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'objectId_type',
        lower: [objectId, type],
        includeLower: include,
        upper: [objectId],
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause>
      objectIdEqualToTypeLessThan(
    String objectId,
    UserBookmarkType type, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'objectId_type',
        lower: [objectId],
        upper: [objectId, type],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterWhereClause>
      objectIdEqualToTypeBetween(
    String objectId,
    UserBookmarkType lowerType,
    UserBookmarkType upperType, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'objectId_type',
        lower: [objectId, lowerType],
        includeLower: includeLower,
        upper: [objectId, upperType],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserBookmarkQueryFilter
    on QueryBuilder<UserBookmark, UserBookmark, QFilterCondition> {
  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      objectIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      objectIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'objectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      objectIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'objectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      objectIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'objectId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      objectIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'objectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      objectIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'objectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      objectIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'objectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      objectIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'objectId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      objectIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objectId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      objectIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'objectId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> typeEqualTo(
      UserBookmarkType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition>
      typeGreaterThan(
    UserBookmarkType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> typeLessThan(
    UserBookmarkType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterFilterCondition> typeBetween(
    UserBookmarkType lower,
    UserBookmarkType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserBookmarkQueryObject
    on QueryBuilder<UserBookmark, UserBookmark, QFilterCondition> {}

extension UserBookmarkQueryLinks
    on QueryBuilder<UserBookmark, UserBookmark, QFilterCondition> {}

extension UserBookmarkQuerySortBy
    on QueryBuilder<UserBookmark, UserBookmark, QSortBy> {
  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> sortByObjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectId', Sort.asc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> sortByObjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectId', Sort.desc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension UserBookmarkQuerySortThenBy
    on QueryBuilder<UserBookmark, UserBookmark, QSortThenBy> {
  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> thenByObjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectId', Sort.asc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> thenByObjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectId', Sort.desc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension UserBookmarkQueryWhereDistinct
    on QueryBuilder<UserBookmark, UserBookmark, QDistinct> {
  QueryBuilder<UserBookmark, UserBookmark, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QDistinct> distinctByObjectId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objectId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserBookmark, UserBookmark, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension UserBookmarkQueryProperty
    on QueryBuilder<UserBookmark, UserBookmark, QQueryProperty> {
  QueryBuilder<UserBookmark, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<UserBookmark, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserBookmark, String, QQueryOperations> objectIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objectId');
    });
  }

  QueryBuilder<UserBookmark, UserBookmarkType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
