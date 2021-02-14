part of 'pdf_download_bloc.dart';

abstract class PdfInvoiceEvent {
  const PdfInvoiceEvent();
}

class PdfInvoiceDownload extends PdfInvoiceEvent {
  final BuildContext context;

  const PdfInvoiceDownload(this.context);
}
