part of 'pdf_download_bloc.dart';

abstract class PdfInvoiceState {
  const PdfInvoiceState();
}

class PdfInvoiceInitialState extends PdfInvoiceState {
  const PdfInvoiceInitialState();
}

class PdfInvoiceLoadingFailed extends PdfInvoiceState {
  const PdfInvoiceLoadingFailed();
}
