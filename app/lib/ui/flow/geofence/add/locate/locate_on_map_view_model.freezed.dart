// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locate_on_map_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocateOnMapState {
  CameraPosition? get centerPosition => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocateOnMapStateCopyWith<LocateOnMapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocateOnMapStateCopyWith<$Res> {
  factory $LocateOnMapStateCopyWith(
          LocateOnMapState value, $Res Function(LocateOnMapState) then) =
      _$LocateOnMapStateCopyWithImpl<$Res, LocateOnMapState>;
  @useResult
  $Res call({CameraPosition? centerPosition});
}

/// @nodoc
class _$LocateOnMapStateCopyWithImpl<$Res, $Val extends LocateOnMapState>
    implements $LocateOnMapStateCopyWith<$Res> {
  _$LocateOnMapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? centerPosition = freezed,
  }) {
    return _then(_value.copyWith(
      centerPosition: freezed == centerPosition
          ? _value.centerPosition
          : centerPosition // ignore: cast_nullable_to_non_nullable
              as CameraPosition?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocateOnMapStateImplCopyWith<$Res>
    implements $LocateOnMapStateCopyWith<$Res> {
  factory _$$LocateOnMapStateImplCopyWith(_$LocateOnMapStateImpl value,
          $Res Function(_$LocateOnMapStateImpl) then) =
      __$$LocateOnMapStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CameraPosition? centerPosition});
}

/// @nodoc
class __$$LocateOnMapStateImplCopyWithImpl<$Res>
    extends _$LocateOnMapStateCopyWithImpl<$Res, _$LocateOnMapStateImpl>
    implements _$$LocateOnMapStateImplCopyWith<$Res> {
  __$$LocateOnMapStateImplCopyWithImpl(_$LocateOnMapStateImpl _value,
      $Res Function(_$LocateOnMapStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? centerPosition = freezed,
  }) {
    return _then(_$LocateOnMapStateImpl(
      centerPosition: freezed == centerPosition
          ? _value.centerPosition
          : centerPosition // ignore: cast_nullable_to_non_nullable
              as CameraPosition?,
    ));
  }
}

/// @nodoc

class _$LocateOnMapStateImpl implements _LocateOnMapState {
  const _$LocateOnMapStateImpl({this.centerPosition});

  @override
  final CameraPosition? centerPosition;

  @override
  String toString() {
    return 'LocateOnMapState(centerPosition: $centerPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocateOnMapStateImpl &&
            (identical(other.centerPosition, centerPosition) ||
                other.centerPosition == centerPosition));
  }

  @override
  int get hashCode => Object.hash(runtimeType, centerPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocateOnMapStateImplCopyWith<_$LocateOnMapStateImpl> get copyWith =>
      __$$LocateOnMapStateImplCopyWithImpl<_$LocateOnMapStateImpl>(
          this, _$identity);
}

abstract class _LocateOnMapState implements LocateOnMapState {
  const factory _LocateOnMapState({final CameraPosition? centerPosition}) =
      _$LocateOnMapStateImpl;

  @override
  CameraPosition? get centerPosition;
  @override
  @JsonKey(ignore: true)
  _$$LocateOnMapStateImplCopyWith<_$LocateOnMapStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
