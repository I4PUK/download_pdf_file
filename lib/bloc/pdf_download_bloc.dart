import 'package:bloc/bloc.dart';
import 'package:download_pdf_file/utilities/data_load_overlay.dart';
import 'package:download_pdf_file/services/pdf_download_service.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

part 'pdf_download_event.dart';
part 'pdf_download_state.dart';

class PdfInvoiceBloc extends Bloc<PdfInvoiceEvent, PdfInvoiceState> {
  @override
  PdfInvoiceState get initialState => PdfInvoiceInitialState();

  @override
  Stream<PdfInvoiceState> mapEventToState(PdfInvoiceEvent event) async* {
    if (event is PdfInvoiceDownload) {
      if (await _hasFile) {
        yield* _downloadPdfInvoice(event.context);
      } else {
        yield PdfInvoiceLoadingFailed();
      }
    }
  }

  Future<bool> get _hasFile async => PdfDownloadService().hasFile();

  Stream<PdfInvoiceState> _downloadPdfInvoice(BuildContext context) async* {
    final path = await DataLoadOverlay.loadData(
      context: context,
      futureFunc: PdfDownloadService().downloadInvoice(
        context: context,
      ),
    );

    if (path != '') {
      OpenFile.open(path);
    } else {
      yield PdfInvoiceLoadingFailed();
    }
  }
}
