## [4.1.0]
* Fixed issue with timestamps: [#1](https://github.com/quentinleguennec/flutter_health_connect/pull/1) by [AliakseiT](https://github.com/AliakseiT) and [nikolaydymura](https://github.com/nikolaydymura)
* Added `getRecordById` [#1](https://github.com/quentinleguennec/flutter_health_connect/pull/1) by [AliakseiT](https://github.com/AliakseiT) and [nikolaydymura](https://github.com/nikolaydymura)
* Improved the Example app to add a button for `getRecordById`.

## [4.0.0]
* **BREAKING:** `writeData` now returns a list of the uids of the created Records instead of a boolean.
* Fixed `deleteRecordsByIds`, which would delete the records but then throw an error.
* Fixed `deleteRecordsByTime`, which would delete the records but then throw an error.
* Added documentation.
* Improved the Example app to add a button for each `deleteRecordsByIds` and `deleteRecordsByTime`.

## [3.0.0]
* **BREAKING:** All apps using this plugin must update their AndroidManifest.xml to add the "activity-alias". This will fix the "App update needed" issue when asking for permission.
* Now handling Android 14
* Updated README.md

## [2.1.0]
* Added `aggregate` function to get statistics
* Updated README.md

## [2.0.0]
* Added missing data types
* Added Models for each data type
* Added getRecords to return a List of Records instead of a Map 
* Added writeData method
* Added deleteRecords methods
* Upgrade Health Connect API to `1.1.0-alpha2`
* Updated README.md

## [1.2.3]
* Upgrade to `alpha11` [#8](https://github.com/duynguyen242/flutter_health_connect/pull/8) by [aljkor](https://github.com/aljkor)

## [1.2.2]
* getChanges flatten record field on UpsertionChange

## [1.2.1]
* breaking changes for getRecord 
* getRecord pagination support
* implement getChanges and getChangesToken
* fix datetime range passed to getRecord

## [1.2.0]
* Upgrade to `alpha10` [#6](https://github.com/duynguyen242/flutter_health_connect/pull/6) by [aljkor](https://github.com/aljkor)

## [1.1.4]
* Update README.md

## [1.0.0]
* Initial release