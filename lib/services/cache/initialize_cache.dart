import 'dart:async';
import 'dart:convert';
import 'package:corpo/services/cache/read_cache_data.dart';
import 'package:corpo/services/cache/upload_backup.dart';
import 'package:cache_manager/core/cache_manager_utils.dart';
import 'package:cache_manager/core/delete_cache_service.dart';
import 'package:cache_manager/core/read_cache_service.dart';
import 'package:cache_manager/core/write_cache_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

import 'package:corpo/common/globals.dart' as Globals;

class InitializeCache {

  InitializeCache._privateConstructor();

  static final InitializeCache _instance = InitializeCache._privateConstructor();

  factory InitializeCache() {
    return _instance;
  }

  final LocalStorage storage = LocalStorage('corpo');

  Future initiateCache() async {

    /// OG cache
    CacheManagerUtils.conditionalCache(
        key: "cached_time",
        valueType: ValueType.StringValue,
        actionIfNull: () async {

          /// Set up cache expiration time
          DateTime now = DateTime.now();
          Globals.cachePlayerDataTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime(now.year, now.month, now.day, now.hour+24, now.minute, now.second));
          WriteCache.setString(key: "cached_time", value: Globals.cachePlayerDataTime);
          debugPrint('Time Cached');

          /// Set up cache data
          await ReadCacheData().readCache().then((value) {
            debugPrint('1) Cache stored using read cache data');
          });

        },
        actionIfNotNull: () async {

          debugPrint('Time Cache Exists');

          DateTime now = DateTime.now();
          /// Set up variables and current time
          String currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second));
          DateTime? cachedTime;

          /// Read cache and declare values
          await ReadCache.getString(key: "cached_time").then((value) => {
            cachedTime = DateTime.parse(value),
          });

          /// Check if the cached time is expired
          Duration diff = cachedTime!.difference(DateTime.parse(currentTime));

          if(diff.isNegative){
            /// Update data
            await UploadBackup().uploadBackup().whenComplete(() async {
              debugPrint('Upload completed');
              /// Delete Cache
              DateTime now = DateTime.now();
              String cachedTimeString = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime(now.year, now.month, now.day, now.hour+24, now.minute, now.second));
              debugPrint('Time Cached Again');
              WriteCache.setString(key: "cached_time", value: cachedTimeString);

              // await DeleteCache.deleteKey("cached_time");
              // debugPrint('Cache Deleted');
            });
            // await ReadCacheData().readCache().then((value){
            //   debugPrint('2) Cache stored using read cache data');
            // });

          } else {
            /// Send expiration time alert
            debugPrint('Cached time will end in ' + diff.inSeconds.toString() + ' seconds');
          }

        });

  }

}