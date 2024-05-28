import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outsourced_pages/utils/formatting/app_theme.dart';
import 'package:outsourced_pages/utils/models/extent_model.dart';
import 'package:outsourced_pages/utils/models/available_expert.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class ExpertTable extends StatefulWidget {
  ExpertTable(
      {super.key, required this.experts, required this.onFavoriteChange});
  final List<AvailableExpert> experts;
  final Function(bool, AvailableExpert) onFavoriteChange;

  @override
  State<ExpertTable> createState() => _ExpertTableState();
}

class _ExpertTableState extends State<ExpertTable> {
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
          child: TableView.builder(
            // verticalDetails: ScrollableDetails.vertical(
            //   controller: _verticalController,
            // ),
            // horizontalDetails:
            //     ScrollableDetails.horizontal(controller: _horizontalController),
            cellBuilder: _buildCell,
            columnCount: 19,
            rowCount: widget.experts.length + 1,
            columnBuilder: _buildColumnSpan,
            pinnedRowCount: 1,
            rowBuilder: (val) {
              return Span(
                  extent: FixedSpanExtent(val == 0 ? 100 : 150),
                  backgroundDecoration: TableSpanDecoration(
                    color: (val) % 2 == 0 && val != 0 ? Colors.grey[300] : null,
                  ));
            },
          ),
        ),
      ),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    if (vicinity.row == 0) {
      return TableViewCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  header[vicinity.column],
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.epilogue().fontFamily),
                ),
              ),
              if (header[vicinity.column] == 'AI match') ...[
                const SizedBox(width: 5),
                Image.asset('assets/icons/pencil.png', height: 24, width: 24)
              ]
            ],
          ),
        ),
      );
    }

    return TableViewCell(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: _buildCellData(
          widget.experts[vicinity.row - 1],
          vicinity.column,
        ),
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

  TableSpan _buildRowSpan(int index) {
    final TableSpanDecoration decoration = TableSpanDecoration(
      color: index.isEven ? Colors.purple[100] : null,
      border: const TableSpanBorder(
        trailing: BorderSide(
          width: 3,
        ),
      ),
    );

    switch (index % 3) {
      case 0:
        return TableSpan(
          backgroundDecoration: decoration,
          extent: const FixedTableSpanExtent(100),
          recognizerFactories: <Type, GestureRecognizerFactory>{
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer t) =>
                  t.onTap = () => print('Tap row $index'),
            ),
          },
        );
      case 1:
        return TableSpan(
          backgroundDecoration: decoration,
          extent: const FixedTableSpanExtent(65),
          cursor: SystemMouseCursors.click,
        );
      case 2:
        return TableSpan(
          backgroundDecoration: decoration,
          extent: const FractionalTableSpanExtent(0.15),
        );
    }
    throw AssertionError(
      'This should be unreachable, as every index is accounted for in the '
      'switch clauses.',
    );
  }

  List<String> header = [
    'Favorite',
    'Comment',
    'Status',
    'Name',
    'Title',
    'Company',
    'Year',
    'Geography',
    'Angle',
    'AI match',
    'AI analysis',
    'Comments from network',
    'Availability',
    'Network',
    'Cost (1 hr)',
    'Role in the decision making process?',
    'Decision making criteria?',
    'Companies purchased from?',
    'Key trends?'
  ];
  final List<ExtentModel> _columnExtents = [
    ExtentModel(73),
    ExtentModel(182),
    ExtentModel(175),
    ExtentModel(126),
    ExtentModel(126),
    ExtentModel(126),
    ExtentModel(126),
    ExtentModel(126),
    ExtentModel(97),
    ExtentModel(176),
    ExtentModel(235),
    ExtentModel(235),
    ExtentModel(146),
    ExtentModel(146),
    ExtentModel(146),
    ExtentModel(227),
    ExtentModel(227),
    ExtentModel(247),
    ExtentModel(281),
  ];
  Widget _buildCellData(AvailableExpert expertData, int columnIndex) {
    switch (columnIndex) {
      case 0:
        return Column(
          children: [
            InkWell(
                onTap: () {
                  widget.onFavoriteChange(!expertData.favorite, expertData);
                },
                child: Image.asset(
                    (expertData.favorite)
                        ? 'assets/icons/star_filled.png'
                        : 'assets/icons/star_outline.png',
                    height: 24,
                    width: 24)),
          ],
        );
      case 1:
        return Text(expertData.comments,
            style: TextStyle(
                fontFamily: GoogleFonts.epilogue().fontFamily, fontSize: 12));
      case 2:
        return SizedBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        color: expertData.status == 'Active'
                            ? const Color(0xffFFDD00)
                            : const Color(0xffF97071),
                        borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.min,

                          children: [
                            Text(expertData.status,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        );
      case 3:
        return Text(expertData.name,
            style: TextStyle(fontFamily: GoogleFonts.epilogue().fontFamily));
      case 4:
        return Text(expertData.title,
            style: TextStyle(fontFamily: GoogleFonts.epilogue().fontFamily));
      case 5:
        return Text(expertData.company,
            style: TextStyle(fontFamily: GoogleFonts.epilogue().fontFamily));
      case 6:
        return Text(expertData.yearsAtCompany,
            style: TextStyle(fontFamily: GoogleFonts.epilogue().fontFamily));
      case 7:
        return Text(expertData.geography,
            style: TextStyle(fontFamily: GoogleFonts.epilogue().fontFamily));
      case 8:
        return Text(expertData.angle,
            style: TextStyle(fontFamily: GoogleFonts.epilogue().fontFamily));
      case 9:
        return Text("${expertData.AIAssessment}%",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: expertData.AIAssessment >= 90
                    ? labelBgColor
                    : expertData.AIAssessment >= 70
                        ? const Color(0xffFFD600)
                        : const Color(0xffFF0000)));
      case 10:
        return Text(expertData.aIAnalysis,
            style: TextStyle(
                fontFamily: GoogleFonts.epilogue().fontFamily, fontSize: 12));
      case 11:
        return Text(expertData.comments,
            style: TextStyle(
                fontFamily: GoogleFonts.epilogue().fontFamily, fontSize: 12));
      case 12:
        return Text(expertData.availability,
            style: TextStyle(
                fontFamily: GoogleFonts.epilogue().fontFamily, fontSize: 12));
      case 13:
        return Text(expertData.expertNetworkName,
            style: TextStyle(fontFamily: GoogleFonts.epilogue().fontFamily));
      case 14:
        return Text(expertData.cost.toString(),
            style: TextStyle(fontFamily: GoogleFonts.epilogue().fontFamily));
      case 15:
        return Text(expertData.screeningQuestions[0],
            style: TextStyle(
                fontFamily: GoogleFonts.epilogue().fontFamily, fontSize: 12));
      case 16:
        return Text(expertData.screeningQuestions[1],
            style: TextStyle(
                fontFamily: GoogleFonts.epilogue().fontFamily, fontSize: 12));
      case 17:
        return Text(expertData.screeningQuestions[2],
            style: TextStyle(
                fontFamily: GoogleFonts.epilogue().fontFamily, fontSize: 12));
      case 18:
        return Text(expertData.trends,
            style: TextStyle(
                fontFamily: GoogleFonts.epilogue().fontFamily, fontSize: 12));

      default:
        return Text('No data',
            style: TextStyle(fontFamily: GoogleFonts.epilogue().fontFamily));
    }
  }
}
