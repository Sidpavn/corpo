
import 'package:cache_manager/core/delete_cache_service.dart';
import 'package:corpo/common/globals.dart' as Globals;

class DeleteCacheData {

  DeleteCacheData._privateConstructor();

  static final DeleteCacheData _instance = DeleteCacheData
      ._privateConstructor();

  factory DeleteCacheData() {
    return _instance;
  }

  Future deleteCache() async {

    /// Delete cache
    await DeleteCache.deleteKey("cached_time");
    await DeleteCache.deleteKey("cached_leaderboard_time");

  }

}