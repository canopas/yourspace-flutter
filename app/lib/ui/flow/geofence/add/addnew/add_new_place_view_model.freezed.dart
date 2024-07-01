// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_new_place_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddNewPlaceState {
  dynamic get loading => throw _privateConstructorUsedError;
  List<ApiNearbyPlace> get places => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddNewPlaceStateCopyWith<AddNewPlaceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddNewPlaceStateCopyWith<$Res> {
  factory $AddNewPlaceStateCopyWith(
          AddNewPlaceState value, $Res Function(AddNewPlaceState) then) =
      _$AddNewPlaceStateCopyWithImpl<$Res, AddNewPlaceState>;
  @useResult
  $Res call({dynamic loading, List<ApiNearbyPlace> places, Object? error});
}

/// @nodoc
class _$AddNewPlaceStateCopyWithImpl<$Res, $Val extends AddNewPlaceState>
    implements $AddNewPlaceStateCopyWith<$Res> {
  _$AddNewPlaceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = freezed,
    Object? places = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      loading: freezed == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      places: null == places
          ? _value.places
          : places // ignore: cast_nullable_to_non_nullable
              as List<ApiNearbyPlace>,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddNewPlaceStateImplCopyWith<$Res>
    implements $AddNewPlaceStateCopyWith<$Res> {
  factory _$$AddNewPlaceStateImplCopyWith(_$AddNewPlaceStateImpl value,
          $Res Function(_$AddNewPlaceStateImpl) then) =
      __$$AddNewPlaceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic loading, List<ApiNearbyPlace> places, Object? error});
}

/// @nodoc
class __$$AddNewPlaceStateImplCopyWithImpl<$Res>
    extends _$AddNewPlaceStateCopyWithImpl<$Res, _$AddNewPlaceStateImpl>
    implements _$$AddNewPlaceStateImplCopyWith<$Res> {
  __$$AddNewPlaceStateImplCopyWithImpl(_$AddNewPlaceStateImpl _value,
      $Res Function(_$AddNewPlaceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = freezed,
    Object? places = null,
    Object? error = freezed,
  }) {
    return _then(_$AddNewPlaceStateImpl(
      loading: freezed == loading ? _value.loading! : loading,
      places: null == places
          ? _value._places
          : places // ignore: cast_nullable_to_non_nullable
              as List<ApiNearbyPlace>,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$AddNewPlaceStateImpl implements _AddNewPlaceState {
  const _$AddNewPlaceStateImpl(
      {this.loading = false,
      final List<ApiNearbyPlace> places = const [],
      this.error})
      : _places = places;

  @override
  @JsonKey()
  final dynamic loading;
  final List<ApiNearbyPlace> _places;
  @override
  @JsonKey()
  List<ApiNearbyPlace> get places {
    if (_places is EqualUnmodifiableListView) return _places;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_places);
  }

  @override
  final Object? error;

  @override
  String toString() {
    return 'AddNewPlaceState(loading: $loading, places: $places, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddNewPlaceStateImpl &&
            const DeepCollectionEquality().equals(other.loading, loading) &&
            const DeepCollectionEquality().equals(other._places, _places) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(loading),
      const DeepCollectionEquality().hash(_places),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddNewPlaceStateImplCopyWith<_$AddNewPlaceStateImpl> get copyWith =>
      __$$AddNewPlaceStateImplCopyWithImpl<_$AddNewPlaceStateImpl>(
          this, _$identity);
}

abstract class _AddNewPlaceState implements AddNewPlaceState {
  const factory _AddNewPlaceState(
      {final dynamic loading,
      final List<ApiNearbyPlace> places,
      final Object? error}) = _$AddNewPlaceStateImpl;

  @override
  dynamic get loading;
  @override
  List<ApiNearbyPlace> get places;
  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$AddNewPlaceStateImplCopyWith<_$AddNewPlaceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
