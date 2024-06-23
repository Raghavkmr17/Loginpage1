import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final emailprovider = StateProvider<String>((ref) => '');
final passwordprovider = StateProvider<String>((ref) => '');
final oldpasswordprovider = StateProvider<String>((ref) => '');
final newpasswordprovider = StateProvider<String>((ref) => '');
final spprovider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});
