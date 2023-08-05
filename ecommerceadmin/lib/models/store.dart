
import'package:freezed_annotation/freezed_annotation.dart';
part 'store.freezed.dart';
part 'store.g.dart';
@freezed
abstract class Store with _$Store{
  factory Store({
    required String uid,
    String? email,
    String?password,
    String? image,
    String? name,
    String? address,
    String? phoneNumber
  })=_Store;
  factory Store.fromJson(Map<String,dynamic>json)=>_$StoreFromJson(json);
}