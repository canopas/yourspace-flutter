import 'dart:async';

import 'package:data/api/auth/api_user_service.dart';
import 'package:data/api/space/api_space_invitation_service.dart';
import 'package:data/api/space/api_space_service.dart';
import 'package:data/api/space/space_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../api/auth/auth_models.dart';
import '../storage/app_preferences.dart';
import 'location_service.dart';

final spaceServiceProvider = Provider((ref) => SpaceService(
      ref.read(currentUserPod),
      ref.read(apiSpaceServiceProvider),
      ref.read(apiSpaceInvitationServiceProvider),
      ref.read(currentSpaceId.notifier),
      ref.read(apiUserServiceProvider),
      ref.read(locationServiceProvider),
    ));

class SpaceService {
  final ApiUser? currentUser;
  final ApiSpaceService spaceService;
  final ApiSpaceInvitationService spaceInvitationService;
  final StateController<String?> _currentSpaceIdController;
  final ApiUserService userService;
  final LocationService locationService;

  SpaceService(
    this.currentUser,
    this.spaceService,
    this.spaceInvitationService,
    this._currentSpaceIdController,
    this.userService,
    this.locationService,
  );

  String? get currentSpaceId => _currentSpaceIdController.state;

  set currentSpaceId(String? value) {
    _currentSpaceIdController.state = value;
  }

  Future<String> createSpaceAndGetInviteCode(String spaceName) async {
    final spaceId = await spaceService.createSpace(spaceName);
    final generatedCode =
        await spaceInvitationService.createInvitation(spaceId);
    currentSpaceId = spaceId;
    return generatedCode;
  }

  Future<void> joinSpace(String spaceId) async {
    await spaceService.joinSpace(spaceId);
    currentSpaceId = spaceId;
  }

  Stream<List<SpaceInfo>> streamAllSpace() {
    return streamUserSpaces(currentUser?.id ?? '').switchMap((spaces) {
      if (spaces.isEmpty) {
        return Stream.value([]);
      }

      final spaceInfoStreams = spaces.map((space) {
        if (space == null) return Stream.value(null);

        return spaceService
            .getStreamSpaceMemberBySpaceId(space.id)
            .switchMap((members) {
          final memberInfoStreams = members.map((member) {
            return CombineLatestStream.combine2(
              userService.getUserStream(member.user_id),
              Stream.value(member.location_enabled),
              (user, isLocationEnabled) {
                return user != null
                    ? ApiUserInfo(
                        user: user,
                        isLocationEnabled: isLocationEnabled,
                      )
                    : null;
              },
            );
          }).toList();

          return CombineLatestStream.list(memberInfoStreams)
              .map((memberInfoList) {
            final nonNullMembers =
                memberInfoList.whereType<ApiUserInfo>().toList();
            return SpaceInfo(space: space, members: nonNullMembers);
          });
        });
      }).toList();

      return CombineLatestStream.list(spaceInfoStreams).map((spaceInfoList) {
        return spaceInfoList
            .where((spaceInfo) => spaceInfo != null)
            .cast<SpaceInfo>()
            .toList();
      });
    });
  }

  Future<SpaceInfo?> getCurrentSpaceInfo() async {
    final currentSpace = await getCurrentSpace();
    if (currentSpace == null) return null;
    final members = await spaceService.getMembersBySpaceId(currentSpace.id);
    return SpaceInfo(
      space: currentSpace,
      members: members
          .map((member) async {
            final user = await userService.getUser(member.user_id);
            return user != null
                ? ApiUserInfo(
                    user: user, isLocationEnabled: member.location_enabled)
                : null;
          })
          .whereType<ApiUserInfo>()
          .toList(),
    );
  }

  Future<SpaceInfo?> getSpaceInfo(String spaceId) async {
    final space = await getSpace(spaceId);
    if (space == null) return null;

    final members = await spaceService.getMembersBySpaceId(space.id);
    final memberInfo = await Future.wait(members.map((member) async {
      final user = await userService.getUser(member.user_id);
      return user != null
          ? ApiUserInfo(user: user, isLocationEnabled: member.location_enabled)
          : null;
    }).toList());

    return SpaceInfo(
      space: space,
      members: memberInfo.whereType<ApiUserInfo>().toList(),
    );
  }

  Future<ApiSpace?> getCurrentSpace() async {
    final spaceId = currentSpaceId;
    if (spaceId!.isEmpty) {
      final userId = currentUser?.id ?? '';
      final userSpaces = await getUserSpaces(userId);
      return userSpaces.firstOrNull;
    }
    return getSpace(spaceId);
  }

  Future<List<ApiSpace?>> getUserSpaces(String userId) async {
    final spaceMembers = await spaceService.getSpaceMemberByUserId(userId);
    final spaces = await Future.wait(spaceMembers.map((spaceMember) async {
      final spaceId = spaceMember.space_id;
      final space = await spaceService.getSpace(spaceId);
      return space;
    }).toList());
    return spaces;
  }

  Stream<List<ApiSpace?>> streamUserSpaces(String userId) {
    return spaceService
        .streamSpaceMemberByUserId(userId)
        .asyncMap((member) async {
      final spaces = await Future.wait(member.map((spaceMember) async {
        final spaceId = spaceMember.space_id;
        return await spaceService.getSpace(spaceId);
      }).toList());
      return spaces;
    });
  }

  Future<ApiSpace?> getSpace(String spaceId) async {
    return spaceService.getSpace(spaceId);
  }

  Future<List<ApiSpaceMember>> getMemberBySpaceId(String spaceId) async {
    return spaceService.getMembersBySpaceId(spaceId);
  }

  Future<String?> getInviteCode(String spaceId) async {
    final code = await spaceInvitationService.getSpaceInviteCode(spaceId);
    if (code?.isExpired ?? false) {
      return spaceInvitationService.regenerateInvitationCode(spaceId);
    }
    return code?.code;
  }

  Future<void> enableLocation(
    String spaceId,
    String userId,
    bool locationEnabled,
  ) async {
    await spaceService.enableLocation(spaceId, userId, locationEnabled);
  }

  Future<void> deleteUserSpaces() async {
    final userId = currentUser?.id ?? '';
    final allSpace = await getUserSpaces(userId);
    if (allSpace.isEmpty) return;
    final ownSpace =
        allSpace.where((space) => space?.admin_id == userId).toList();
    final joinedSpace =
        allSpace.where((space) => space?.admin_id != userId).toList();

    for (final space in ownSpace) {
      await deleteSpace(space!.id);
    }

    for (final space in joinedSpace) {
      await spaceService.removeUserFromSpace(space!.id, userId);
    }
    _currentSpaceIdController.state = null;
  }

  Future<void> deleteSpace(String spaceId) async {
    await spaceInvitationService.deleteInvitations(spaceId);
    await spaceService.deleteSpace(spaceId);
    final userId = currentUser?.id ?? '';
    final userSpaces = await getUserSpaces(userId);
    userSpaces
        .sort((a, b) => (a?.created_at ?? 0).compareTo(b?.created_at ?? 0));
    final currentSpaceId =
        userSpaces.isNotEmpty ? userSpaces.firstOrNull?.id ?? '' : null;
    _currentSpaceIdController.state = currentSpaceId;
  }

  Future<void> leaveSpace(String spaceId) async {
    final userId = currentUser?.id ?? '';
    await spaceService.removeUserFromSpace(spaceId, userId);
    final userSpaces = await getUserSpaces(userId);
    userSpaces
        .sort((a, b) => (a?.created_at ?? 0).compareTo(b?.created_at ?? 0));
    final currentSpaceId =
        userSpaces.isNotEmpty ? userSpaces.firstOrNull?.id ?? '' : '';
    _currentSpaceIdController.state = currentSpaceId;
  }

  Future<void> updateSpace(ApiSpace newSpace) async {
    await spaceService.updateSpace(newSpace);
  }

  Stream<List<ApiUserInfo>> getMemberWithLocation(String spaceId) {
    if (spaceId.isEmpty) {
      return Stream.value([]);
    }

    return spaceService
        .getStreamSpaceMemberBySpaceId(spaceId)
        .switchMap((members) {
      if (members.isEmpty) {
        return Stream.value([]);
      }

      List<Stream<ApiUserInfo>> userInfoStreams = members.map((member) {
        return CombineLatestStream.combine4(
          userService.getUserStream(member.user_id),
          locationService.getCurrentLocationStream(member.user_id),
          Stream.value(member.location_enabled),
          userService.getUserSessionStream(member.user_id),
          (user, location, isLocationEnabled, session) {
            return ApiUserInfo(
              user: user!,
              location: location?.firstOrNull,
              isLocationEnabled: isLocationEnabled,
              session: session,
            );
          },
        );
      }).toList();

      return CombineLatestStream.list(userInfoStreams)
          .map((userInfoList) => userInfoList.toList());
    });
  }
}
