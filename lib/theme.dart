import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // *****************
  // static colors
  // *****************
  static final Color _lightPrimaryColor = Colors.blueGrey.shade50;
  static final Color _lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Colors.blue;

  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _appbarColorDark = Colors.blueGrey.shade800;

  static const Color _iconColor = Colors.white;

  static const Color _accentColor = Color.fromRGBO(74, 217, 217, 1);

  // *****************
  // Text Style - light
  // *****************
  static const TextStyle _lightHeadingText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "Rubik",
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _lightBodyText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "Rubik",
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightHeadingText,
    bodyLarge: _lightBodyText,
  );

  // *****************
  // Text Style - dark
  // *****************
  static final TextStyle _darkThemeHeadingTextStyle = _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyTextStyle = _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: _darkThemeHeadingTextStyle,
    bodyLarge: _darkThemeBodyTextStyle,
  );

  // *****************
  // Theme light/dark
  // *****************

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    appBarTheme: const AppBarTheme(
      color: _appbarColorLight,
      iconTheme: IconThemeData(color: _iconColor),
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      secondary: _accentColor,
      primaryContainer: _lightPrimaryVariantColor,
    ),
    textTheme: _lightTextTheme,
    bottomAppBarTheme: const BottomAppBarTheme(color: _appbarColorLight),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: AppBarTheme(
      color: _appbarColorDark,
      iconTheme: const IconThemeData(color: _iconColor),
    ),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _accentColor,
      onPrimary: _darkOnPrimaryColor,
      primaryContainer: _darkPrimaryVariantColor,
    ),
    textTheme: _darkTextTheme,
    bottomAppBarTheme: BottomAppBarTheme(color: _appbarColorDark),
  );
}


  generatePDFFile() async {
    final img = await rootBundle.load('assets/images/headerlogo.png');
    final imageBytes = img.buffer.asUint8List();
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            header: (context) {
              return pw.Column(children: [
                pw.Container(
                  // height: 100,
                  // width: 200,
                  alignment: pw.Alignment.topLeft,
                  child: pw.Image(pw.MemoryImage(imageBytes),
                      width: 100, height: 100),
                ),
                pw.Divider(color: PdfColors.black, thickness: 0.5)
              ]);
            },
            footer: (context) {
              return pw.Column(children: [
                pw.Divider(color: PdfColors.black, thickness: 0.5),
                pw.Align(
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Row(children: [
                      pw.Text("Blood Pressure Report"),
                      pw.Align(
                        alignment: pw.Alignment.topLeft,
                        child: pw.UrlLink(
                          destination: 'https://wikipedia.org/wiki/PDF',
                          child: pw.Text(
                            'https://wikipedia.org/wiki/PDF',
                            style: const pw.TextStyle(
                              color: PdfColors.pink100,
                            ),
                          ),
                        ),
                      ),
                    ])),
              ]);
            },
            build: (pw.Context context) => <pw.Widget>[
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text('Blood Pressure Report',
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black)),
                  pw.SizedBox(
                    height: 30,
                  ),
                  pw.Table.fromTextArray(data: <List<String>>[
                    <String>['Person', 'Report Date', 'Systolic', 'Diastolic'],
                    for (var i = 0; i < model.records.length; i++)
                      <String>[
                        model.records[i].person,
                        model.records[i].reportDate,
                        model.records[i].systolic,
                        model.records[i].diastolic
                      ]
                  ])
                  // pw.TableHelper.fromTextArray(
                  //   context: context,
                  //   data: const <List<String>>[
                  //     <String>['Date', 'PDF Version', 'Acrobat Version'],
                  //     <String>['1993', 'PDF 1.0', 'Acrobat 1'],
                  //     <String>['1994', 'PDF 1.1', 'Acrobat 2'],
                  //     <String>['1996', 'PDF 1.2', 'Acrobat 3'],
                  //     <String>['1999', 'PDF 1.3', 'Acrobat 4'],
                  //     <String>['2001', 'PDF 1.4', 'Acrobat 5'],
                  //     <String>['2003', 'PDF 1.5', 'Acrobat 6'],
                  //     <String>['2005', 'PDF 1.6', 'Acrobat 7'],
                  //     <String>['2006', 'PDF 1.7', 'Acrobat 8'],
                  //     <String>['2008', 'PDF 1.7', 'Acrobat 9'],
                  //     <String>['2009', 'PDF 1.7', 'Acrobat 9.1'],
                  //     <String>['2010', 'PDF 1.7', 'Acrobat X'],
                  //     <String>['2012', 'PDF 1.7', 'Acrobat XI'],
                  //     <String>['2017', 'PDF 2.0', 'Acrobat DC'],
                  //   ],
                  // ),
                ]),
      );

      final filename = "bloodpressure${DateTime.now().toString()}.pdf";
      final path = await getExternalStorageDirectory();
      final file = File("${path.path}/$filename");

      await file.writeAsBytes(await pdf.save());

      try {
        if (await file.exists()) {
          OpenFile.open(file.path);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No app available to open the PDF'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e, _) {
      print("print the pdf");
      print(e);
      print(_);
    }
  }
