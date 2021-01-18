//
//  ContentView.swift
//  TankerCoPirate
//
//  Created by sean ogden on 1/18/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DocumentView(pdfView: PDFViewUI(url:Bundle.main.url(forResource:"NARC", withExtension: "pdf")!))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
