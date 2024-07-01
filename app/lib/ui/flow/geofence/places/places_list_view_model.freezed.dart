// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'places_list_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlacesListState {
  bool get loading => throw _privateConstructorUsedError;
  bool get deletingPlaces => throw _privateConstructorUsedError;
  String? get spaceId => throw _privateConstructorUsedError;
  DateTime? get showDeletePlaceDialog => throw _privateConstructorUsedError;
  ApiPlace? get placesToDelete => throw _privateConstructorUsedError;
  ApiUser? get currentUser => throw _privateConstructorUsedError;
  List<ApiPlace> get places => throw _privateConstructorUsedError;
  List<String> get suggestions => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlacesListStateCopyWith<PlacesListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlacesListStateCopyWith<$Res> {
  factory $PlacesListStateCopyWith(
          PlacesListState value, $Res Function(PlacesListState) then) =
      _$PlacesListStateCopyWithImpl<$Res, PlacesListState>;
  @useResult
  $Res call(
      {bool loading,
      bool deletingPlaces,
      String? spaceId,
      DateTime? showDeletePlaceDialog,
      ApiPlace? placesToDelete,
      ApiUser? currentUser,
      List<ApiPlace> places,
      List<String> suggestions,
      Object? error});

  $ApiPlaceCopyWith<$Res>? get placesToDelete;
  $ApiUserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$PlacesListStateCopyWithImpl<$Res, $Val extends PlacesListState>
    implements $PlacesListStateCopyWith<$Res> {
  _$PlacesListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? deletingPlaces = null,
    Object? spaceId = freezed,
    Object? showDeletePlaceDialog = freezed,
    Object? placesToDelete = freezed,
    Object? currentUser = freezed,
    Object? places = null,
    Object? suggestions = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      deletingPlaces: null == deletingPlaces
          ? _value.deletingPlaces
          : deletingPlaces // ignore: cast_nullable_to_non_nullable
              as bool,
      spaceId: freezed == spaceId
          ? _value.spaceId
          : spaceId // ignore: cast_nullable_to_non_nullable
              as String?,
      showDeletePlaceDialog: freezed == showDeletePlaceDialog
          ? _value.showDeletePlaceDialog
          : showDeletePlaceDialog // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placesToDelete: freezed == placesToDelete
          ? _value.placesToDelete
          : placesToDelete // ignore: cast_nullable_to_non_nullable
              as ApiPlace?,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as ApiUser?,
      places: null == places
          ? _value.places
          : places // ignore: cast_nullable_to_non_nullable
              as List<ApiPlace>,
      suggestions: null == suggestions
          ? _value.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ApiPlaceCopyWith<$Res>? get placesToDelete {
    if (_value.placesToDelete == null) {
      return null;
    }

    return $ApiPlaceCopyWith<$Res>(_value.placesToDelete!, (value) {
      return _then(_value.copyWith(placesToDelete: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ApiUserCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $ApiUserCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlacesListStateImplCopyWith<$Res>
    implements $PlacesListStateCopyWith<$Res> {
  factory _$$PlacesListStateImplCopyWith(_$PlacesListStateImpl value,
          $Res Function(_$PlacesListStateImpl) then) =
      __$$PlacesListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      bool deletingPlaces,
      String? spaceId,
      DateTime? showDeletePlaceDialog,
      ApiPlace? placesToDelete,
      ApiUser? currentUser,
      List<ApiPlace> places,
      List<String> suggestions,
      Object? error});

  @override
  $ApiPlaceCopyWith<$Res>? get placesToDelete;
  @override
  $ApiUserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$$PlacesListStateImplCopyWithImpl<$Res>
    extends _$PlacesListStateCopyWithImpl<$Res, _$PlacesListStateImpl>
    implements _$$PlacesListStateImplCopyWith<$Res> {
  __$$PlacesListStateImplCopyWithImpl(
      _$PlacesListStateImpl _value, $Res Function(_$PlacesListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? deletingPlaces = null,
    Object? spaceId = freezed,
    Object? showDeletePlaceDialog = freezed,
    Object? placesToDelete = freezed,
    Object? currentUser = freezed,
    Object? places = null,
    Object? suggestions = null,
    Object? error = freezed,
  }) {
    return _then(_$PlacesListStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      deletingPlaces: null == deletingPlaces
          ? _value.deletingPlaces
          : deletingPlaces // ignore: cast_nullable_to_non_nullable
              as bool,
      spaceId: freezed == spaceId
          ? _value.spaceId
          : spaceId // ignore: cast_nullable_to_non_nullable
              as String?,
      showDeletePlaceDialog: freezed == showDeletePlaceDialog
          ? _value.showDeletePlaceDialog
          : showDeletePlaceDialog // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placesToDelete: freezed == placesToDelete
          ? _value.placesToDelete
          : placesToDelete // ignore: cast_nullable_to_non_nullable
              as ApiPlace?,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as ApiUser?,
      places: null == places
          ? _value._places
          : places // ignore: cast_nullable_to_non_nullable
              as List<ApiPlace>,
      suggestions: null == suggestions
          ? _value._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$PlacesListStateImpl implements _PlacesListState {
  const _$PlacesListStateImpl(
      {this.loading = false,
      this.deletingPlaces = false,
      this.spaceId,
      this.showDeletePlaceDialog,
      this.placesToDelete,
      this.currentUser,
      final List<ApiPlace> places = const [],
      final List<String> suggestions = const [],
      this.error})
      : _places = places,
        _suggestions = suggestions;

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool deletingPlaces;
  @override
  final String? spaceId;
  @override
  final DateTime? showDeletePlaceDialog;
  @override
  final ApiPlace? placesToDelete;
  @override
  final ApiUser? currentUser;
  final List<ApiPlace> _places;
  @override
  @JsonKey()
  List<ApiPlace> get places {
    if (_places is EqualUnmodifiableListView) return _places;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_places);
  }

  final List<String> _suggestions;
  @override
  @JsonKey()
  List<String> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  @override
  final Object? error;

  @override
  String toString() {
    return 'PlacesListState(loading: $loading, deletingPlaces: $deletingPlaces, spaceId: $spaceId, showDeletePlaceDialog: $showDeletePlaceDialog, placesToDelete: $placesToDelete, currentUser: $currentUser, places: $places, suggestions: $suggestions, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlacesListStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.deletingPlaces, deletingPlaces) ||
                other.deletingPlaces == deletingPlaces) &&
            (identical(other.spaceId, spaceId) || other.spaceId == spaceId) &&
            (identical(other.showDeletePlaceDialog, showDeletePlaceDialog) ||
                other.showDeletePlaceDialog == showDeletePlaceDialog) &&
            (identical(other.placesToDelete, placesToDelete) ||
                other.placesToDelete == placesToDelete) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            const DeepCollectionEquality().equals(other._places, _places) &&
            const DeepCollectionEquality()
                .equals(other._suggestions, _suggestions) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      deletingPlaces,
      spaceId,
      showDeletePlaceDialog,
      placesToDelete,
      currentUser,
      const DeepCollectionEquality().hash(_places),
      const DeepCollectionEquality().hash(_suggestions),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlacesListStateImplCopyWith<_$PlacesListStateImpl> get copyWith =>
      __$$PlacesListStateImplCopyWithImpl<_$PlacesListStateImpl>(
          this, _$identity);
}

abstract class _PlacesListState implements PlacesListState {
  const factory _PlacesListState(
      {final bool loading,
      final bool deletingPlaces,
      final String? spaceId,
      final DateTime? showDeletePlaceDialog,
      final ApiPlace? placesToDelete,
      final ApiUser? currentUser,
      final List<ApiPlace> places,
      final List<String> suggestions,
      final Object? error}) = _$PlacesListStateImpl;

  @override
  bool get loading;
  @override
  bool get deletingPlaces;
  @override
  String? get spaceId;
  @override
  DateTime? get showDeletePlaceDialog;
  @override
  ApiPlace? get placesToDelete;
  @override
  ApiUser? get currentUser;
  @override
  List<ApiPlace> get places;
  @override
  List<String> get suggestions;
  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$PlacesListStateImplCopyWith<_$PlacesListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Suggestions {
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SuggestionsCopyWith<Suggestions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuggestionsCopyWith<$Res> {
  factory $SuggestionsCopyWith(
          Suggestions value, $Res Function(Suggestions) then) =
      _$SuggestionsCopyWithImpl<$Res, Suggestions>;
  @useResult
  $Res call({String name, String icon});
}

/// @nodoc
class _$SuggestionsCopyWithImpl<$Res, $Val extends Suggestions>
    implements $SuggestionsCopyWith<$Res> {
  _$SuggestionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? icon = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SuggestionsImplCopyWith<$Res>
    implements $SuggestionsCopyWith<$Res> {
  factory _$$SuggestionsImplCopyWith(
          _$SuggestionsImpl value, $Res Function(_$SuggestionsImpl) then) =
      __$$SuggestionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String icon});
}

/// @nodoc
class __$$SuggestionsImplCopyWithImpl<$Res>
    extends _$SuggestionsCopyWithImpl<$Res, _$SuggestionsImpl>
    implements _$$SuggestionsImplCopyWith<$Res> {
  __$$SuggestionsImplCopyWithImpl(
      _$SuggestionsImpl _value, $Res Function(_$SuggestionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? icon = null,
  }) {
    return _then(_$SuggestionsImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuggestionsImpl implements _Suggestions {
  const _$SuggestionsImpl({required this.name, required this.icon});

  @override
  final String name;
  @override
  final String icon;

  @override
  String toString() {
    return 'Suggestions(name: $name, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuggestionsImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, icon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuggestionsImplCopyWith<_$SuggestionsImpl> get copyWith =>
      __$$SuggestionsImplCopyWithImpl<_$SuggestionsImpl>(this, _$identity);
}

abstract class _Suggestions implements Suggestions {
  const factory _Suggestions(
      {required final String name,
      required final String icon}) = _$SuggestionsImpl;

  @override
  String get name;
  @override
  String get icon;
  @override
  @JsonKey(ignore: true)
  _$$SuggestionsImplCopyWith<_$SuggestionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
