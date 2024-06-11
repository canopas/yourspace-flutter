// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiThread _$ApiThreadFromJson(Map<String, dynamic> json) {
  return _ApiThread.fromJson(json);
}

/// @nodoc
mixin _$ApiThread {
  String get id => throw _privateConstructorUsedError;
  String get space_id => throw _privateConstructorUsedError;
  String get admin_id => throw _privateConstructorUsedError;
  List<String> get member_ids => throw _privateConstructorUsedError;
  Map<String, double>? get archived_for => throw _privateConstructorUsedError;
  int? get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiThreadCopyWith<ApiThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiThreadCopyWith<$Res> {
  factory $ApiThreadCopyWith(ApiThread value, $Res Function(ApiThread) then) =
      _$ApiThreadCopyWithImpl<$Res, ApiThread>;
  @useResult
  $Res call(
      {String id,
      String space_id,
      String admin_id,
      List<String> member_ids,
      Map<String, double>? archived_for,
      int? created_at});
}

/// @nodoc
class _$ApiThreadCopyWithImpl<$Res, $Val extends ApiThread>
    implements $ApiThreadCopyWith<$Res> {
  _$ApiThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? space_id = null,
    Object? admin_id = null,
    Object? member_ids = null,
    Object? archived_for = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      space_id: null == space_id
          ? _value.space_id
          : space_id // ignore: cast_nullable_to_non_nullable
              as String,
      admin_id: null == admin_id
          ? _value.admin_id
          : admin_id // ignore: cast_nullable_to_non_nullable
              as String,
      member_ids: null == member_ids
          ? _value.member_ids
          : member_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      archived_for: freezed == archived_for
          ? _value.archived_for
          : archived_for // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiThreadImplCopyWith<$Res>
    implements $ApiThreadCopyWith<$Res> {
  factory _$$ApiThreadImplCopyWith(
          _$ApiThreadImpl value, $Res Function(_$ApiThreadImpl) then) =
      __$$ApiThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String space_id,
      String admin_id,
      List<String> member_ids,
      Map<String, double>? archived_for,
      int? created_at});
}

/// @nodoc
class __$$ApiThreadImplCopyWithImpl<$Res>
    extends _$ApiThreadCopyWithImpl<$Res, _$ApiThreadImpl>
    implements _$$ApiThreadImplCopyWith<$Res> {
  __$$ApiThreadImplCopyWithImpl(
      _$ApiThreadImpl _value, $Res Function(_$ApiThreadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? space_id = null,
    Object? admin_id = null,
    Object? member_ids = null,
    Object? archived_for = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_$ApiThreadImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      space_id: null == space_id
          ? _value.space_id
          : space_id // ignore: cast_nullable_to_non_nullable
              as String,
      admin_id: null == admin_id
          ? _value.admin_id
          : admin_id // ignore: cast_nullable_to_non_nullable
              as String,
      member_ids: null == member_ids
          ? _value._member_ids
          : member_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      archived_for: freezed == archived_for
          ? _value._archived_for
          : archived_for // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiThreadImpl extends _ApiThread {
  const _$ApiThreadImpl(
      {required this.id,
      required this.space_id,
      required this.admin_id,
      required final List<String> member_ids,
      final Map<String, double>? archived_for,
      this.created_at})
      : _member_ids = member_ids,
        _archived_for = archived_for,
        super._();

  factory _$ApiThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiThreadImplFromJson(json);

  @override
  final String id;
  @override
  final String space_id;
  @override
  final String admin_id;
  final List<String> _member_ids;
  @override
  List<String> get member_ids {
    if (_member_ids is EqualUnmodifiableListView) return _member_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_member_ids);
  }

  final Map<String, double>? _archived_for;
  @override
  Map<String, double>? get archived_for {
    final value = _archived_for;
    if (value == null) return null;
    if (_archived_for is EqualUnmodifiableMapView) return _archived_for;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? created_at;

  @override
  String toString() {
    return 'ApiThread(id: $id, space_id: $space_id, admin_id: $admin_id, member_ids: $member_ids, archived_for: $archived_for, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.space_id, space_id) ||
                other.space_id == space_id) &&
            (identical(other.admin_id, admin_id) ||
                other.admin_id == admin_id) &&
            const DeepCollectionEquality()
                .equals(other._member_ids, _member_ids) &&
            const DeepCollectionEquality()
                .equals(other._archived_for, _archived_for) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      space_id,
      admin_id,
      const DeepCollectionEquality().hash(_member_ids),
      const DeepCollectionEquality().hash(_archived_for),
      created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiThreadImplCopyWith<_$ApiThreadImpl> get copyWith =>
      __$$ApiThreadImplCopyWithImpl<_$ApiThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiThreadImplToJson(
      this,
    );
  }
}

abstract class _ApiThread extends ApiThread {
  const factory _ApiThread(
      {required final String id,
      required final String space_id,
      required final String admin_id,
      required final List<String> member_ids,
      final Map<String, double>? archived_for,
      final int? created_at}) = _$ApiThreadImpl;
  const _ApiThread._() : super._();

  factory _ApiThread.fromJson(Map<String, dynamic> json) =
      _$ApiThreadImpl.fromJson;

  @override
  String get id;
  @override
  String get space_id;
  @override
  String get admin_id;
  @override
  List<String> get member_ids;
  @override
  Map<String, double>? get archived_for;
  @override
  int? get created_at;
  @override
  @JsonKey(ignore: true)
  _$$ApiThreadImplCopyWith<_$ApiThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiThreadMessage _$ApiThreadMessageFromJson(Map<String, dynamic> json) {
  return _ApiThreadMessage.fromJson(json);
}

/// @nodoc
mixin _$ApiThreadMessage {
  String get id => throw _privateConstructorUsedError;
  String get thread_id => throw _privateConstructorUsedError;
  String get sender_id => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<String> get seen_by => throw _privateConstructorUsedError;
  Map<String, double>? get archived_for => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiThreadMessageCopyWith<ApiThreadMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiThreadMessageCopyWith<$Res> {
  factory $ApiThreadMessageCopyWith(
          ApiThreadMessage value, $Res Function(ApiThreadMessage) then) =
      _$ApiThreadMessageCopyWithImpl<$Res, ApiThreadMessage>;
  @useResult
  $Res call(
      {String id,
      String thread_id,
      String sender_id,
      String? message,
      List<String> seen_by,
      Map<String, double>? archived_for,
      DateTime? created_at});
}

/// @nodoc
class _$ApiThreadMessageCopyWithImpl<$Res, $Val extends ApiThreadMessage>
    implements $ApiThreadMessageCopyWith<$Res> {
  _$ApiThreadMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? thread_id = null,
    Object? sender_id = null,
    Object? message = freezed,
    Object? seen_by = null,
    Object? archived_for = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      thread_id: null == thread_id
          ? _value.thread_id
          : thread_id // ignore: cast_nullable_to_non_nullable
              as String,
      sender_id: null == sender_id
          ? _value.sender_id
          : sender_id // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      seen_by: null == seen_by
          ? _value.seen_by
          : seen_by // ignore: cast_nullable_to_non_nullable
              as List<String>,
      archived_for: freezed == archived_for
          ? _value.archived_for
          : archived_for // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiThreadMessageImplCopyWith<$Res>
    implements $ApiThreadMessageCopyWith<$Res> {
  factory _$$ApiThreadMessageImplCopyWith(_$ApiThreadMessageImpl value,
          $Res Function(_$ApiThreadMessageImpl) then) =
      __$$ApiThreadMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String thread_id,
      String sender_id,
      String? message,
      List<String> seen_by,
      Map<String, double>? archived_for,
      DateTime? created_at});
}

/// @nodoc
class __$$ApiThreadMessageImplCopyWithImpl<$Res>
    extends _$ApiThreadMessageCopyWithImpl<$Res, _$ApiThreadMessageImpl>
    implements _$$ApiThreadMessageImplCopyWith<$Res> {
  __$$ApiThreadMessageImplCopyWithImpl(_$ApiThreadMessageImpl _value,
      $Res Function(_$ApiThreadMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? thread_id = null,
    Object? sender_id = null,
    Object? message = freezed,
    Object? seen_by = null,
    Object? archived_for = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_$ApiThreadMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      thread_id: null == thread_id
          ? _value.thread_id
          : thread_id // ignore: cast_nullable_to_non_nullable
              as String,
      sender_id: null == sender_id
          ? _value.sender_id
          : sender_id // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      seen_by: null == seen_by
          ? _value._seen_by
          : seen_by // ignore: cast_nullable_to_non_nullable
              as List<String>,
      archived_for: freezed == archived_for
          ? _value._archived_for
          : archived_for // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiThreadMessageImpl extends _ApiThreadMessage {
  const _$ApiThreadMessageImpl(
      {required this.id,
      required this.thread_id,
      required this.sender_id,
      this.message,
      required final List<String> seen_by,
      final Map<String, double>? archived_for,
      this.created_at})
      : _seen_by = seen_by,
        _archived_for = archived_for,
        super._();

  factory _$ApiThreadMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiThreadMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String thread_id;
  @override
  final String sender_id;
  @override
  final String? message;
  final List<String> _seen_by;
  @override
  List<String> get seen_by {
    if (_seen_by is EqualUnmodifiableListView) return _seen_by;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seen_by);
  }

  final Map<String, double>? _archived_for;
  @override
  Map<String, double>? get archived_for {
    final value = _archived_for;
    if (value == null) return null;
    if (_archived_for is EqualUnmodifiableMapView) return _archived_for;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? created_at;

  @override
  String toString() {
    return 'ApiThreadMessage(id: $id, thread_id: $thread_id, sender_id: $sender_id, message: $message, seen_by: $seen_by, archived_for: $archived_for, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiThreadMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.thread_id, thread_id) ||
                other.thread_id == thread_id) &&
            (identical(other.sender_id, sender_id) ||
                other.sender_id == sender_id) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._seen_by, _seen_by) &&
            const DeepCollectionEquality()
                .equals(other._archived_for, _archived_for) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      thread_id,
      sender_id,
      message,
      const DeepCollectionEquality().hash(_seen_by),
      const DeepCollectionEquality().hash(_archived_for),
      created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiThreadMessageImplCopyWith<_$ApiThreadMessageImpl> get copyWith =>
      __$$ApiThreadMessageImplCopyWithImpl<_$ApiThreadMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiThreadMessageImplToJson(
      this,
    );
  }
}

abstract class _ApiThreadMessage extends ApiThreadMessage {
  const factory _ApiThreadMessage(
      {required final String id,
      required final String thread_id,
      required final String sender_id,
      final String? message,
      required final List<String> seen_by,
      final Map<String, double>? archived_for,
      final DateTime? created_at}) = _$ApiThreadMessageImpl;
  const _ApiThreadMessage._() : super._();

  factory _ApiThreadMessage.fromJson(Map<String, dynamic> json) =
      _$ApiThreadMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get thread_id;
  @override
  String get sender_id;
  @override
  String? get message;
  @override
  List<String> get seen_by;
  @override
  Map<String, double>? get archived_for;
  @override
  DateTime? get created_at;
  @override
  @JsonKey(ignore: true)
  _$$ApiThreadMessageImplCopyWith<_$ApiThreadMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ThreadInfo _$ThreadInfoFromJson(Map<String, dynamic> json) {
  return _ThreadInfo.fromJson(json);
}

/// @nodoc
mixin _$ThreadInfo {
  ApiThread get thread => throw _privateConstructorUsedError;
  List<ApiUserInfo> get members => throw _privateConstructorUsedError;
  List<ApiThreadMessage> get threadMessage =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThreadInfoCopyWith<ThreadInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreadInfoCopyWith<$Res> {
  factory $ThreadInfoCopyWith(
          ThreadInfo value, $Res Function(ThreadInfo) then) =
      _$ThreadInfoCopyWithImpl<$Res, ThreadInfo>;
  @useResult
  $Res call(
      {ApiThread thread,
      List<ApiUserInfo> members,
      List<ApiThreadMessage> threadMessage});

  $ApiThreadCopyWith<$Res> get thread;
}

/// @nodoc
class _$ThreadInfoCopyWithImpl<$Res, $Val extends ThreadInfo>
    implements $ThreadInfoCopyWith<$Res> {
  _$ThreadInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thread = null,
    Object? members = null,
    Object? threadMessage = null,
  }) {
    return _then(_value.copyWith(
      thread: null == thread
          ? _value.thread
          : thread // ignore: cast_nullable_to_non_nullable
              as ApiThread,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<ApiUserInfo>,
      threadMessage: null == threadMessage
          ? _value.threadMessage
          : threadMessage // ignore: cast_nullable_to_non_nullable
              as List<ApiThreadMessage>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ApiThreadCopyWith<$Res> get thread {
    return $ApiThreadCopyWith<$Res>(_value.thread, (value) {
      return _then(_value.copyWith(thread: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ThreadInfoImplCopyWith<$Res>
    implements $ThreadInfoCopyWith<$Res> {
  factory _$$ThreadInfoImplCopyWith(
          _$ThreadInfoImpl value, $Res Function(_$ThreadInfoImpl) then) =
      __$$ThreadInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ApiThread thread,
      List<ApiUserInfo> members,
      List<ApiThreadMessage> threadMessage});

  @override
  $ApiThreadCopyWith<$Res> get thread;
}

/// @nodoc
class __$$ThreadInfoImplCopyWithImpl<$Res>
    extends _$ThreadInfoCopyWithImpl<$Res, _$ThreadInfoImpl>
    implements _$$ThreadInfoImplCopyWith<$Res> {
  __$$ThreadInfoImplCopyWithImpl(
      _$ThreadInfoImpl _value, $Res Function(_$ThreadInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thread = null,
    Object? members = null,
    Object? threadMessage = null,
  }) {
    return _then(_$ThreadInfoImpl(
      thread: null == thread
          ? _value.thread
          : thread // ignore: cast_nullable_to_non_nullable
              as ApiThread,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<ApiUserInfo>,
      threadMessage: null == threadMessage
          ? _value._threadMessage
          : threadMessage // ignore: cast_nullable_to_non_nullable
              as List<ApiThreadMessage>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreadInfoImpl extends _ThreadInfo {
  const _$ThreadInfoImpl(
      {required this.thread,
      required final List<ApiUserInfo> members,
      required final List<ApiThreadMessage> threadMessage})
      : _members = members,
        _threadMessage = threadMessage,
        super._();

  factory _$ThreadInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreadInfoImplFromJson(json);

  @override
  final ApiThread thread;
  final List<ApiUserInfo> _members;
  @override
  List<ApiUserInfo> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  final List<ApiThreadMessage> _threadMessage;
  @override
  List<ApiThreadMessage> get threadMessage {
    if (_threadMessage is EqualUnmodifiableListView) return _threadMessage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_threadMessage);
  }

  @override
  String toString() {
    return 'ThreadInfo(thread: $thread, members: $members, threadMessage: $threadMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreadInfoImpl &&
            (identical(other.thread, thread) || other.thread == thread) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality()
                .equals(other._threadMessage, _threadMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      thread,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(_threadMessage));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreadInfoImplCopyWith<_$ThreadInfoImpl> get copyWith =>
      __$$ThreadInfoImplCopyWithImpl<_$ThreadInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreadInfoImplToJson(
      this,
    );
  }
}

abstract class _ThreadInfo extends ThreadInfo {
  const factory _ThreadInfo(
      {required final ApiThread thread,
      required final List<ApiUserInfo> members,
      required final List<ApiThreadMessage> threadMessage}) = _$ThreadInfoImpl;
  const _ThreadInfo._() : super._();

  factory _ThreadInfo.fromJson(Map<String, dynamic> json) =
      _$ThreadInfoImpl.fromJson;

  @override
  ApiThread get thread;
  @override
  List<ApiUserInfo> get members;
  @override
  List<ApiThreadMessage> get threadMessage;
  @override
  @JsonKey(ignore: true)
  _$$ThreadInfoImplCopyWith<_$ThreadInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
