import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/order/domain/entity/order_entity.dart';
import 'package:shop_project/features/order/domain/usecases/add_order_items_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/create_order_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/delete_order_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/get_my_orders_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/get_order_items_use_case.dart';
import 'package:shop_project/features/order/presentation/bloc/order_event.dart';
import 'package:shop_project/features/order/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUseCase createOrder;
  final AddOrderItemsUseCase addOrderItems;
  final GetMyOrdersUseCase getMyOrders;
  final GetOrderItemsUseCase getOrderItems;
  final DeleteOrderUseCase deleteOrder;

  OrderBloc({
    required this.addOrderItems,
    required this.createOrder,
    required this.getMyOrders,
    required this.getOrderItems,
    required this.deleteOrder,
  }) : super(const OrderState()) {
    on<PlaceOrderRequested>(_onPlaceOrderRequested);
    on<LoadMyOrders>(_onLoadMyOrders);
    on<LoadOrderItems>(_onLoadOrderItems);
    on<DeleteOrder>(_onDeleteOrder);
  }

  Future<void> _onPlaceOrderRequested(
    PlaceOrderRequested event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrderStatus.loading, failure: null));

    final result = await createOrder(event.totalAmount);

    await result.fold(
      (failure) async {
        // emit(OrderFailure(failure.message)),
        emit(
          state.copyWith(
            status: OrderStatus.failure,
            failure: DataNotFoundFailure('Failed to order!'),
          ),
        );
      },
      (orderId) async {
        try {
          await addOrderItems(orderId: orderId, items: event.items);
          //emit(OrderPlacedSuccess(orderId));
          emit(
            state.copyWith(
              status: OrderStatus.success,
              successOrderId: orderId,
            ),
          );
          final ordersResult = await getMyOrders();
          ordersResult.fold(
            (failure) => emit(
              state.copyWith(status: OrderStatus.failure, failure: failure),
            ),
            (orders) => emit(
              state.copyWith(status: OrderStatus.loaded, orders: orders),
            ),
          );
          //emit(OrderPlacedSuccess(orderId));
        } catch (e) {
          emit(
            state.copyWith(
              status: OrderStatus.failure,
              failure: UnknownFailure("Order created but failed to add items."),
            ),
          );
        }
      },
    );
  }

  Future<void> _onLoadMyOrders(
    LoadMyOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrderStatus.loading, failure: null));
    final result = await getMyOrders();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrderStatus.failure,
          failure: DataNotFoundFailure("No orders found"),
        ),
      ),
      (orders) =>
          emit(state.copyWith(status: OrderStatus.loaded, orders: orders)),
    );
  }

  Future<void> _onLoadOrderItems(
    LoadOrderItems event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrderStatus.loading, failure: null));
    final result = await getOrderItems(event.orderId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrderStatus.failure,
          failure: DataNotFoundFailure("Failed to load orders items"),
        ),
      ),
      (items) =>
          emit(state.copyWith(status: OrderStatus.loaded, orderItems: items)),
    );
  }

  Future<void> _onDeleteOrder(
    DeleteOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrderStatus.loading, failure: null));
    try {
      final result = await deleteOrder(event.orderId);
      result.fold(
        (failure) =>
            emit(state.copyWith(status: OrderStatus.failure, failure: failure)),
        (_) {
          final updatedOrders = List<OrderEntity>.from(state.orders)
            ..removeWhere((order) => order.id == event.orderId);
          emit(
            state.copyWith(status: OrderStatus.loaded, orders: updatedOrders),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OrderStatus.failure,
          failure: UnknownFailure('Failed to delete order'),
        ),
      );
    }
  }
}
