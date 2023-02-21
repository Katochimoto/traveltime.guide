// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_favorite.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetUserFavoriteCollection on Isar {
  IsarCollection<UserFavorite> get userFavorites => this.collection();
}

const UserFavoriteSchema = CollectionSchema(
  name: r'UserFavorite',
  id: -6462313433026380587,
  properties: {
    r'favoriteId': PropertySchema(
      id: 0,
      name: r'favoriteId',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 2,
      name: r'type',
      type: IsarType.byte,
      enumMap: _UserFavoritetypeEnumValueMap,
    )
  },
  estimateSize: _userFavoriteEstimateSize,
  serialize: _userFavoriteSerialize,
  deserialize: _userFavoriteDeserialize,
  deserializeProp: _userFavoriteDeserializeProp,
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
    r'favoriteId_type': IndexSchema(
      id: -8777712027152211811,
      name: r'favoriteId_type',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'favoriteId',
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
  getId: _userFavoriteGetId,
  getLinks: _userFavoriteGetLinks,
  attach: _userFavoriteAttach,
  version: '3.0.5',
);

int _userFavoriteEstimateSize(
  UserFavorite object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.favoriteId.length * 3;
  bytesCount += 3 + object.id.length * 3;
  return bytesCount;
}

void _userFavoriteSerialize(
  UserFavorite object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.favoriteId);
  writer.writeString(offsets[1], object.id);
  writer.writeByte(offsets[2], object.type.index);
}

UserFavorite _userFavoriteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserFavorite(
    favoriteId: reader.readString(offsets[0]),
    id: reader.readString(offsets[1]),
    type: _UserFavoritetypeValueEnumMap[reader.readByteOrNull(offsets[2])] ??
        UserFavoriteType.point,
  );
  return object;
}

P _userFavoriteDeserializeProp<P>(
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
      return (_UserFavoritetypeValueEnumMap[reader.readByteOrNull(offset)] ??
          UserFavoriteType.point) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserFavoritetypeEnumValueMap = {
  'point': 0,
  'article': 1,
};
const _UserFavoritetypeValueEnumMap = {
  0: UserFavoriteType.point,
  1: UserFavoriteType.article,
};

Id _userFavoriteGetId(UserFavorite object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _userFavoriteGetLinks(UserFavorite object) {
  return [];
}

void _userFavoriteAttach(
    IsarCollection<dynamic> col, Id id, UserFavorite object) {}

extension UserFavoriteByIndex on IsarCollection<UserFavorite> {
  Future<UserFavorite?> getByFavoriteIdType(
      String favoriteId, UserFavoriteType type) {
    return getByIndex(r'favoriteId_type', [favoriteId, type]);
  }

  UserFavorite? getByFavoriteIdTypeSync(
      String favoriteId, UserFavoriteType type) {
    return getByIndexSync(r'favoriteId_type', [favoriteId, type]);
  }

  Future<bool> deleteByFavoriteIdType(
      String favoriteId, UserFavoriteType type) {
    return deleteByIndex(r'favoriteId_type', [favoriteId, type]);
  }

  bool deleteByFavoriteIdTypeSync(String favoriteId, UserFavoriteType type) {
    return deleteByIndexSync(r'favoriteId_type', [favoriteId, type]);
  }

  Future<List<UserFavorite?>> getAllByFavoriteIdType(
      List<String> favoriteIdValues, List<UserFavoriteType> typeValues) {
    final len = favoriteIdValues.length;
    assert(
        typeValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([favoriteIdValues[i], typeValues[i]]);
    }

    return getAllByIndex(r'favoriteId_type', values);
  }

  List<UserFavorite?> getAllByFavoriteIdTypeSync(
      List<String> favoriteIdValues, List<UserFavoriteType> typeValues) {
    final len = favoriteIdValues.length;
    assert(
        typeValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([favoriteIdValues[i], typeValues[i]]);
    }

    return getAllByIndexSync(r'favoriteId_type', values);
  }

  Future<int> deleteAllByFavoriteIdType(
      List<String> favoriteIdValues, List<UserFavoriteType> typeValues) {
    final len = favoriteIdValues.length;
    assert(
        typeValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([favoriteIdValues[i], typeValues[i]]);
    }

    return deleteAllByIndex(r'favoriteId_type', values);
  }

  int deleteAllByFavoriteIdTypeSync(
      List<String> favoriteIdValues, List<UserFavoriteType> typeValues) {
    final len = favoriteIdValues.length;
    assert(
        typeValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([favoriteIdValues[i], typeValues[i]]);
    }

    return deleteAllByIndexSync(r'favoriteId_type', values);
  }

  Future<Id> putByFavoriteIdType(UserFavorite object) {
    return putByIndex(r'favoriteId_type', object);
  }

  Id putByFavoriteIdTypeSync(UserFavorite object, {bool saveLinks = true}) {
    return putByIndexSync(r'favoriteId_type', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFavoriteIdType(List<UserFavorite> objects) {
    return putAllByIndex(r'favoriteId_type', objects);
  }

  List<Id> putAllByFavoriteIdTypeSync(List<UserFavorite> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'favoriteId_type', objects, saveLinks: saveLinks);
  }
}

extension UserFavoriteQueryWhereSort
    on QueryBuilder<UserFavorite, UserFavorite, QWhere> {
  QueryBuilder<UserFavorite, UserFavorite, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhere> anyType() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'type'),
      );
    });
  }
}

extension UserFavoriteQueryWhere
    on QueryBuilder<UserFavorite, UserFavorite, QWhereClause> {
  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause> typeEqualTo(
      UserFavoriteType type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type',
        value: [type],
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause> typeNotEqualTo(
      UserFavoriteType type) {
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause> typeGreaterThan(
    UserFavoriteType type, {
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause> typeLessThan(
    UserFavoriteType type, {
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause> typeBetween(
    UserFavoriteType lowerType,
    UserFavoriteType upperType, {
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause>
      favoriteIdEqualToAnyType(String favoriteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'favoriteId_type',
        value: [favoriteId],
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause>
      favoriteIdNotEqualToAnyType(String favoriteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favoriteId_type',
              lower: [],
              upper: [favoriteId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favoriteId_type',
              lower: [favoriteId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favoriteId_type',
              lower: [favoriteId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favoriteId_type',
              lower: [],
              upper: [favoriteId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause>
      favoriteIdTypeEqualTo(String favoriteId, UserFavoriteType type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'favoriteId_type',
        value: [favoriteId, type],
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause>
      favoriteIdEqualToTypeNotEqualTo(
          String favoriteId, UserFavoriteType type) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favoriteId_type',
              lower: [favoriteId],
              upper: [favoriteId, type],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favoriteId_type',
              lower: [favoriteId, type],
              includeLower: false,
              upper: [favoriteId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favoriteId_type',
              lower: [favoriteId, type],
              includeLower: false,
              upper: [favoriteId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'favoriteId_type',
              lower: [favoriteId],
              upper: [favoriteId, type],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause>
      favoriteIdEqualToTypeGreaterThan(
    String favoriteId,
    UserFavoriteType type, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'favoriteId_type',
        lower: [favoriteId, type],
        includeLower: include,
        upper: [favoriteId],
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause>
      favoriteIdEqualToTypeLessThan(
    String favoriteId,
    UserFavoriteType type, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'favoriteId_type',
        lower: [favoriteId],
        upper: [favoriteId, type],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterWhereClause>
      favoriteIdEqualToTypeBetween(
    String favoriteId,
    UserFavoriteType lowerType,
    UserFavoriteType upperType, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'favoriteId_type',
        lower: [favoriteId, lowerType],
        includeLower: includeLower,
        upper: [favoriteId, upperType],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserFavoriteQueryFilter
    on QueryBuilder<UserFavorite, UserFavorite, QFilterCondition> {
  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      favoriteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favoriteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      favoriteIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'favoriteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      favoriteIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'favoriteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      favoriteIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'favoriteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      favoriteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'favoriteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      favoriteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'favoriteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      favoriteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'favoriteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      favoriteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'favoriteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      favoriteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favoriteId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      favoriteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'favoriteId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> idContains(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> idMatches(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> typeEqualTo(
      UserFavoriteType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition>
      typeGreaterThan(
    UserFavoriteType value, {
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> typeLessThan(
    UserFavoriteType value, {
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

  QueryBuilder<UserFavorite, UserFavorite, QAfterFilterCondition> typeBetween(
    UserFavoriteType lower,
    UserFavoriteType upper, {
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

extension UserFavoriteQueryObject
    on QueryBuilder<UserFavorite, UserFavorite, QFilterCondition> {}

extension UserFavoriteQueryLinks
    on QueryBuilder<UserFavorite, UserFavorite, QFilterCondition> {}

extension UserFavoriteQuerySortBy
    on QueryBuilder<UserFavorite, UserFavorite, QSortBy> {
  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> sortByFavoriteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoriteId', Sort.asc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy>
      sortByFavoriteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoriteId', Sort.desc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension UserFavoriteQuerySortThenBy
    on QueryBuilder<UserFavorite, UserFavorite, QSortThenBy> {
  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> thenByFavoriteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoriteId', Sort.asc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy>
      thenByFavoriteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoriteId', Sort.desc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension UserFavoriteQueryWhereDistinct
    on QueryBuilder<UserFavorite, UserFavorite, QDistinct> {
  QueryBuilder<UserFavorite, UserFavorite, QDistinct> distinctByFavoriteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'favoriteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserFavorite, UserFavorite, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension UserFavoriteQueryProperty
    on QueryBuilder<UserFavorite, UserFavorite, QQueryProperty> {
  QueryBuilder<UserFavorite, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<UserFavorite, String, QQueryOperations> favoriteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'favoriteId');
    });
  }

  QueryBuilder<UserFavorite, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserFavorite, UserFavoriteType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
