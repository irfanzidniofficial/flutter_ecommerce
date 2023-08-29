import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/bloc/order/order_bloc.dart';
import 'package:flutter_ecommerce/common/app_format.dart';
import 'package:flutter_ecommerce/common/custom_button.dart';

import 'package:flutter_ecommerce/common/snap_widget.dart';
import 'package:flutter_ecommerce/common/theme.dart';
import 'package:flutter_ecommerce/data/datasource/auth_local_datasource.dart';
import 'package:flutter_ecommerce/data/models/request/order_request_model.dart';
import 'package:logger/logger.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.pin_drop_outlined,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Alamat Pengiriman",
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: TextField(
                controller: addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Product Item",
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutSuccess) {
                  final uniqueItem = state.items.toSet().length;
                  final dataSet = state.items.toSet();
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final count = state.items
                            .where((element) =>
                                element.id == dataSet.elementAt(index).id)
                            .length;

                        return Container(
                          decoration:
                              BoxDecoration(color: greyColor.withOpacity(0.1)),
                          child: ListTile(
                            minVerticalPadding: 0,
                            horizontalTitleGap: 12,
                            contentPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  dataSet.elementAt(index).attributes!.image!,
                                ),
                              ),
                            ),
                            title: Text(
                              dataSet.elementAt(index).attributes!.name!,
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              AppFormat.longPrice(
                                dataSet.elementAt(index).attributes!.price!,
                              ),
                            ),
                            trailing: Text(
                              '$count',
                              style: blackTextStyle.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: uniqueItem,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return const ListTile(
                        title: Text('Belum ada data'),
                      );
                    },
                    itemCount: 1,
                  ),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (model) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SnapWidget(url: model.redirectUrl);
                  },
                ));
              },
              orElse: () {},
            );
          },
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutSuccess) {
                var logger = Logger();

                return CustomFilledButton(
                    title: 'Pay',
                    onPressed: () async {
                      final userId = await AuthLocalDatasource().getUserId();
                      final total = state.items.fold(
                        0,
                        (sum, item) => sum + item.attributes!.price!,
                      );

                      final data = Data(
                        userId: userId,
                        items: state.items
                            .map((e) => Item(
                                  id: e.id!,
                                  productName: e.attributes!.name!,
                                  price: e.attributes!.price!,
                                  qty: e.attributes!.price!,
                                ))
                            .toList(),
                        courierName: 'JNE',
                        deliveryAddress: addressController.text,
                        shippingCost: 80000,
                        statusOrder: 'waitingPayment',
                        totalPrice: total,
                      );
                      final OrderRequestModel requestModel =
                          OrderRequestModel(data: data);
                      context.read<OrderBloc>().add(
                            OrderEvent.doOrder(requestModel),
                          );
                      logger.i("Info Log");
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
