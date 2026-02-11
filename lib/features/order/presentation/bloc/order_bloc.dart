import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/features/order/domain/usecases/add_order_items_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/create_order_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/get_my_orders_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/get_order_items_use_case.dart';
import 'package:shop_project/features/order/presentation/bloc/order_event.dart';
import 'package:shop_project/features/order/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState>{
  final CreateOrderUseCase createOrder;
  final AddOrderItemsUseCase addOrderItems;
  final GetMyOrdersUseCase getMyOrders;
  final GetOrderItemsUseCase getOrderItems;

  OrderBloc({
    required this.addOrderItems,
    required this.createOrder,
    required this.getMyOrders,
    required this.getOrderItems,
  }) : super(OrderInitial()) {
    on<PlaceOrderRequested> (_onPlaceOrderRequested);
    on<LoadMyOrders> (_onLoadMyOrders);
    on<LoadOrderItems> (_onLoadOrderItems);
  }

  Future<void> _onPlaceOrderRequested( 
    PlaceOrderRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final result = await createOrder(event.totalAmount);

    await result.fold(
      (failure) async => emit(OrderFailure(failure.message)),
      (orderId) async {
        try{
          await addOrderItems(orderId: orderId, items: event.items);
          emit(OrderPlacedSuccess(orderId));
        } catch (e) {
          emit(OrderFailure("Order created but failed to add items."));
        }
      }
    );
  }

  Future<void> _onLoadMyOrders( 
    LoadMyOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await getMyOrders();
    result.fold(
      (failure) => emit(OrderFailure(failure.message)), 
      (orders) => emit(OrdersLoaded(orders)),
    );
  }

  Future<void> _onLoadOrderItems( 
    LoadOrderItems event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await getOrderItems(event.orderId);
    result.fold(
      (failure) => emit(OrderFailure(failure.message)), 
      (items) => emit(OrderItemsLoaded(items)),
    );
  }
}