
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/order/data/datasources/order_remote_datasource.dart';
import 'package:shop_project/features/order/data/model/order_item_model.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';
import 'package:shop_project/features/order/domain/entity/order_item_entity.dart';
import 'package:shop_project/features/order/domain/repository/order_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepositoryImpl implements OrderRepository{
  final OrderRemoteDatasource datasource;

  OrderRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, String>> createOrder({
    required double totalAmount,
  }) async {
    try{
      final orderId = await datasource.createOrder(totalAmount);
      return Right(orderId);
    } on AuthException{
      return Left(AuthFailure(FailureMessages.invalidCredentials));
    } on PostgrestException catch (e) {
      return Left(SupabaseFailure(e.message));
    } on SocketException{
      return Left(NetworkFailure(FailureMessages.networkError));
    } catch (_) {
      return Left(UnknownFailure(FailureMessages.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, void>> addOrderItems({
    required String orderId,
    required List<OrderItemEntity> items,
  }) async {
    try{
      final models = items.map((e){
        return OrderItemModel(
          id: '', 
          orderId: orderId, 
          productId: e.productId, 
          productName: e.productName, 
          price: e.price, 
          quantity: e.quantity
        );
      }).toList();

      await datasource.insertOrderItems(orderId, models);
      return Right(null);
    }on PostgrestException catch (e) {
      return Left(SupabaseFailure(e.message));
    } on SocketException {
      return Left(NetworkFailure(FailureMessages.networkError));
    } catch (_) {
      return Left(UnknownFailure(FailureMessages.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getMyOrders() async {
    try{
      final orders = await datasource.getOrders();
      if(orders.isEmpty){
        return Left(DataNotFoundFailure());
      }
      return Right(orders);
    } catch (_) {
      return Left(UnknownFailure(FailureMessages.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, List<OrderItemEntity>>> getOrderItems(
    String orderId,
  ) async {
    try{
      final items = await datasource.getOrderItems(orderId);
      if (items.isEmpty) {
        return Left(DataNotFoundFailure());
      }
      return Right(items);
    }catch (_) {
      return Left(UnknownFailure(FailureMessages.unexpectedError));
    }
  }
}