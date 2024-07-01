// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiUser _$ApiUserFromJson(Map<String, dynamic> json) {
  return _ApiUser.fromJson(json);
}

/// @nodoc
mixin _$ApiUser {
  String get id => throw _privateConstructorUsedError;
  String? get first_name => throw _privateConstructorUsedError;
  String? get last_name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get provider_firebase_id_token => throw _privateConstructorUsedError;
  int get auth_type => throw _privateConstructorUsedError;
  String? get profile_image => throw _privateConstructorUsedError;
  bool? get location_enabled => throw _privateConstructorUsedError;
  List<String>? get space_ids => throw _privateConstructorUsedError;
  int? get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiUserCopyWith<ApiUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiUserCopyWith<$Res> {
  factory $ApiUserCopyWith(ApiUser value, $Res Function(ApiUser) then) =
      _$ApiUserCopyWithImpl<$Res, ApiUser>;
  @useResult
  $Res call(
      {String id,
      String? first_name,
      String? last_name,
      String? phone,
      String? email,
      String? provider_firebase_id_token,
      int auth_type,
      String? profile_image,
      bool? location_enabled,
      List<String>? space_ids,
      int? created_at});
}

/// @nodoc
class _$ApiUserCopyWithImpl<$Res, $Val extends ApiUser>
    implements $ApiUserCopyWith<$Res> {
  _$ApiUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? first_name = freezed,
    Object? last_name = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? provider_firebase_id_token = freezed,
    Object? auth_type = null,
    Object? profile_image = freezed,
    Object? location_enabled = freezed,
    Object? space_ids = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      first_name: freezed == first_name
          ? _value.first_name
          : first_name // ignore: cast_nullable_to_non_nullable
              as String?,
      last_name: freezed == last_name
          ? _value.last_name
          : last_name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      provider_firebase_id_token: freezed == provider_firebase_id_token
          ? _value.provider_firebase_id_token
          : provider_firebase_id_token // ignore: cast_nullable_to_non_nullable
              as String?,
      auth_type: null == auth_type
          ? _value.auth_type
          : auth_type // ignore: cast_nullable_to_non_nullable
              as int,
      profile_image: freezed == profile_image
          ? _value.profile_image
          : profile_image // ignore: cast_nullable_to_non_nullable
              as String?,
      location_enabled: freezed == location_enabled
          ? _value.location_enabled
          : location_enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      space_ids: freezed == space_ids
          ? _value.space_ids
          : space_ids // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiUserImplCopyWith<$Res> implements $ApiUserCopyWith<$Res> {
  factory _$$ApiUserImplCopyWith(
          _$ApiUserImpl value, $Res Function(_$ApiUserImpl) then) =
      __$$ApiUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? first_name,
      String? last_name,
      String? phone,
      String? email,
      String? provider_firebase_id_token,
      int auth_type,
      String? profile_image,
      bool? location_enabled,
      List<String>? space_ids,
      int? created_at});
}

/// @nodoc
class __$$ApiUserImplCopyWithImpl<$Res>
    extends _$ApiUserCopyWithImpl<$Res, _$ApiUserImpl>
    implements _$$ApiUserImplCopyWith<$Res> {
  __$$ApiUserImplCopyWithImpl(
      _$ApiUserImpl _value, $Res Function(_$ApiUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? first_name = freezed,
    Object? last_name = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? provider_firebase_id_token = freezed,
    Object? auth_type = null,
    Object? profile_image = freezed,
    Object? location_enabled = freezed,
    Object? space_ids = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_$ApiUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      first_name: freezed == first_name
          ? _value.first_name
          : first_name // ignore: cast_nullable_to_non_nullable
              as String?,
      last_name: freezed == last_name
          ? _value.last_name
          : last_name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      provider_firebase_id_token: freezed == provider_firebase_id_token
          ? _value.provider_firebase_id_token
          : provider_firebase_id_token // ignore: cast_nullable_to_non_nullable
              as String?,
      auth_type: null == auth_type
          ? _value.auth_type
          : auth_type // ignore: cast_nullable_to_non_nullable
              as int,
      profile_image: freezed == profile_image
          ? _value.profile_image
          : profile_image // ignore: cast_nullable_to_non_nullable
              as String?,
      location_enabled: freezed == location_enabled
          ? _value.location_enabled
          : location_enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      space_ids: freezed == space_ids
          ? _value._space_ids
          : space_ids // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiUserImpl extends _ApiUser {
  const _$ApiUserImpl(
      {required this.id,
      this.first_name,
      this.last_name,
      this.phone,
      this.email,
      this.provider_firebase_id_token,
      required this.auth_type,
      this.profile_image,
      this.location_enabled = true,
      final List<String>? space_ids = const [],
      this.created_at})
      : _space_ids = space_ids,
        super._();

  factory _$ApiUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiUserImplFromJson(json);

  @override
  final String id;
  @override
  final String? first_name;
  @override
  final String? last_name;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? provider_firebase_id_token;
  @override
  final int auth_type;
  @override
  final String? profile_image;
  @override
  @JsonKey()
  final bool? location_enabled;
  final List<String>? _space_ids;
  @override
  @JsonKey()
  List<String>? get space_ids {
    final value = _space_ids;
    if (value == null) return null;
    if (_space_ids is EqualUnmodifiableListView) return _space_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? created_at;

  @override
  String toString() {
    return 'ApiUser(id: $id, first_name: $first_name, last_name: $last_name, phone: $phone, email: $email, provider_firebase_id_token: $provider_firebase_id_token, auth_type: $auth_type, profile_image: $profile_image, location_enabled: $location_enabled, space_ids: $space_ids, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.first_name, first_name) ||
                other.first_name == first_name) &&
            (identical(other.last_name, last_name) ||
                other.last_name == last_name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.provider_firebase_id_token,
                    provider_firebase_id_token) ||
                other.provider_firebase_id_token ==
                    provider_firebase_id_token) &&
            (identical(other.auth_type, auth_type) ||
                other.auth_type == auth_type) &&
            (identical(other.profile_image, profile_image) ||
                other.profile_image == profile_image) &&
            (identical(other.location_enabled, location_enabled) ||
                other.location_enabled == location_enabled) &&
            const DeepCollectionEquality()
                .equals(other._space_ids, _space_ids) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      first_name,
      last_name,
      phone,
      email,
      provider_firebase_id_token,
      auth_type,
      profile_image,
      location_enabled,
      const DeepCollectionEquality().hash(_space_ids),
      created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiUserImplCopyWith<_$ApiUserImpl> get copyWith =>
      __$$ApiUserImplCopyWithImpl<_$ApiUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiUserImplToJson(
      this,
    );
  }
}

abstract class _ApiUser extends ApiUser {
  const factory _ApiUser(
      {required final String id,
      final String? first_name,
      final String? last_name,
      final String? phone,
      final String? email,
      final String? provider_firebase_id_token,
      required final int auth_type,
      final String? profile_image,
      final bool? location_enabled,
      final List<String>? space_ids,
      final int? created_at}) = _$ApiUserImpl;
  const _ApiUser._() : super._();

  factory _ApiUser.fromJson(Map<String, dynamic> json) = _$ApiUserImpl.fromJson;

  @override
  String get id;
  @override
  String? get first_name;
  @override
  String? get last_name;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get provider_firebase_id_token;
  @override
  int get auth_type;
  @override
  String? get profile_image;
  @override
  bool? get location_enabled;
  @override
  List<String>? get space_ids;
  @override
  int? get created_at;
  @override
  @JsonKey(ignore: true)
  _$$ApiUserImplCopyWith<_$ApiUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiSession _$ApiSessionFromJson(Map<String, dynamic> json) {
  return _ApiSession.fromJson(json);
}

/// @nodoc
mixin _$ApiSession {
  String get id => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;
  int? get platform => throw _privateConstructorUsedError;
  String? get fcm_token => throw _privateConstructorUsedError;
  bool get session_active => throw _privateConstructorUsedError;
  String? get device_name => throw _privateConstructorUsedError;
  String? get device_id => throw _privateConstructorUsedError;
  int? get created_at => throw _privateConstructorUsedError;
  double? get battery_pct => throw _privateConstructorUsedError;
  int? get app_version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiSessionCopyWith<ApiSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiSessionCopyWith<$Res> {
  factory $ApiSessionCopyWith(
          ApiSession value, $Res Function(ApiSession) then) =
      _$ApiSessionCopyWithImpl<$Res, ApiSession>;
  @useResult
  $Res call(
      {String id,
      String user_id,
      int? platform,
      String? fcm_token,
      bool session_active,
      String? device_name,
      String? device_id,
      int? created_at,
      double? battery_pct,
      int? app_version});
}

/// @nodoc
class _$ApiSessionCopyWithImpl<$Res, $Val extends ApiSession>
    implements $ApiSessionCopyWith<$Res> {
  _$ApiSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = null,
    Object? platform = freezed,
    Object? fcm_token = freezed,
    Object? session_active = null,
    Object? device_name = freezed,
    Object? device_id = freezed,
    Object? created_at = freezed,
    Object? battery_pct = freezed,
    Object? app_version = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as int?,
      fcm_token: freezed == fcm_token
          ? _value.fcm_token
          : fcm_token // ignore: cast_nullable_to_non_nullable
              as String?,
      session_active: null == session_active
          ? _value.session_active
          : session_active // ignore: cast_nullable_to_non_nullable
              as bool,
      device_name: freezed == device_name
          ? _value.device_name
          : device_name // ignore: cast_nullable_to_non_nullable
              as String?,
      device_id: freezed == device_id
          ? _value.device_id
          : device_id // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as int?,
      battery_pct: freezed == battery_pct
          ? _value.battery_pct
          : battery_pct // ignore: cast_nullable_to_non_nullable
              as double?,
      app_version: freezed == app_version
          ? _value.app_version
          : app_version // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiSessionImplCopyWith<$Res>
    implements $ApiSessionCopyWith<$Res> {
  factory _$$ApiSessionImplCopyWith(
          _$ApiSessionImpl value, $Res Function(_$ApiSessionImpl) then) =
      __$$ApiSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String user_id,
      int? platform,
      String? fcm_token,
      bool session_active,
      String? device_name,
      String? device_id,
      int? created_at,
      double? battery_pct,
      int? app_version});
}

/// @nodoc
class __$$ApiSessionImplCopyWithImpl<$Res>
    extends _$ApiSessionCopyWithImpl<$Res, _$ApiSessionImpl>
    implements _$$ApiSessionImplCopyWith<$Res> {
  __$$ApiSessionImplCopyWithImpl(
      _$ApiSessionImpl _value, $Res Function(_$ApiSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user_id = null,
    Object? platform = freezed,
    Object? fcm_token = freezed,
    Object? session_active = null,
    Object? device_name = freezed,
    Object? device_id = freezed,
    Object? created_at = freezed,
    Object? battery_pct = freezed,
    Object? app_version = freezed,
  }) {
    return _then(_$ApiSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as int?,
      fcm_token: freezed == fcm_token
          ? _value.fcm_token
          : fcm_token // ignore: cast_nullable_to_non_nullable
              as String?,
      session_active: null == session_active
          ? _value.session_active
          : session_active // ignore: cast_nullable_to_non_nullable
              as bool,
      device_name: freezed == device_name
          ? _value.device_name
          : device_name // ignore: cast_nullable_to_non_nullable
              as String?,
      device_id: freezed == device_id
          ? _value.device_id
          : device_id // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as int?,
      battery_pct: freezed == battery_pct
          ? _value.battery_pct
          : battery_pct // ignore: cast_nullable_to_non_nullable
              as double?,
      app_version: freezed == app_version
          ? _value.app_version
          : app_version // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiSessionImpl extends _ApiSession {
  const _$ApiSessionImpl(
      {required this.id,
      required this.user_id,
      this.platform = 1,
      this.fcm_token = "",
      required this.session_active,
      this.device_name,
      this.device_id,
      this.created_at,
      this.battery_pct,
      this.app_version})
      : super._();

  factory _$ApiSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String user_id;
  @override
  @JsonKey()
  final int? platform;
  @override
  @JsonKey()
  final String? fcm_token;
  @override
  final bool session_active;
  @override
  final String? device_name;
  @override
  final String? device_id;
  @override
  final int? created_at;
  @override
  final double? battery_pct;
  @override
  final int? app_version;

  @override
  String toString() {
    return 'ApiSession(id: $id, user_id: $user_id, platform: $platform, fcm_token: $fcm_token, session_active: $session_active, device_name: $device_name, device_id: $device_id, created_at: $created_at, battery_pct: $battery_pct, app_version: $app_version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.fcm_token, fcm_token) ||
                other.fcm_token == fcm_token) &&
            (identical(other.session_active, session_active) ||
                other.session_active == session_active) &&
            (identical(other.device_name, device_name) ||
                other.device_name == device_name) &&
            (identical(other.device_id, device_id) ||
                other.device_id == device_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.battery_pct, battery_pct) ||
                other.battery_pct == battery_pct) &&
            (identical(other.app_version, app_version) ||
                other.app_version == app_version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      user_id,
      platform,
      fcm_token,
      session_active,
      device_name,
      device_id,
      created_at,
      battery_pct,
      app_version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiSessionImplCopyWith<_$ApiSessionImpl> get copyWith =>
      __$$ApiSessionImplCopyWithImpl<_$ApiSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiSessionImplToJson(
      this,
    );
  }
}

abstract class _ApiSession extends ApiSession {
  const factory _ApiSession(
      {required final String id,
      required final String user_id,
      final int? platform,
      final String? fcm_token,
      required final bool session_active,
      final String? device_name,
      final String? device_id,
      final int? created_at,
      final double? battery_pct,
      final int? app_version}) = _$ApiSessionImpl;
  const _ApiSession._() : super._();

  factory _ApiSession.fromJson(Map<String, dynamic> json) =
      _$ApiSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get user_id;
  @override
  int? get platform;
  @override
  String? get fcm_token;
  @override
  bool get session_active;
  @override
  String? get device_name;
  @override
  String? get device_id;
  @override
  int? get created_at;
  @override
  double? get battery_pct;
  @override
  int? get app_version;
  @override
  @JsonKey(ignore: true)
  _$$ApiSessionImplCopyWith<_$ApiSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiUserInfo _$ApiUserInfoFromJson(Map<String, dynamic> json) {
  return _ApiUserInfo.fromJson(json);
}

/// @nodoc
mixin _$ApiUserInfo {
  ApiUser get user => throw _privateConstructorUsedError;
  ApiLocation? get location => throw _privateConstructorUsedError;
  bool get isLocationEnabled => throw _privateConstructorUsedError;
  ApiSession? get session => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiUserInfoCopyWith<ApiUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiUserInfoCopyWith<$Res> {
  factory $ApiUserInfoCopyWith(
          ApiUserInfo value, $Res Function(ApiUserInfo) then) =
      _$ApiUserInfoCopyWithImpl<$Res, ApiUserInfo>;
  @useResult
  $Res call(
      {ApiUser user,
      ApiLocation? location,
      bool isLocationEnabled,
      ApiSession? session});

  $ApiUserCopyWith<$Res> get user;
  $ApiLocationCopyWith<$Res>? get location;
  $ApiSessionCopyWith<$Res>? get session;
}

/// @nodoc
class _$ApiUserInfoCopyWithImpl<$Res, $Val extends ApiUserInfo>
    implements $ApiUserInfoCopyWith<$Res> {
  _$ApiUserInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? location = freezed,
    Object? isLocationEnabled = null,
    Object? session = freezed,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ApiUser,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as ApiLocation?,
      isLocationEnabled: null == isLocationEnabled
          ? _value.isLocationEnabled
          : isLocationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      session: freezed == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as ApiSession?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ApiUserCopyWith<$Res> get user {
    return $ApiUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ApiLocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $ApiLocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ApiSessionCopyWith<$Res>? get session {
    if (_value.session == null) {
      return null;
    }

    return $ApiSessionCopyWith<$Res>(_value.session!, (value) {
      return _then(_value.copyWith(session: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiUserInfoImplCopyWith<$Res>
    implements $ApiUserInfoCopyWith<$Res> {
  factory _$$ApiUserInfoImplCopyWith(
          _$ApiUserInfoImpl value, $Res Function(_$ApiUserInfoImpl) then) =
      __$$ApiUserInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ApiUser user,
      ApiLocation? location,
      bool isLocationEnabled,
      ApiSession? session});

  @override
  $ApiUserCopyWith<$Res> get user;
  @override
  $ApiLocationCopyWith<$Res>? get location;
  @override
  $ApiSessionCopyWith<$Res>? get session;
}

/// @nodoc
class __$$ApiUserInfoImplCopyWithImpl<$Res>
    extends _$ApiUserInfoCopyWithImpl<$Res, _$ApiUserInfoImpl>
    implements _$$ApiUserInfoImplCopyWith<$Res> {
  __$$ApiUserInfoImplCopyWithImpl(
      _$ApiUserInfoImpl _value, $Res Function(_$ApiUserInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? location = freezed,
    Object? isLocationEnabled = null,
    Object? session = freezed,
  }) {
    return _then(_$ApiUserInfoImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ApiUser,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as ApiLocation?,
      isLocationEnabled: null == isLocationEnabled
          ? _value.isLocationEnabled
          : isLocationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      session: freezed == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as ApiSession?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiUserInfoImpl extends _ApiUserInfo {
  const _$ApiUserInfoImpl(
      {required this.user,
      this.location,
      required this.isLocationEnabled,
      this.session})
      : super._();

  factory _$ApiUserInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiUserInfoImplFromJson(json);

  @override
  final ApiUser user;
  @override
  final ApiLocation? location;
  @override
  final bool isLocationEnabled;
  @override
  final ApiSession? session;

  @override
  String toString() {
    return 'ApiUserInfo(user: $user, location: $location, isLocationEnabled: $isLocationEnabled, session: $session)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiUserInfoImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.isLocationEnabled, isLocationEnabled) ||
                other.isLocationEnabled == isLocationEnabled) &&
            (identical(other.session, session) || other.session == session));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, user, location, isLocationEnabled, session);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiUserInfoImplCopyWith<_$ApiUserInfoImpl> get copyWith =>
      __$$ApiUserInfoImplCopyWithImpl<_$ApiUserInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiUserInfoImplToJson(
      this,
    );
  }
}

abstract class _ApiUserInfo extends ApiUserInfo {
  const factory _ApiUserInfo(
      {required final ApiUser user,
      final ApiLocation? location,
      required final bool isLocationEnabled,
      final ApiSession? session}) = _$ApiUserInfoImpl;
  const _ApiUserInfo._() : super._();

  factory _ApiUserInfo.fromJson(Map<String, dynamic> json) =
      _$ApiUserInfoImpl.fromJson;

  @override
  ApiUser get user;
  @override
  ApiLocation? get location;
  @override
  bool get isLocationEnabled;
  @override
  ApiSession? get session;
  @override
  @JsonKey(ignore: true)
  _$$ApiUserInfoImplCopyWith<_$ApiUserInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
