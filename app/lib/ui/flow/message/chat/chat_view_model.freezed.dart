// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatViewState {
  bool get loading => throw _privateConstructorUsedError;
  bool get loadingMessages => throw _privateConstructorUsedError;
  bool get messageSending => throw _privateConstructorUsedError;
  bool get allowSend => throw _privateConstructorUsedError;
  bool get showMemberSelectionView => throw _privateConstructorUsedError;
  bool get isNewThread => throw _privateConstructorUsedError;
  List<ApiUserInfo> get users => throw _privateConstructorUsedError;
  String get threadId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  TextEditingController get message => throw _privateConstructorUsedError;
  List<ApiThreadMessage> get messages => throw _privateConstructorUsedError;
  List<ApiUserInfo> get sender => throw _privateConstructorUsedError;
  List<String> get selectedMember => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  SpaceInfo? get spaceInfo => throw _privateConstructorUsedError;
  ThreadInfo? get threadInfo => throw _privateConstructorUsedError;
  String get currentUserId => throw _privateConstructorUsedError;
  List<ThreadInfo> get threadList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatViewStateCopyWith<ChatViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatViewStateCopyWith<$Res> {
  factory $ChatViewStateCopyWith(
          ChatViewState value, $Res Function(ChatViewState) then) =
      _$ChatViewStateCopyWithImpl<$Res, ChatViewState>;
  @useResult
  $Res call(
      {bool loading,
      bool loadingMessages,
      bool messageSending,
      bool allowSend,
      bool showMemberSelectionView,
      bool isNewThread,
      List<ApiUserInfo> users,
      String threadId,
      String title,
      TextEditingController message,
      List<ApiThreadMessage> messages,
      List<ApiUserInfo> sender,
      List<String> selectedMember,
      Object? error,
      SpaceInfo? spaceInfo,
      ThreadInfo? threadInfo,
      String currentUserId,
      List<ThreadInfo> threadList});

  $SpaceInfoCopyWith<$Res>? get spaceInfo;
  $ThreadInfoCopyWith<$Res>? get threadInfo;
}

/// @nodoc
class _$ChatViewStateCopyWithImpl<$Res, $Val extends ChatViewState>
    implements $ChatViewStateCopyWith<$Res> {
  _$ChatViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? loadingMessages = null,
    Object? messageSending = null,
    Object? allowSend = null,
    Object? showMemberSelectionView = null,
    Object? isNewThread = null,
    Object? users = null,
    Object? threadId = null,
    Object? title = null,
    Object? message = null,
    Object? messages = null,
    Object? sender = null,
    Object? selectedMember = null,
    Object? error = freezed,
    Object? spaceInfo = freezed,
    Object? threadInfo = freezed,
    Object? currentUserId = null,
    Object? threadList = null,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingMessages: null == loadingMessages
          ? _value.loadingMessages
          : loadingMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      messageSending: null == messageSending
          ? _value.messageSending
          : messageSending // ignore: cast_nullable_to_non_nullable
              as bool,
      allowSend: null == allowSend
          ? _value.allowSend
          : allowSend // ignore: cast_nullable_to_non_nullable
              as bool,
      showMemberSelectionView: null == showMemberSelectionView
          ? _value.showMemberSelectionView
          : showMemberSelectionView // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewThread: null == isNewThread
          ? _value.isNewThread
          : isNewThread // ignore: cast_nullable_to_non_nullable
              as bool,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<ApiUserInfo>,
      threadId: null == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ApiThreadMessage>,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as List<ApiUserInfo>,
      selectedMember: null == selectedMember
          ? _value.selectedMember
          : selectedMember // ignore: cast_nullable_to_non_nullable
              as List<String>,
      error: freezed == error ? _value.error : error,
      spaceInfo: freezed == spaceInfo
          ? _value.spaceInfo
          : spaceInfo // ignore: cast_nullable_to_non_nullable
              as SpaceInfo?,
      threadInfo: freezed == threadInfo
          ? _value.threadInfo
          : threadInfo // ignore: cast_nullable_to_non_nullable
              as ThreadInfo?,
      currentUserId: null == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String,
      threadList: null == threadList
          ? _value.threadList
          : threadList // ignore: cast_nullable_to_non_nullable
              as List<ThreadInfo>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SpaceInfoCopyWith<$Res>? get spaceInfo {
    if (_value.spaceInfo == null) {
      return null;
    }

    return $SpaceInfoCopyWith<$Res>(_value.spaceInfo!, (value) {
      return _then(_value.copyWith(spaceInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ThreadInfoCopyWith<$Res>? get threadInfo {
    if (_value.threadInfo == null) {
      return null;
    }

    return $ThreadInfoCopyWith<$Res>(_value.threadInfo!, (value) {
      return _then(_value.copyWith(threadInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatViewStateImplCopyWith<$Res>
    implements $ChatViewStateCopyWith<$Res> {
  factory _$$ChatViewStateImplCopyWith(
          _$ChatViewStateImpl value, $Res Function(_$ChatViewStateImpl) then) =
      __$$ChatViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      bool loadingMessages,
      bool messageSending,
      bool allowSend,
      bool showMemberSelectionView,
      bool isNewThread,
      List<ApiUserInfo> users,
      String threadId,
      String title,
      TextEditingController message,
      List<ApiThreadMessage> messages,
      List<ApiUserInfo> sender,
      List<String> selectedMember,
      Object? error,
      SpaceInfo? spaceInfo,
      ThreadInfo? threadInfo,
      String currentUserId,
      List<ThreadInfo> threadList});

  @override
  $SpaceInfoCopyWith<$Res>? get spaceInfo;
  @override
  $ThreadInfoCopyWith<$Res>? get threadInfo;
}

/// @nodoc
class __$$ChatViewStateImplCopyWithImpl<$Res>
    extends _$ChatViewStateCopyWithImpl<$Res, _$ChatViewStateImpl>
    implements _$$ChatViewStateImplCopyWith<$Res> {
  __$$ChatViewStateImplCopyWithImpl(
      _$ChatViewStateImpl _value, $Res Function(_$ChatViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? loadingMessages = null,
    Object? messageSending = null,
    Object? allowSend = null,
    Object? showMemberSelectionView = null,
    Object? isNewThread = null,
    Object? users = null,
    Object? threadId = null,
    Object? title = null,
    Object? message = null,
    Object? messages = null,
    Object? sender = null,
    Object? selectedMember = null,
    Object? error = freezed,
    Object? spaceInfo = freezed,
    Object? threadInfo = freezed,
    Object? currentUserId = null,
    Object? threadList = null,
  }) {
    return _then(_$ChatViewStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingMessages: null == loadingMessages
          ? _value.loadingMessages
          : loadingMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      messageSending: null == messageSending
          ? _value.messageSending
          : messageSending // ignore: cast_nullable_to_non_nullable
              as bool,
      allowSend: null == allowSend
          ? _value.allowSend
          : allowSend // ignore: cast_nullable_to_non_nullable
              as bool,
      showMemberSelectionView: null == showMemberSelectionView
          ? _value.showMemberSelectionView
          : showMemberSelectionView // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewThread: null == isNewThread
          ? _value.isNewThread
          : isNewThread // ignore: cast_nullable_to_non_nullable
              as bool,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<ApiUserInfo>,
      threadId: null == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ApiThreadMessage>,
      sender: null == sender
          ? _value._sender
          : sender // ignore: cast_nullable_to_non_nullable
              as List<ApiUserInfo>,
      selectedMember: null == selectedMember
          ? _value._selectedMember
          : selectedMember // ignore: cast_nullable_to_non_nullable
              as List<String>,
      error: freezed == error ? _value.error : error,
      spaceInfo: freezed == spaceInfo
          ? _value.spaceInfo
          : spaceInfo // ignore: cast_nullable_to_non_nullable
              as SpaceInfo?,
      threadInfo: freezed == threadInfo
          ? _value.threadInfo
          : threadInfo // ignore: cast_nullable_to_non_nullable
              as ThreadInfo?,
      currentUserId: null == currentUserId
          ? _value.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String,
      threadList: null == threadList
          ? _value._threadList
          : threadList // ignore: cast_nullable_to_non_nullable
              as List<ThreadInfo>,
    ));
  }
}

/// @nodoc

class _$ChatViewStateImpl implements _ChatViewState {
  const _$ChatViewStateImpl(
      {this.loading = false,
      this.loadingMessages = false,
      this.messageSending = false,
      this.allowSend = false,
      this.showMemberSelectionView = false,
      this.isNewThread = false,
      final List<ApiUserInfo> users = const [],
      this.threadId = '',
      this.title = '',
      required this.message,
      final List<ApiThreadMessage> messages = const [],
      final List<ApiUserInfo> sender = const [],
      final List<String> selectedMember = const [],
      this.error,
      this.spaceInfo,
      this.threadInfo,
      required this.currentUserId,
      final List<ThreadInfo> threadList = const []})
      : _users = users,
        _messages = messages,
        _sender = sender,
        _selectedMember = selectedMember,
        _threadList = threadList;

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool loadingMessages;
  @override
  @JsonKey()
  final bool messageSending;
  @override
  @JsonKey()
  final bool allowSend;
  @override
  @JsonKey()
  final bool showMemberSelectionView;
  @override
  @JsonKey()
  final bool isNewThread;
  final List<ApiUserInfo> _users;
  @override
  @JsonKey()
  List<ApiUserInfo> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey()
  final String threadId;
  @override
  @JsonKey()
  final String title;
  @override
  final TextEditingController message;
  final List<ApiThreadMessage> _messages;
  @override
  @JsonKey()
  List<ApiThreadMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  final List<ApiUserInfo> _sender;
  @override
  @JsonKey()
  List<ApiUserInfo> get sender {
    if (_sender is EqualUnmodifiableListView) return _sender;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sender);
  }

  final List<String> _selectedMember;
  @override
  @JsonKey()
  List<String> get selectedMember {
    if (_selectedMember is EqualUnmodifiableListView) return _selectedMember;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedMember);
  }

  @override
  final Object? error;
  @override
  final SpaceInfo? spaceInfo;
  @override
  final ThreadInfo? threadInfo;
  @override
  final String currentUserId;
  final List<ThreadInfo> _threadList;
  @override
  @JsonKey()
  List<ThreadInfo> get threadList {
    if (_threadList is EqualUnmodifiableListView) return _threadList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_threadList);
  }

  @override
  String toString() {
    return 'ChatViewState(loading: $loading, loadingMessages: $loadingMessages, messageSending: $messageSending, allowSend: $allowSend, showMemberSelectionView: $showMemberSelectionView, isNewThread: $isNewThread, users: $users, threadId: $threadId, title: $title, message: $message, messages: $messages, sender: $sender, selectedMember: $selectedMember, error: $error, spaceInfo: $spaceInfo, threadInfo: $threadInfo, currentUserId: $currentUserId, threadList: $threadList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatViewStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.loadingMessages, loadingMessages) ||
                other.loadingMessages == loadingMessages) &&
            (identical(other.messageSending, messageSending) ||
                other.messageSending == messageSending) &&
            (identical(other.allowSend, allowSend) ||
                other.allowSend == allowSend) &&
            (identical(
                    other.showMemberSelectionView, showMemberSelectionView) ||
                other.showMemberSelectionView == showMemberSelectionView) &&
            (identical(other.isNewThread, isNewThread) ||
                other.isNewThread == isNewThread) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality().equals(other._sender, _sender) &&
            const DeepCollectionEquality()
                .equals(other._selectedMember, _selectedMember) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.spaceInfo, spaceInfo) ||
                other.spaceInfo == spaceInfo) &&
            (identical(other.threadInfo, threadInfo) ||
                other.threadInfo == threadInfo) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            const DeepCollectionEquality()
                .equals(other._threadList, _threadList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      loadingMessages,
      messageSending,
      allowSend,
      showMemberSelectionView,
      isNewThread,
      const DeepCollectionEquality().hash(_users),
      threadId,
      title,
      message,
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(_sender),
      const DeepCollectionEquality().hash(_selectedMember),
      const DeepCollectionEquality().hash(error),
      spaceInfo,
      threadInfo,
      currentUserId,
      const DeepCollectionEquality().hash(_threadList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatViewStateImplCopyWith<_$ChatViewStateImpl> get copyWith =>
      __$$ChatViewStateImplCopyWithImpl<_$ChatViewStateImpl>(this, _$identity);
}

abstract class _ChatViewState implements ChatViewState {
  const factory _ChatViewState(
      {final bool loading,
      final bool loadingMessages,
      final bool messageSending,
      final bool allowSend,
      final bool showMemberSelectionView,
      final bool isNewThread,
      final List<ApiUserInfo> users,
      final String threadId,
      final String title,
      required final TextEditingController message,
      final List<ApiThreadMessage> messages,
      final List<ApiUserInfo> sender,
      final List<String> selectedMember,
      final Object? error,
      final SpaceInfo? spaceInfo,
      final ThreadInfo? threadInfo,
      required final String currentUserId,
      final List<ThreadInfo> threadList}) = _$ChatViewStateImpl;

  @override
  bool get loading;
  @override
  bool get loadingMessages;
  @override
  bool get messageSending;
  @override
  bool get allowSend;
  @override
  bool get showMemberSelectionView;
  @override
  bool get isNewThread;
  @override
  List<ApiUserInfo> get users;
  @override
  String get threadId;
  @override
  String get title;
  @override
  TextEditingController get message;
  @override
  List<ApiThreadMessage> get messages;
  @override
  List<ApiUserInfo> get sender;
  @override
  List<String> get selectedMember;
  @override
  Object? get error;
  @override
  SpaceInfo? get spaceInfo;
  @override
  ThreadInfo? get threadInfo;
  @override
  String get currentUserId;
  @override
  List<ThreadInfo> get threadList;
  @override
  @JsonKey(ignore: true)
  _$$ChatViewStateImplCopyWith<_$ChatViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
