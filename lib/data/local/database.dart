import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Tables
class Guides extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get shortDescription => text()();
  TextColumn get category => text()();
  TextColumn get difficulty => text()();
  TextColumn get estimatedDuration => text()();
  TextColumn get tags => text().map(const StringListConverter())();
  TextColumn get imageUrl => text().nullable()();
  BoolColumn get isPublished => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class GuideSteps extends Table {
  TextColumn get id => text()();
  TextColumn get guideId => text().references(Guides, #id)();
  IntColumn get stepNumber => integer()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get displayName => text().nullable()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get university => text().nullable()();
  TextColumn get level => text().nullable()();
  TextColumn get city => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class UserProgress extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get guideId => text().references(Guides, #id)();
  IntColumn get completedSteps => integer().withDefault(const Constant(0))();
  IntColumn get totalSteps => integer().withDefault(const Constant(0))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Favorites extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get guideId => text().references(Guides, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ViewedGuides extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get guideId => text().references(Guides, #id)();
  DateTimeColumn get viewedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncStatus extends Table {
  TextColumn get entityType => text()();
  DateTimeColumn get lastSyncAt => dateTime()();
  BoolColumn get isSyncing => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {entityType};
}

// Converters
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return fromDb.split(',').where((s) => s.isNotEmpty).toList();
  }

  @override
  String toSql(List<String> value) {
    return value.join(',');
  }
}

// Database
@DriftDatabase(tables: [Guides, GuideSteps, Users, UserProgress, Favorites, ViewedGuides, SyncStatus])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Méthodes simplifiées
  Future<List<Guide>> getAllGuides() async => [];
  Future<Guide?> getGuideById(String id) async => null;
  Future<List<Guide>> getGuidesByCategory(String category) async => [];
  Future<List<Guide>> searchGuides(String query) async => [];
  Future<int> insertGuide(GuidesCompanion guide) async => 0;
  Future<int> updateGuide(GuidesCompanion guide) async => 0;
  Future<void> deleteGuide(String id) async {}
  Future<List<GuideStep>> getGuideSteps(String guideId) async => [];
  Future<int> insertGuideStep(GuideStepsCompanion step) async => 0;
  Future<int> updateGuideStep(GuideStepsCompanion step) async => 0;
  Future<void> deleteGuideSteps(String guideId) async {}
  Future<User?> getUserById(String id) async => null;
  Future<int> insertUser(UsersCompanion user) async => 0;
  Future<int> updateUser(UsersCompanion user) async => 0;
  Future<void> deleteUser(String id) async {}
  Future<List<UserProgress>> getUserProgress(String userId) async => [];
  Future<int> insertUserProgress(UserProgressCompanion progress) async => 0;
  Future<int> updateUserProgress(UserProgressCompanion progress) async => 0;
  Future<void> deleteUserProgress(String id) async {}
  Future<List<Favorite>> getFavorites(String userId) async => [];
  Future<int> insertFavorite(FavoritesCompanion favorite) async => 0;
  Future<void> deleteFavorite(String id) async {}
  Future<List<ViewedGuide>> getViewedGuides(String userId) async => [];
  Future<int> insertViewedGuide(ViewedGuidesCompanion viewedGuide) async => 0;
  Future<void> deleteViewedGuide(String id) async {}
  Future<SyncStatus?> getSyncStatus(String entityType) async => null;
  Future<int> updateSyncStatus(SyncStatusCompanion status) async => 0;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}