// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_screen_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeViewState {
  bool get allowSave => throw _privateConstructorUsedError;
  bool get isCreating => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get fetchingInviteCode => throw _privateConstructorUsedError;
  SpaceInfo? get selectedSpace => throw _privateConstructorUsedError;
  String get spaceInvitationCode => throw _privateConstructorUsedError;
  List<SpaceInfo> get spaceList => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  DateTime? get showBatteryDialog => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeViewStateCopyWith<HomeViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeViewStateCopyWith<$Res> {
  factory $HomeViewStateCopyWith(
          HomeViewState value, $Res Function(HomeViewState) then) =
      _$HomeViewStateCopyWithImpl<$Res, HomeViewState>;
  @useResult
  $Res call(
      {bool allowSave,
      bool isCreating,
      bool loading,
      bool fetchingInviteCode,
      SpaceInfo? selectedSpace,
      String spaceInvitationCode,
      List<SpaceInfo> spaceList,
      Object? error,
      DateTime? showBatteryDialog});

  $SpaceInfoCopyWith<$Res>? get selectedSpace;
}

/// @nodoc
class _$HomeViewStateCopyWithImpl<$Res, $Val extends HomeViewState>
    implements $HomeViewStateCopyWith<$Res> {
  _$HomeViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowSave = null,
    Object? isCreating = null,
    Object? loading = null,
    Object? fetchingInviteCode = null,
    Object? selectedSpace = freezed,
    Object? spaceInvitationCode = null,
    Object? spaceList = null,
    Object? error = freezed,
    Object? showBatteryDialog = freezed,
  }) {
    return _then(_value.copyWith(
      allowSave: null == allowSave
          ? _value.allowSave
          : allowSave // ignore: cast_nullable_to_non_nullable
              as bool,
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      fetchingInviteCode: null == fetchingInviteCode
          ? _value.fetchingInviteCode
          : fetchingInviteCode // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedSpace: freezed == selectedSpace
          ? _value.selectedSpace
          : selectedSpace // ignore: cast_nullable_to_non_nullable
              as SpaceInfo?,
      spaceInvitationCode: null == spaceInvitationCode
          ? _value.spaceInvitationCode
          : spaceInvitationCode // ignore: cast_nullable_to_non_nullable
              as String,
      spaceList: null == spaceList
          ? _value.spaceList
          : spaceList // ignore: cast_nullable_to_non_nullable
              as List<SpaceInfo>,
      error: freezed == error ? _value.error : error,
      showBatteryDialog: freezed == showBatteryDialog
          ? _value.showBatteryDialog
          : showBatteryDialog // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SpaceInfoCopyWith<$Res>? get selectedSpace {
    if (_value.selectedSpace == null) {
      return null;
    }

    return $SpaceInfoCopyWith<$Res>(_value.selectedSpace!, (value) {
      return _then(_value.copyWith(selectedSpace: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeViewStateImplCopyWith<$Res>
    implements $HomeViewStateCopyWith<$Res> {
  factory _$$HomeViewStateImplCopyWith(
          _$HomeViewStateImpl value, $Res Function(_$HomeViewStateImpl) then) =
      __$$HomeViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool allowSave,
      bool isCreating,
      bool loading,
      bool fetchingInviteCode,
      SpaceInfo? selectedSpace,
      String spaceInvitationCode,
      List<SpaceInfo> spaceList,
      Object? error,
      DateTime? showBatteryDialog});

  @override
  $SpaceInfoCopyWith<$Res>? get selectedSpace;
}

/// @nodoc
class __$$HomeViewStateImplCopyWithImpl<$Res>
    extends _$HomeViewStateCopyWithImpl<$Res, _$HomeViewStateImpl>
    implements _$$HomeViewStateImplCopyWith<$Res> {
  __$$HomeViewStateImplCopyWithImpl(
      _$HomeViewStateImpl _value, $Res Function(_$HomeViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowSave = null,
    Object? isCreating = null,
    Object? loading = null,
    Object? fetchingInviteCode = null,
    Object? selectedSpace = freezed,
    Object? spaceInvitationCode = null,
    Object? spaceList = null,
    Object? error = freezed,
    Object? showBatteryDialog = freezed,
  }) {
    return _then(_$HomeViewStateImpl(
      allowSave: null == allowSave
          ? _value.allowSave
          : allowSave // ignore: cast_nullable_to_non_nullable
              as bool,
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      fetchingInviteCode: null == fetchingInviteCode
          ? _value.fetchingInviteCode
          : fetchingInviteCode // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedSpace: freezed == selectedSpace
          ? _value.selectedSpace
          : selectedSpace // ignore: cast_nullable_to_non_nullable
              as SpaceInfo?,
      spaceInvitationCode: null == spaceInvitationCode
          ? _value.spaceInvitationCode
          : spaceInvitationCode // ignore: cast_nullable_to_non_nullable
              as String,
      spaceList: null == spaceList
          ? _value._spaceList
          : spaceList // ignore: cast_nullable_to_non_nullable
              as List<SpaceInfo>,
      error: freezed == error ? _value.error : error,
      showBatteryDialog: freezed == showBatteryDialog
          ? _value.showBatteryDialog
          : showBatteryDialog // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$HomeViewStateImpl implements _HomeViewState {
  const _$HomeViewStateImpl(
      {this.allowSave = false,
      this.isCreating = false,
      this.loading = false,
      this.fetchingInviteCode = false,
      this.selectedSpace,
      this.spaceInvitationCode = '',
      final List<SpaceInfo> spaceList = const [],
      this.error,
      this.showBatteryDialog})
      : _spaceList = spaceList;

  @override
  @JsonKey()
  final bool allowSave;
  @override
  @JsonKey()
  final bool isCreating;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool fetchingInviteCode;
  @override
  final SpaceInfo? selectedSpace;
  @override
  @JsonKey()
  final String spaceInvitationCode;
  final List<SpaceInfo> _spaceList;
  @override
  @JsonKey()
  List<SpaceInfo> get spaceList {
    if (_spaceList is EqualUnmodifiableListView) return _spaceList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spaceList);
  }

  @override
  final Object? error;
  @override
  final DateTime? showBatteryDialog;

  @override
  String toString() {
    return 'HomeViewState(allowSave: $allowSave, isCreating: $isCreating, loading: $loading, fetchingInviteCode: $fetchingInviteCode, selectedSpace: $selectedSpace, spaceInvitationCode: $spaceInvitationCode, spaceList: $spaceList, error: $error, showBatteryDialog: $showBatteryDialog)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeViewStateImpl &&
            (identical(other.allowSave, allowSave) ||
                other.allowSave == allowSave) &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.fetchingInviteCode, fetchingInviteCode) ||
                other.fetchingInviteCode == fetchingInviteCode) &&
            (identical(other.selectedSpace, selectedSpace) ||
                other.selectedSpace == selectedSpace) &&
            (identical(other.spaceInvitationCode, spaceInvitationCode) ||
                other.spaceInvitationCode == spaceInvitationCode) &&
            const DeepCollectionEquality()
                .equals(other._spaceList, _spaceList) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.showBatteryDialog, showBatteryDialog) ||
                other.showBatteryDialog == showBatteryDialog));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      allowSave,
      isCreating,
      loading,
      fetchingInviteCode,
      selectedSpace,
      spaceInvitationCode,
      const DeepCollectionEquality().hash(_spaceList),
      const DeepCollectionEquality().hash(error),
      showBatteryDialog);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeViewStateImplCopyWith<_$HomeViewStateImpl> get copyWith =>
      __$$HomeViewStateImplCopyWithImpl<_$HomeViewStateImpl>(this, _$identity);
}

abstract class _HomeViewState implements HomeViewState {
  const factory _HomeViewState(
      {final bool allowSave,
      final bool isCreating,
      final bool loading,
      final bool fetchingInviteCode,
      final SpaceInfo? selectedSpace,
      final String spaceInvitationCode,
      final List<SpaceInfo> spaceList,
      final Object? error,
      final DateTime? showBatteryDialog}) = _$HomeViewStateImpl;

  @override
  bool get allowSave;
  @override
  bool get isCreating;
  @override
  bool get loading;
  @override
  bool get fetchingInviteCode;
  @override
  SpaceInfo? get selectedSpace;
  @override
  String get spaceInvitationCode;
  @override
  List<SpaceInfo> get spaceList;
  @override
  Object? get error;
  @override
  DateTime? get showBatteryDialog;
  @override
  @JsonKey(ignore: true)
  _$$HomeViewStateImplCopyWith<_$HomeViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
