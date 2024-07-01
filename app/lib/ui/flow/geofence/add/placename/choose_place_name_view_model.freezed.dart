// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'choose_place_name_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChoosePlaceViewState {
  dynamic get addingPlace => throw _privateConstructorUsedError;
  List<String>? get suggestions => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  DateTime? get popToPlaceList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChoosePlaceViewStateCopyWith<ChoosePlaceViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChoosePlaceViewStateCopyWith<$Res> {
  factory $ChoosePlaceViewStateCopyWith(ChoosePlaceViewState value,
          $Res Function(ChoosePlaceViewState) then) =
      _$ChoosePlaceViewStateCopyWithImpl<$Res, ChoosePlaceViewState>;
  @useResult
  $Res call(
      {dynamic addingPlace,
      List<String>? suggestions,
      Object? error,
      DateTime? popToPlaceList});
}

/// @nodoc
class _$ChoosePlaceViewStateCopyWithImpl<$Res,
        $Val extends ChoosePlaceViewState>
    implements $ChoosePlaceViewStateCopyWith<$Res> {
  _$ChoosePlaceViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addingPlace = freezed,
    Object? suggestions = freezed,
    Object? error = freezed,
    Object? popToPlaceList = freezed,
  }) {
    return _then(_value.copyWith(
      addingPlace: freezed == addingPlace
          ? _value.addingPlace
          : addingPlace // ignore: cast_nullable_to_non_nullable
              as dynamic,
      suggestions: freezed == suggestions
          ? _value.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      error: freezed == error ? _value.error : error,
      popToPlaceList: freezed == popToPlaceList
          ? _value.popToPlaceList
          : popToPlaceList // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChoosePlaceViewStateImplCopyWith<$Res>
    implements $ChoosePlaceViewStateCopyWith<$Res> {
  factory _$$ChoosePlaceViewStateImplCopyWith(_$ChoosePlaceViewStateImpl value,
          $Res Function(_$ChoosePlaceViewStateImpl) then) =
      __$$ChoosePlaceViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic addingPlace,
      List<String>? suggestions,
      Object? error,
      DateTime? popToPlaceList});
}

/// @nodoc
class __$$ChoosePlaceViewStateImplCopyWithImpl<$Res>
    extends _$ChoosePlaceViewStateCopyWithImpl<$Res, _$ChoosePlaceViewStateImpl>
    implements _$$ChoosePlaceViewStateImplCopyWith<$Res> {
  __$$ChoosePlaceViewStateImplCopyWithImpl(_$ChoosePlaceViewStateImpl _value,
      $Res Function(_$ChoosePlaceViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addingPlace = freezed,
    Object? suggestions = freezed,
    Object? error = freezed,
    Object? popToPlaceList = freezed,
  }) {
    return _then(_$ChoosePlaceViewStateImpl(
      addingPlace: freezed == addingPlace ? _value.addingPlace! : addingPlace,
      suggestions: freezed == suggestions
          ? _value._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      error: freezed == error ? _value.error : error,
      popToPlaceList: freezed == popToPlaceList
          ? _value.popToPlaceList
          : popToPlaceList // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ChoosePlaceViewStateImpl implements _ChoosePlaceViewState {
  const _$ChoosePlaceViewStateImpl(
      {this.addingPlace = false,
      final List<String>? suggestions,
      this.error,
      this.popToPlaceList})
      : _suggestions = suggestions;

  @override
  @JsonKey()
  final dynamic addingPlace;
  final List<String>? _suggestions;
  @override
  List<String>? get suggestions {
    final value = _suggestions;
    if (value == null) return null;
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Object? error;
  @override
  final DateTime? popToPlaceList;

  @override
  String toString() {
    return 'ChoosePlaceViewState(addingPlace: $addingPlace, suggestions: $suggestions, error: $error, popToPlaceList: $popToPlaceList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChoosePlaceViewStateImpl &&
            const DeepCollectionEquality()
                .equals(other.addingPlace, addingPlace) &&
            const DeepCollectionEquality()
                .equals(other._suggestions, _suggestions) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.popToPlaceList, popToPlaceList) ||
                other.popToPlaceList == popToPlaceList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(addingPlace),
      const DeepCollectionEquality().hash(_suggestions),
      const DeepCollectionEquality().hash(error),
      popToPlaceList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChoosePlaceViewStateImplCopyWith<_$ChoosePlaceViewStateImpl>
      get copyWith =>
          __$$ChoosePlaceViewStateImplCopyWithImpl<_$ChoosePlaceViewStateImpl>(
              this, _$identity);
}

abstract class _ChoosePlaceViewState implements ChoosePlaceViewState {
  const factory _ChoosePlaceViewState(
      {final dynamic addingPlace,
      final List<String>? suggestions,
      final Object? error,
      final DateTime? popToPlaceList}) = _$ChoosePlaceViewStateImpl;

  @override
  dynamic get addingPlace;
  @override
  List<String>? get suggestions;
  @override
  Object? get error;
  @override
  DateTime? get popToPlaceList;
  @override
  @JsonKey(ignore: true)
  _$$ChoosePlaceViewStateImplCopyWith<_$ChoosePlaceViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
