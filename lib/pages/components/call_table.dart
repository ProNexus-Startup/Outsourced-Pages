import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:outsourced_pages/utils/formatting/app_theme.dart';
import 'package:outsourced_pages/utils/models/extent_model.dart';
import 'package:outsourced_pages/utils/models/call_tracker.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class CallTable extends StatefulWidget {
  const CallTable({super.key, required this.callsList});
  final List<CallTracker> callsList;

  @override
  State<CallTable> createState() => _ExpertTableState();
}

class _ExpertTableState extends State<CallTable> {
  late final ScrollController _verticalController = ScrollController();
  late final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        controller: _horizontalController,
        interactive: true,
        thumbVisibility: true,
        trackVisibility: true,
        child: Scrollbar(
          controller: _verticalController,
          interactive: true,
          thumbVisibility: true,
          trackVisibility: true,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16, left: 16),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
                color: offWhite, borderRadius: BorderRadius.circular(10)),
            child: TableView.builder(
              // verticalDetails: ScrollableDetails.vertical(
              //   controller: _verticalController,
              // ),
              // horizontalDetails:
              //     ScrollableDetails.horizontal(controller: _horizontalController),
              cellBuilder: _buildCell,
              columnCount: 16,
              rowCount: widget.callsList.length + 1,
              columnBuilder: _buildColumnSpan,
              pinnedRowCount: 1,
              rowBuilder: (val) {
                return Span(extent: FixedSpanExtent(val == 0 ? 66 : 71));
              },
            ),
          ),
        ),
      ),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    if (vicinity.row == 0) {
      return TableViewCell(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  header[vicinity.column],
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.epilogue().fontFamily),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return TableViewCell(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: _buildCellData(
                widget.callsList[vicinity.row - 1],
                vicinity.column,
              ),
            ),
          ),
          if (vicinity.column < 9 && vicinity.row > 0) _divider,
        ],
      ),
    );
  }

  TableSpan _buildColumnSpan(int index) {
    return TableSpan(
      extent: _columnExtents[index].isFixed
          ? FixedTableSpanExtent(_columnExtents[index].extent)
          : FractionalTableSpanExtent(_columnExtents[index].extent),
    );
  }

  List<String> header = [
    'Invite sent to team',
    'Full  Name',
    'Date',
    'Time (EST )',
    'Length',
    'Status',
    'Angle',
    'Title',
    'Organization',
    'Company Type',
    'Source',
    'Cost',
    'Paid EN',
    'XXSourced by Company Name',
    'Quote Attribution',
    'Rating',
  ];
  final List<ExtentModel> _columnExtents = [
    ExtentModel(118),
    ExtentModel(153),
    ExtentModel(103),
    ExtentModel(123),
    ExtentModel(92),
    ExtentModel(150),
    ExtentModel(260),
    ExtentModel(190),
    ExtentModel(150),
    ExtentModel(150),
    ExtentModel(100),
    ExtentModel(75),
    ExtentModel(90),
    ExtentModel(268),
    ExtentModel(257),
    ExtentModel(208),
  ];
  Widget _buildCellData(CallTracker callData, int columnIndex) {
    switch (columnIndex) {
      case 0:
        return Column(
          children: [
            (callData.inviteSent)
                ? Image.asset('assets/icons/user_check.png',
                    height: 24, width: 24)
                : Text('No', style: _textStyle),
          ],
        );
      case 1:
        return Text(callData.comments, style: _textStyle);
      case 2:
        return Text(DateFormat('MM/dd/yyyy').format(callData.dateAddedCall),
            style: _textStyle);
      case 3:
        return Text(DateFormat('hh:mm a').format(callData.dateAddedCall),
            style: _textStyle);
      case 4:
        return Text('2 Hours', style: _textStyle);
      case 5:
        return Column(
          children: [
            Container(
                // height: 24,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: callData.status == 'Active' ||
                          callData.status == 'Completed'
                      ? greenColor.withOpacity(0.15)
                      : yellowColor.withOpacity(0.21),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: callData.status == 'Active' ||
                              callData.status == 'Completed'
                          ? labelBgColor
                          : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(callData.angle,
                        style: TextStyle(
                          fontFamily: GoogleFonts.epilogue().fontFamily,
                          color: callData.status == 'Active' ||
                                  callData.status == 'Completed'
                              ? labelBgColor
                              : Colors.black,
                        )),
                  ],
                )),
          ],
        );
      case 6:
        return Text(callData.angle, style: _textStyle);
      case 7:
        return Text(callData.title, style: _textStyle);
      case 8:
        return Text(callData.organizationName, style: _textStyle);
      case 9:
        return Text(callData.companyType, style: _textStyle);
      case 10:
        return Text(callData.source, style: _textStyle);
      case 11:
        return Text(callData.cost.toString(), style: _textStyle);
      case 12:
        return Text(callData.paidStatus ? 'Yes' : 'No',
            style: TextStyle(
                fontFamily: GoogleFonts.epilogue().fontFamily,
                color: callData.paidStatus ? Colors.green : Colors.red));
      case 13:
        return Text(callData.sourceByCompany, style: _textStyle);

      case 14:
        return Text(callData.attribution, style: _textStyle);
      case 15:
        return ratingWidget(callData.rating ?? 0);

      default:
        return Text('No data',
            style: TextStyle(fontFamily: GoogleFonts.epilogue().fontFamily));
    }
  }

  final Divider _divider = const Divider(
    color: greyColor,
    thickness: 1,
    height: 2,
  );

  final TextStyle _textStyle = TextStyle(
      fontFamily: GoogleFonts.epilogue().fontFamily, color: greyColor);

  Widget ratingWidget(int rating) {
    int totalRating = 5;
    return Row(
      children: List.generate(
        totalRating,
        (index) => Icon(
          Icons.star,
          color: index < rating ? blueColor : Colors.grey,
        ),
      ),
    );
  }
}
