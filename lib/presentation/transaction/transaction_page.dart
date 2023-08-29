import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecommerce/bloc/list_order/list_order_bloc.dart';
import 'package:flutter_ecommerce/common/app_format.dart';

import 'package:flutter_ecommerce/common/theme.dart';
import 'package:flutter_ecommerce/data/datasource/auth_local_datasource.dart';
import 'package:flutter_ecommerce/data/models/response/auth_response_model.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  User? user;

  @override
  void initState() {
    getUser();
    context.read<ListOrderBloc>().add(const ListOrderEvent.get());
    super.initState();
  }

  Future<void> getUser() async {
    user = await AuthLocalDatasource().getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Transaction",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ListOrderBloc, ListOrderState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  orElse: () {
                    return const Center(
                      child: Text("No Order"),
                    );
                  },
                  success: (data) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final order = data.data![index];
                        final items = order.attributes!.items!.first;

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: greyColor,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.local_mall_outlined,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Shopping",
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                      Text(
                                        AppFormat.shortDate(
                                          order.attributes!.updatedAt,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${order.attributes!.statusOrder}',
                                    style: greenTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: medium,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.more_vert,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: greyColor,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      color: whiteColor,
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "ID:${order.id}",
                                        textAlign: TextAlign.center,
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${items.productName}',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text("3 barang"),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Total Belanja",
                                style: blackTextStyle.copyWith(
                                    fontSize: 12, fontWeight: medium),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                AppFormat.longPrice(
                                  order.attributes!.totalPrice!,
                                ),
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: data.data?.length,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
