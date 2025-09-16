import 'package:fake_store/features/home/presentation/manager/cubits/filter_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showFilterOptions(
  BuildContext context, {
  required FilterProductsCubit filterProductsCubit,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (bottomSheetContext) {
      return BlocProvider.value(
        value: filterProductsCubit,
        child: Builder(
          builder: (innerContext) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Filter Products",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: Icon(Icons.title),
                    title: Text("By Title"),
                    onTap: () {
                      innerContext.read<FilterProductsCubit>().filterProducts(
                        criteria: "title",
                      );
                      Navigator.pop(innerContext);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.price_change),
                    title: Text("By High Price"),
                    onTap: () {
                      innerContext.read<FilterProductsCubit>().filterProducts(
                        criteria: "high_price",
                      );
                      Navigator.pop(innerContext);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.price_change),
                    title: Text("By Low Price"),
                    onTap: () {
                      innerContext.read<FilterProductsCubit>().filterProducts(
                        criteria: "low_price",
                      );
                      Navigator.pop(innerContext);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
