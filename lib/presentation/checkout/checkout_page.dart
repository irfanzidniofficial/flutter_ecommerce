import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce/bloc/order/order_bloc.dart';
import 'package:flutter_ecommerce/common/global_variables.dart';
import 'package:flutter_ecommerce/common/snap_widget.dart';
import 'package:flutter_ecommerce/data/models/request/order_request_model.dart';

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
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: AppBar(
        title: const Text("Checkout Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Alamat Pengiriman"),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Item Produck"),
            const SizedBox(
              height: 10,
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
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              dataSet.elementAt(index).attributes!.image!,
                            ),
                          ),
                          title: Text(
                            dataSet.elementAt(index).attributes!.name!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Text('$count'),
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
                return ElevatedButton(
                  onPressed: () {
                    final total = state.items.fold(
                      0,
                      (sum, item) => sum + item.attributes!.price!,
                    );
                    final data = Data(
                      items: state.items
                          .map((e) => Item(
                              id: e.id!,
                              productName: e.attributes!.name!,
                              price: e.attributes!.price!,
                              qty: e.attributes!.price!))
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFEE4D2D,
                    ),
                  ),
                  child: const Text(
                    "Bayar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
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
