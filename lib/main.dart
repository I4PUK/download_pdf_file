import 'package:download_pdf_file/bloc/pdf_download_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: BlocProvider(
          create: (context) => PdfInvoiceBloc(),
          child: PaymentInfoWidget(),
        ),
      ),
    );
  }
}

class PaymentInfoWidget extends StatelessWidget {
  const PaymentInfoWidget();

  final bool fileExists = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donwload PDF file'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: Theme.of(context).dividerColor, width: 1)),
        child: BlocListener<PdfInvoiceBloc, PdfInvoiceState>(
          listener: (context, state) {
            if (state is PdfInvoiceLoadingFailed) {
              _showErrorSnackBar(context);
            }
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Квитанция за ${DateFormat('LLLL yyyy').format(DateTime.now())}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    if (fileExists) ...[
                      SizedBox(width: 32),
                      IconButton(
                        constraints: BoxConstraints(maxHeight: 20),
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.file_download,
                        ),
                        onPressed: () {
                          BlocProvider.of<PdfInvoiceBloc>(context)
                              .add(PdfInvoiceDownload(context));
                        },
                      ),
                    ],
                  ],
                ),
              ),
              Divider(height: 32, thickness: 1),
              const SizedBox(height: 8),
              Text(
                'Озон',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Divider(height: 32, thickness: 1),
              _infoRow(
                title: 'Задолженность',
                info: '10000',
              ),
              _infoRow(
                title: 'Внесено',
                info: '2500',
              ),
              _infoRow(
                title: 'Начислено',
                info: '7500',
              ),
              _infoRow(
                title: 'Задолженность\nна конец',
                info: '5000',
                boldFont: true,
                padding: EdgeInsets.all(0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Не удалось загрузить файл'), Icon(Icons.error)],
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
  }

  Widget _infoRow({
    @required String title,
    @required String info,
    EdgeInsets padding,
    bool boldFont = false,
  }) {
    return Builder(
      builder: (context) => Padding(
        padding: padding ?? const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                '$title: ',
                softWrap: true,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight:
                          boldFont ? FontWeight.w500 : FontWeight.normal,
                    ),
              ),
              Spacer(),
              Text(
                info,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight:
                          boldFont ? FontWeight.w500 : FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
