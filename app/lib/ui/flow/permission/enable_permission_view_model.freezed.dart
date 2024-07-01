// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enable_permission_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PermissionViewState {
  DateTime? get bgAction => throw _privateConstructorUsedError;
  DateTime? get showLocationPrompt => throw _privateConstructorUsedError;
  dynamic get isLocationGranted => throw _privateConstructorUsedError;
  dynamic get isBackGroundLocationGranted => throw _privateConstructorUsedError;
  dynamic get isNotificationGranted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PermissionViewStateCopyWith<PermissionViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionViewStateCopyWith<$Res> {
  factory $PermissionViewStateCopyWith(
          PermissionViewState value, $Res Function(PermissionViewState) then) =
      _$PermissionViewStateCopyWithImpl<$Res, PermissionViewState>;
  @useResult
  $Res call(
      {DateTime? bgAction,
      DateTime? showLocationPrompt,
      dynamic isLocationGranted,
      dynamic isBackGroundLocationGranted,
      dynamic isNotificationGranted});
}

/// @nodoc
class _$PermissionViewStateCopyWithImpl<$Res, $Val extends PermissionViewState>
    implements $PermissionViewStateCopyWith<$Res> {
  _$PermissionViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bgAction = freezed,
    Object? showLocationPrompt = freezed,
    Object? isLocationGranted = freezed,
    Object? isBackGroundLocationGranted = freezed,
    Object? isNotificationGranted = freezed,
  }) {
    return _then(_value.copyWith(
      bgAction: freezed == bgAction
          ? _value.bgAction
          : bgAction // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showLocationPrompt: freezed == showLocationPrompt
          ? _value.showLocationPrompt
          : showLocationPrompt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLocationGranted: freezed == isLocationGranted
          ? _value.isLocationGranted
          : isLocationGranted // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isBackGroundLocationGranted: freezed == isBackGroundLocationGranted
          ? _value.isBackGroundLocationGranted
          : isBackGroundLocationGranted // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isNotificationGranted: freezed == isNotificationGranted
          ? _value.isNotificationGranted
          : isNotificationGranted // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PermissionViewStateImplCopyWith<$Res>
    implements $PermissionViewStateCopyWith<$Res> {
  factory _$$PermissionViewStateImplCopyWith(_$PermissionViewStateImpl value,
          $Res Function(_$PermissionViewStateImpl) then) =
      __$$PermissionViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? bgAction,
      DateTime? showLocationPrompt,
      dynamic isLocationGranted,
      dynamic isBackGroundLocationGranted,
      dynamic isNotificationGranted});
}

/// @nodoc
class __$$PermissionViewStateImplCopyWithImpl<$Res>
    extends _$PermissionViewStateCopyWithImpl<$Res, _$PermissionViewStateImpl>
    implements _$$PermissionViewStateImplCopyWith<$Res> {
  __$$PermissionViewStateImplCopyWithImpl(_$PermissionViewStateImpl _value,
      $Res Function(_$PermissionViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bgAction = freezed,
    Object? showLocationPrompt = freezed,
    Object? isLocationGranted = freezed,
    Object? isBackGroundLocationGranted = freezed,
    Object? isNotificationGranted = freezed,
  }) {
    return _then(_$PermissionViewStateImpl(
      bgAction: freezed == bgAction
          ? _value.bgAction
          : bgAction // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showLocationPrompt: freezed == showLocationPrompt
          ? _value.showLocationPrompt
          : showLocationPrompt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLocationGranted: freezed == isLocationGranted
          ? _value.isLocationGranted!
          : isLocationGranted,
      isBackGroundLocationGranted: freezed == isBackGroundLocationGranted
          ? _value.isBackGroundLocationGranted!
          : isBackGroundLocationGranted,
      isNotificationGranted: freezed == isNotificationGranted
          ? _value.isNotificationGranted!
          : isNotificationGranted,
    ));
  }
}

/// @nodoc

class _$PermissionViewStateImpl implements _PermissionViewState {
  const _$PermissionViewStateImpl(
      {this.bgAction,
      this.showLocationPrompt,
      this.isLocationGranted = false,
      this.isBackGroundLocationGranted = false,
      this.isNotificationGranted = false});

  @override
  final DateTime? bgAction;
  @override
  final DateTime? showLocationPrompt;
  @override
  @JsonKey()
  final dynamic isLocationGranted;
  @override
  @JsonKey()
  final dynamic isBackGroundLocationGranted;
  @override
  @JsonKey()
  final dynamic isNotificationGranted;

  @override
  String toString() {
    return 'PermissionViewState(bgAction: $bgAction, showLocationPrompt: $showLocationPrompt, isLocationGranted: $isLocationGranted, isBackGroundLocationGranted: $isBackGroundLocationGranted, isNotificationGranted: $isNotificationGranted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionViewStateImpl &&
            (identical(other.bgAction, bgAction) ||
                other.bgAction == bgAction) &&
            (identical(other.showLocationPrompt, showLocationPrompt) ||
                other.showLocationPrompt == showLocationPrompt) &&
            const DeepCollectionEquality()
                .equals(other.isLocationGranted, isLocationGranted) &&
            const DeepCollectionEquality().equals(
                other.isBackGroundLocationGranted,
                isBackGroundLocationGranted) &&
            const DeepCollectionEquality()
                .equals(other.isNotificationGranted, isNotificationGranted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      bgAction,
      showLocationPrompt,
      const DeepCollectionEquality().hash(isLocationGranted),
      const DeepCollectionEquality().hash(isBackGroundLocationGranted),
      const DeepCollectionEquality().hash(isNotificationGranted));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionViewStateImplCopyWith<_$PermissionViewStateImpl> get copyWith =>
      __$$PermissionViewStateImplCopyWithImpl<_$PermissionViewStateImpl>(
          this, _$identity);
}

abstract class _PermissionViewState implements PermissionViewState {
  const factory _PermissionViewState(
      {final DateTime? bgAction,
      final DateTime? showLocationPrompt,
      final dynamic isLocationGranted,
      final dynamic isBackGroundLocationGranted,
      final dynamic isNotificationGranted}) = _$PermissionViewStateImpl;

  @override
  DateTime? get bgAction;
  @override
  DateTime? get showLocationPrompt;
  @override
  dynamic get isLocationGranted;
  @override
  dynamic get isBackGroundLocationGranted;
  @override
  dynamic get isNotificationGranted;
  @override
  @JsonKey(ignore: true)
  _$$PermissionViewStateImplCopyWith<_$PermissionViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
