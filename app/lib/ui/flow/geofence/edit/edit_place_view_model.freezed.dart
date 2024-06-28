// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_place_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditPlaceState {
  bool get loading => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  bool get enableSave => throw _privateConstructorUsedError;
  bool get saving => throw _privateConstructorUsedError;
  bool get deleting => throw _privateConstructorUsedError;
  bool get gettingAddress => throw _privateConstructorUsedError;
  String? get placeId => throw _privateConstructorUsedError;
  ApiPlace? get updatedPlace => throw _privateConstructorUsedError;
  ApiPlaceMemberSetting? get updatedSetting =>
      throw _privateConstructorUsedError;
  List<ApiUserInfo> get membersInfo => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  double? get radius => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  DateTime? get popToBack => throw _privateConstructorUsedError;
  DateTime? get showDeleteDialog => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditPlaceStateCopyWith<EditPlaceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditPlaceStateCopyWith<$Res> {
  factory $EditPlaceStateCopyWith(
          EditPlaceState value, $Res Function(EditPlaceState) then) =
      _$EditPlaceStateCopyWithImpl<$Res, EditPlaceState>;
  @useResult
  $Res call(
      {bool loading,
      bool isAdmin,
      bool enableSave,
      bool saving,
      bool deleting,
      bool gettingAddress,
      String? placeId,
      ApiPlace? updatedPlace,
      ApiPlaceMemberSetting? updatedSetting,
      List<ApiUserInfo> membersInfo,
      String? address,
      double? radius,
      Object? error,
      DateTime? popToBack,
      DateTime? showDeleteDialog});

  $ApiPlaceCopyWith<$Res>? get updatedPlace;
  $ApiPlaceMemberSettingCopyWith<$Res>? get updatedSetting;
}

/// @nodoc
class _$EditPlaceStateCopyWithImpl<$Res, $Val extends EditPlaceState>
    implements $EditPlaceStateCopyWith<$Res> {
  _$EditPlaceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? isAdmin = null,
    Object? enableSave = null,
    Object? saving = null,
    Object? deleting = null,
    Object? gettingAddress = null,
    Object? placeId = freezed,
    Object? updatedPlace = freezed,
    Object? updatedSetting = freezed,
    Object? membersInfo = null,
    Object? address = freezed,
    Object? radius = freezed,
    Object? error = freezed,
    Object? popToBack = freezed,
    Object? showDeleteDialog = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSave: null == enableSave
          ? _value.enableSave
          : enableSave // ignore: cast_nullable_to_non_nullable
              as bool,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
      deleting: null == deleting
          ? _value.deleting
          : deleting // ignore: cast_nullable_to_non_nullable
              as bool,
      gettingAddress: null == gettingAddress
          ? _value.gettingAddress
          : gettingAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedPlace: freezed == updatedPlace
          ? _value.updatedPlace
          : updatedPlace // ignore: cast_nullable_to_non_nullable
              as ApiPlace?,
      updatedSetting: freezed == updatedSetting
          ? _value.updatedSetting
          : updatedSetting // ignore: cast_nullable_to_non_nullable
              as ApiPlaceMemberSetting?,
      membersInfo: null == membersInfo
          ? _value.membersInfo
          : membersInfo // ignore: cast_nullable_to_non_nullable
              as List<ApiUserInfo>,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double?,
      error: freezed == error ? _value.error : error,
      popToBack: freezed == popToBack
          ? _value.popToBack
          : popToBack // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showDeleteDialog: freezed == showDeleteDialog
          ? _value.showDeleteDialog
          : showDeleteDialog // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ApiPlaceCopyWith<$Res>? get updatedPlace {
    if (_value.updatedPlace == null) {
      return null;
    }

    return $ApiPlaceCopyWith<$Res>(_value.updatedPlace!, (value) {
      return _then(_value.copyWith(updatedPlace: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ApiPlaceMemberSettingCopyWith<$Res>? get updatedSetting {
    if (_value.updatedSetting == null) {
      return null;
    }

    return $ApiPlaceMemberSettingCopyWith<$Res>(_value.updatedSetting!,
        (value) {
      return _then(_value.copyWith(updatedSetting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EditPlaceStateImplCopyWith<$Res>
    implements $EditPlaceStateCopyWith<$Res> {
  factory _$$EditPlaceStateImplCopyWith(_$EditPlaceStateImpl value,
          $Res Function(_$EditPlaceStateImpl) then) =
      __$$EditPlaceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      bool isAdmin,
      bool enableSave,
      bool saving,
      bool deleting,
      bool gettingAddress,
      String? placeId,
      ApiPlace? updatedPlace,
      ApiPlaceMemberSetting? updatedSetting,
      List<ApiUserInfo> membersInfo,
      String? address,
      double? radius,
      Object? error,
      DateTime? popToBack,
      DateTime? showDeleteDialog});

  @override
  $ApiPlaceCopyWith<$Res>? get updatedPlace;
  @override
  $ApiPlaceMemberSettingCopyWith<$Res>? get updatedSetting;
}

/// @nodoc
class __$$EditPlaceStateImplCopyWithImpl<$Res>
    extends _$EditPlaceStateCopyWithImpl<$Res, _$EditPlaceStateImpl>
    implements _$$EditPlaceStateImplCopyWith<$Res> {
  __$$EditPlaceStateImplCopyWithImpl(
      _$EditPlaceStateImpl _value, $Res Function(_$EditPlaceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? isAdmin = null,
    Object? enableSave = null,
    Object? saving = null,
    Object? deleting = null,
    Object? gettingAddress = null,
    Object? placeId = freezed,
    Object? updatedPlace = freezed,
    Object? updatedSetting = freezed,
    Object? membersInfo = null,
    Object? address = freezed,
    Object? radius = freezed,
    Object? error = freezed,
    Object? popToBack = freezed,
    Object? showDeleteDialog = freezed,
  }) {
    return _then(_$EditPlaceStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSave: null == enableSave
          ? _value.enableSave
          : enableSave // ignore: cast_nullable_to_non_nullable
              as bool,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
      deleting: null == deleting
          ? _value.deleting
          : deleting // ignore: cast_nullable_to_non_nullable
              as bool,
      gettingAddress: null == gettingAddress
          ? _value.gettingAddress
          : gettingAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedPlace: freezed == updatedPlace
          ? _value.updatedPlace
          : updatedPlace // ignore: cast_nullable_to_non_nullable
              as ApiPlace?,
      updatedSetting: freezed == updatedSetting
          ? _value.updatedSetting
          : updatedSetting // ignore: cast_nullable_to_non_nullable
              as ApiPlaceMemberSetting?,
      membersInfo: null == membersInfo
          ? _value._membersInfo
          : membersInfo // ignore: cast_nullable_to_non_nullable
              as List<ApiUserInfo>,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as double?,
      error: freezed == error ? _value.error : error,
      popToBack: freezed == popToBack
          ? _value.popToBack
          : popToBack // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showDeleteDialog: freezed == showDeleteDialog
          ? _value.showDeleteDialog
          : showDeleteDialog // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$EditPlaceStateImpl implements _EditPlaceState {
  const _$EditPlaceStateImpl(
      {this.loading = false,
      this.isAdmin = false,
      this.enableSave = false,
      this.saving = false,
      this.deleting = false,
      this.gettingAddress = false,
      this.placeId,
      this.updatedPlace,
      this.updatedSetting,
      final List<ApiUserInfo> membersInfo = const [],
      this.address,
      this.radius,
      this.error,
      this.popToBack,
      this.showDeleteDialog})
      : _membersInfo = membersInfo;

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool isAdmin;
  @override
  @JsonKey()
  final bool enableSave;
  @override
  @JsonKey()
  final bool saving;
  @override
  @JsonKey()
  final bool deleting;
  @override
  @JsonKey()
  final bool gettingAddress;
  @override
  final String? placeId;
  @override
  final ApiPlace? updatedPlace;
  @override
  final ApiPlaceMemberSetting? updatedSetting;
  final List<ApiUserInfo> _membersInfo;
  @override
  @JsonKey()
  List<ApiUserInfo> get membersInfo {
    if (_membersInfo is EqualUnmodifiableListView) return _membersInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_membersInfo);
  }

  @override
  final String? address;
  @override
  final double? radius;
  @override
  final Object? error;
  @override
  final DateTime? popToBack;
  @override
  final DateTime? showDeleteDialog;

  @override
  String toString() {
    return 'EditPlaceState(loading: $loading, isAdmin: $isAdmin, enableSave: $enableSave, saving: $saving, deleting: $deleting, gettingAddress: $gettingAddress, placeId: $placeId, updatedPlace: $updatedPlace, updatedSetting: $updatedSetting, membersInfo: $membersInfo, address: $address, radius: $radius, error: $error, popToBack: $popToBack, showDeleteDialog: $showDeleteDialog)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditPlaceStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.enableSave, enableSave) ||
                other.enableSave == enableSave) &&
            (identical(other.saving, saving) || other.saving == saving) &&
            (identical(other.deleting, deleting) ||
                other.deleting == deleting) &&
            (identical(other.gettingAddress, gettingAddress) ||
                other.gettingAddress == gettingAddress) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.updatedPlace, updatedPlace) ||
                other.updatedPlace == updatedPlace) &&
            (identical(other.updatedSetting, updatedSetting) ||
                other.updatedSetting == updatedSetting) &&
            const DeepCollectionEquality()
                .equals(other._membersInfo, _membersInfo) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.popToBack, popToBack) ||
                other.popToBack == popToBack) &&
            (identical(other.showDeleteDialog, showDeleteDialog) ||
                other.showDeleteDialog == showDeleteDialog));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      isAdmin,
      enableSave,
      saving,
      deleting,
      gettingAddress,
      placeId,
      updatedPlace,
      updatedSetting,
      const DeepCollectionEquality().hash(_membersInfo),
      address,
      radius,
      const DeepCollectionEquality().hash(error),
      popToBack,
      showDeleteDialog);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditPlaceStateImplCopyWith<_$EditPlaceStateImpl> get copyWith =>
      __$$EditPlaceStateImplCopyWithImpl<_$EditPlaceStateImpl>(
          this, _$identity);
}

abstract class _EditPlaceState implements EditPlaceState {
  const factory _EditPlaceState(
      {final bool loading,
      final bool isAdmin,
      final bool enableSave,
      final bool saving,
      final bool deleting,
      final bool gettingAddress,
      final String? placeId,
      final ApiPlace? updatedPlace,
      final ApiPlaceMemberSetting? updatedSetting,
      final List<ApiUserInfo> membersInfo,
      final String? address,
      final double? radius,
      final Object? error,
      final DateTime? popToBack,
      final DateTime? showDeleteDialog}) = _$EditPlaceStateImpl;

  @override
  bool get loading;
  @override
  bool get isAdmin;
  @override
  bool get enableSave;
  @override
  bool get saving;
  @override
  bool get deleting;
  @override
  bool get gettingAddress;
  @override
  String? get placeId;
  @override
  ApiPlace? get updatedPlace;
  @override
  ApiPlaceMemberSetting? get updatedSetting;
  @override
  List<ApiUserInfo> get membersInfo;
  @override
  String? get address;
  @override
  double? get radius;
  @override
  Object? get error;
  @override
  DateTime? get popToBack;
  @override
  DateTime? get showDeleteDialog;
  @override
  @JsonKey(ignore: true)
  _$$EditPlaceStateImplCopyWith<_$EditPlaceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
