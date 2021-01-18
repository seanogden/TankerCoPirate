//
//  DocumentView.swift
//  TankerCoPirate
//
//  Created by sean ogden on 1/17/21.
//
import SwiftUI
import PDFKit

struct DocumentView: View {
    var pdfView: PDFViewUI!

    var body: some View {
        VStack {
            pdfView
            Button("Done", action: {})
        }
    }
}

struct DocumentView_Previews: PreviewProvider {
    
    static var previews: some View {
        DocumentView(
            pdfView:PDFViewUI(url:Bundle.main.url(forResource:"NARC", withExtension: "pdf")!))
    }
}
