import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outsourced_pages/utils/formatting/app_theme.dart';
import 'package:outsourced_pages/utils/global_bloc.dart';
import 'package:outsourced_pages/utils/models/expert_filter_model.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({
    super.key,
    required this.onFilterValueSelected,
  });
  final Function(ExpertFilterValues, bool) onFilterValueSelected;
  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalBloc>(builder: (context, globalBloc, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        decoration: BoxDecoration(
            color: offWhite, borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (ExpertFilterModel filter in globalBloc.filters) ...[
                Text(
                  filter.heading,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: GoogleFonts.epilogue().fontFamily,
                  ),
                ),
                const Divider(),
                const SizedBox(height: 10),
                for (ExpertFilterValues filterValue in filter.filterValues) ...[
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 14,
                        width: 14,
                        child: Checkbox(
                          value: filterValue.isSelected,
                          onChanged: (val) {
                            // setState(() {
                            //   filterValue.isSelected = val!;
                            //   // Add your logic here
                            //   context.read<GlobalBloc>().updateExpertFilters();
                            // });
                            widget.onFilterValueSelected(
                                filterValue, val ?? false);
                          },
                          splashRadius: 0,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        filterValue.value,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: GoogleFonts.epilogue().fontFamily,
                        ),
                      ),
                      Spacer(),
                      if (filterValue.count != '0')
                        Text(
                          filterValue.count.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: GoogleFonts.epilogue().fontFamily,
                          ),
                        ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 18),
                ],
                const SizedBox(height: 30),
              ],
            ],
          ),
        ),
      );
    });
  }
}
