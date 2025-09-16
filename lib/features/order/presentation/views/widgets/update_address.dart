import 'package:fake_store/features/cart/presentation/views/widgets/add_address.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class UpdateAddress extends StatelessWidget {
  const UpdateAddress({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext outerContex) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.blueGrey),
          SizedBox(width: 5),
          Flexible(
            child: BlocBuilder<OrderCubit, OrderState>(
              buildWhen: (previous, current) => current is UpdateAddressSuccess,
              builder: (context, state) {
                if (state is UpdateAddressSuccess) {
                  return Text(
                    '${state.newAddress.country}-${state.newAddress.state}-${state.newAddress.city}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                return Text(
                  '${order.address?.country}-${order.address?.state}-${order.address?.city}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),

          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: outerContex,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(
                        context,
                      ).viewInsets.bottom, // علشان الكيبورد
                    ),
                    child: AddAddress(
                      onAddressSelected: (address) {
                        outerContex.read<OrderCubit>().updateAddress(address);
                        Navigator.pop(context); // يقفل البوتوم شيت
                        order.address = address;

                        // هنا بقى ممكن تبعت الأوردر بالـ address
                      },
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.edit, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
