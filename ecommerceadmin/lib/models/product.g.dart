// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      productId: json['productId'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      oldPrice: (json['oldPrice'] as num?)?.toDouble(),
      isAvailable: json['isAvailable'] as bool?,
      categoryname: json['categoryname'] as String?,
      companyname: json['companyname'] as String?,
      companyaddress: json['companyaddress'] as String?,
      city: json['city'] as String?,
      user_id: json['user_id'] as String?,
      phonenumber: json['phonenumber'] as String?,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'image': instance.image,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'oldPrice': instance.oldPrice,
      'isAvailable': instance.isAvailable,
      'categoryname': instance.categoryname,
      'companyname': instance.companyname,
      'companyaddress': instance.companyaddress,
      'city': instance.city,
      'user_id': instance.user_id,
      'phonenumber': instance.phonenumber,
    };
