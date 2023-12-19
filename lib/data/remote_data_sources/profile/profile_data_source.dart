import 'package:test_environtment/domain/models/user_preview.dart';
import 'package:test_environtment/domain/models/post_preview.dart';
import 'package:test_environtment/domain/models/list_model.dart';
import 'package:test_environtment/data/remote_data_sources/models/list_model.dart'
as source_source_list_model;
import 'package:test_environtment/data/remote_data_sources/models/user_preview.dart'
as source_user_preview;

import 'package:dio/dio.dart';

class ProfileDataSource {
  final Dio dio;

  ProfileDataSource(this.dio);
// получение списка профилей
  Future<ListModel<UserPreview>> getProfiles() async {
    final result = await dio.get(
        '/user'
    );
    final model = source_source_list_model.ListModel.fromJson(result.data)
        .toEntity<UserPreview>(
          (a) => source_user_preview.UserPreview.fromJson(a).toEntity(),
    ) as ListModel<UserPreview>;

    return model;

  }

  Future<UserPreview> updateProfile(
      {required String profileId, required String name}) async {
    final result = await dio.put(
        '/user/$profileId',
        data: {
          'firstName': name,
        }
    );

    var userPreview = source_user_preview.UserPreview.fromJson(result.data).toEntity();
    return userPreview;
  }

  Future<UserPreview> updateProfileUserPhoto(
      {required String profileId, required String userPicture}) async {
    final result = await dio.put(
        '/user/$profileId',
        data: {
          'picture': userPicture
        }
    );

    var userPreview = source_user_preview.UserPreview.fromJson(result.data).toEntity();
    return userPreview;
  }
}