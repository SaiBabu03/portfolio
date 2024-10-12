import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

void main() => runApp(const MaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));

const PdfColor purple = PdfColor.fromInt(0xff9f74c7);
const PdfColor iconcolors = PdfColor.fromInt(0xff9F74C5);
const PdfColor yellow = PdfColor.fromInt(0xffF29E00);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List? _pdfData;
  @override
  void initState() {
    super.initState();
    _generateAndShowResume();
  }

  Future<void> _generateAndShowResume() async {
    // Generate the resume PDF and store it in _pdfData state
    final pdfData = await generateResume(PdfPageFormat.a4);
    setState(() {
      _pdfData = pdfData;
    });
  }

  String pdfPath = "";

  Future<Uint8List> generateResume(PdfPageFormat format) async {
    final pdf = pw.Document();
    final titlefont = await PdfGoogleFonts.oswaldBold();
    final addressfont = await PdfGoogleFonts.eBGaramondRegular();
    final pageTheme = await _myPageTheme(format);
    final profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/profilephoto.jpg')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.MultiPage(
          pageTheme: pageTheme,
          build: (pw.Context context) => [
                pw.Partitions(children: [
                  pw.Partition(
                    child: pw.Container(
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                          pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(width: 18),
                                pw.ClipOval(
                                    child: pw.Container(
                                        height: 168,
                                        child: pw.Image(profileImage))),
                                pw.Column(children: [
                                  pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(top: 20)),
                                  pw.Text("BOBBA SAI BABU",
                                      style: pw.TextStyle(
                                          font: titlefont,
                                          fontSize: 30,
                                          color: PdfColors.white,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(top: 40)),
                                  pw.Text("ANDROID APP DEVELOPER",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        font: titlefont,
                                        fontSize: 15,
                                        color: PdfColors.black,
                                      ))
                                ]),
                              ]),
                          pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 20)),
                          pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Icon(const pw.IconData(0xe0b0),
                                          color: iconcolors),
                                      pw.SizedBox(height: 5),
                                      pw.Icon(const pw.IconData(0xe0be),
                                          color: iconcolors),
                                      pw.SizedBox(height: 5),
                                      pw.Icon(const pw.IconData(0xe157),
                                          color: iconcolors),
                                      pw.SizedBox(height: 5),
                                      pw.Icon(const pw.IconData(0xe0c8),
                                          color: iconcolors)
                                    ]),
                                pw.SizedBox(width: 7),
                                pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text("+91 9290816685",
                                          textAlign: pw.TextAlign.start,
                                          style: pw.TextStyle(
                                            font: addressfont,
                                            fontSize: 20,
                                            color: PdfColors.black,
                                          )),
                                      pw.SizedBox(height: 5),
                                      _UrlText("saibabubobba2003@gmail.com",
                                          "saibabubobba2003@gmail.com"),
                                      pw.SizedBox(height: 5),
                                      _UrlText("https://github.com/SaiBabu03",
                                          "https://github.com/SaiBabu03"),
                                      pw.SizedBox(height: 5),
                                      pw.Text("VisakhaPatnam,\n AndhraPradesh.",
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            letterSpacing: 1,
                                            font: addressfont,
                                            fontSize: 15,
                                            color: PdfColors.black,
                                          )),
                                    ])
                              ]),
                          pw.Container(
                              width: format.width,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.SizedBox(height: 6),
                                    _Category(title: "EDUCATION"),
                                    _Block(
                                      title: 'B.Tech IN COMPUTER SCIENCE',
                                      titledata:
                                          'AVANTHI INSTITUTE OF ENGINEERING AND TECHNOLOGY.\n2021 - Pursuing',
                                    ),
                                    _Block(
                                      title: 'INTERMEDIATE',
                                      titledata:
                                          'SRI CHAITANYA JUNIOR.\n2019 - 2021',
                                    ),
                                    _Block(
                                      title: 'SSC',
                                      titledata:
                                          'SRI VENKATESWARA SCHOOL.\n2019',
                                    ),
                                    _Category(title: 'SKILLS'),
                                    pw.Text(
                                        "FLUTTER, DART, REST API's, FIREBASE, HTML, CSS, JAVASCRIPRT, C, PYTHON, KOTLIN, ANDROID STUDIO",
                                        style: const pw.TextStyle(
                                            wordSpacing: 2, lineSpacing: 2)),
                                  ])),
                          pw.SizedBox(height: 170),
                          _Category(title: 'PROJECTS'),
                          _Block(
                              title: 'BMI CALCULATOR',
                              titledata:
                                  "BMI CALCULATOR shows the body mass index of the person using the Height and Weight of the person."),
                          pw.SizedBox(height: 9),
                          _Block(
                              title: 'QUIZZLER APP',
                              titledata:
                                  "Quizzer pp is a basic quiz APP developed with FLUTTER and DART which takes answer in true or false form and shows the final score."),
                          _Block(
                              title: "ClimaCast",
                              titledata:
                                  "ClimaCast is weather app developed with FLUTTER, DART and API’s. It shows the weather based on the search location and the Current location of the user."),
                        ])),
                  ),
                  pw.Partition(
                      width: 215,
                      child: pw.Container(
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                            pw.SizedBox(height: 140),
                            _Category(title: "INTERNSHIP"),
                            _Block(
                              title: 'GOOGLE ANDROID DEVELOPER',
                              titledata: 'VIRTUAL\nAPR - JUN 2024',
                            ),
                            _Block(
                              title: 'AMAZON WEB SERVICES',
                              titledata: 'Grafx IT Solutions.\nAUG - OCT 2023',
                            ),
                            _Block(
                              title: 'SALESFORCE',
                              titledata: 'SMART BRIDGE.\nNOV 2023 - JAN 2024',
                            ),
                            _Category(title: 'CERTIFICATIONS'),
                            _Block(
                              title: 'FLUTTER',
                              titledata: 'THINQBATOR',
                            ),
                            _Block(
                                title: 'FRONT - END DEVELOPMENT',
                                titledata: 'Edx Online Courses'),
                            _Block(
                                title: 'BASICS OF PYTHON',
                                titledata: 'INFOSYS SPRINGBOARD')
                          ]))),
                ]),
              ]),
    );
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/resume.pdf");
    await file.writeAsBytes(await pdf.save());
    setState(() {
      pdfPath = file.path;
    });
    return pdf.save(); // Save the document and return it as Uint8List
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("PDF View")),
      body: _pdfData == null
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show a loading indicator until the PDF is generated
          : PdfPreview(
              // Once the PDF is generated, display it
              build: (format) => _pdfData!,
              allowPrinting: true, // Optional: Allow printing
              allowSharing: true, // Optional: Allow sharing
            ),
    );
  }
}

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(text,
          style: const pw.TextStyle(
              decoration: pw.TextDecoration.underline,
              color: PdfColors.blue,
              fontSize: 15)),
    );
  }
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/orange.svg');
  format = format.applyMargin(
      left: 0.0 * PdfPageFormat.cm,
      top: 2.0 * PdfPageFormat.cm,
      right: 0.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
          ignoreMargins: true,
          child: pw.Container(
              decoration: pw.BoxDecoration(
                  image: pw.DecorationSvgImage(svg: bgShape))));
    },
  );
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: purple,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(title,
          textScaleFactor: 1.5,
          style: pw.TextStyle(
              color: PdfColors.white, fontWeight: pw.FontWeight.bold)),
    );
  }
}

class _Block extends pw.StatelessWidget {
  _Block({
    required this.title,
    required this.titledata,
  });
  final String titledata;
  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: yellow,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Text(title,
                    style: pw.Theme.of(context).defaultTextStyle.copyWith(
                        fontWeight: pw.FontWeight.bold, fontSize: 15)),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border:
                    pw.Border(left: pw.BorderSide(color: yellow, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(titledata, style: const pw.TextStyle(fontSize: 15)),
                ]),
          ),
        ]);
  }
}
