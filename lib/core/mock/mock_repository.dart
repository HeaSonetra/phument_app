import 'dart:convert';
import 'package:flutter/services.dart';

class MockRepository {
  static Future<List<Map<String, dynamic>>> loadJsonData(
    String assetPath,
  ) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error loading $assetPath: $e');
      return [];
    }
  }

  static Future<T> simulateNetworkDelay<T>(
    T data, {
    Duration delay = const Duration(seconds: 1),
  }) async {
    await Future.delayed(delay);
    return data;
  }

  static Future<List<T>> simulateNetworkDelayList<T>(
    List<T> data, {
    Duration delay = const Duration(seconds: 1),
  }) async {
    await Future.delayed(delay);
    return data;
  }
}
