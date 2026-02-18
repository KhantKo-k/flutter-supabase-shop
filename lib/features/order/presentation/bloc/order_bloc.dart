import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/error/failures.dart';
import 'package:shop_project/features/order/domain/usecases/add_order_items_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/create_order_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/get_my_orders_use_case.dart';
import 'package:shop_project/features/order/domain/usecases/get_order_items_use_case.dart';
import 'package:shop_project/features/order/presentation/bloc/order_event.dart';
import 'package:shop_project/features/order/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUseCase createOrder;
  final AddOrderItemsUseCase addOrderItems;
  final GetMyOrdersUseCase getMyOrders;
  final GetOrderItemsUseCase getOrderItems;

  OrderBloc({
    required this.addOrderItems,
    required this.createOrder,
    required this.getMyOrders,
    required this.getOrderItems,
  }) : super(const OrderState()) {
    on<PlaceOrderRequested>(_onPlaceOrderRequested);
    on<LoadMyOrders>(_onLoadMyOrders);
    on<LoadOrderItems>(_onLoadOrderItems);
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
          failure: DataNotFoundFailure("Failed to load products"),
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
          failure: DataNotFoundFailure("Failed to load products"),
        ),
      ),
      (items) =>
          emit(state.copyWith(status: OrderStatus.loaded, orderItems: items)),
    );
  }
}
