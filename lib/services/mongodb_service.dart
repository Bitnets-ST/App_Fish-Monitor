import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/fish.dart';

class MongoDBService {
  static Db? _db;
  static DbCollection? _fishCollection;

  static Future<void> connect() async {
    try {
      final uri = dotenv.env['MONGODB_URI'] ?? 'mongodb://localhost:27017/fish_monitor';
      _db = await Db.create(uri);
      await _db!.open();
      _fishCollection = _db!.collection('fish');
      print('Connected to MongoDB');
    } catch (e) {
      print('Error connecting to MongoDB: $e');
      rethrow;
    }
  }

  static Future<void> disconnect() async {
    await _db?.close();
  }

  static Future<List<Fish>> getAllFish() async {
    try {
      final fishData = await _fishCollection!.find().toList();
      return fishData.map((data) => Fish.fromJson(data)).toList();
    } catch (e) {
      print('Error getting fish: $e');
      rethrow;
    }
  }

  static Future<void> addFish(Fish fish) async {
    try {
      await _fishCollection!.insert(fish.toJson());
    } catch (e) {
      print('Error adding fish: $e');
      rethrow;
    }
  }

  static Future<void> updateFish(Fish fish) async {
    try {
      final objectId = ObjectId.fromHexString(fish.id);
      await _fishCollection!.update(
        where.id(objectId),
        fish.toJson(),
      );
    } catch (e) {
      print('Error updating fish: $e');
      rethrow;
    }
  }

  static Future<void> deleteFish(String id) async {
    try {
      final objectId = ObjectId.fromHexString(id);
      await _fishCollection!.remove(where.id(objectId));
    } catch (e) {
      print('Error deleting fish: $e');
      rethrow;
    }
  }
} 