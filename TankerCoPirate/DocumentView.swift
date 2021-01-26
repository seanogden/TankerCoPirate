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
    @State private var routeText = "ROUTE"
    @EnvironmentObject var modelData : ModelData
    
    var body: some View {
        NavigationView{
        VStack {
            ZStack{
                TextEditor(text:$modelData.routeText)
                    .textCase(.uppercase)
                    .frame(height:100)
                    .padding(10)
                
            }
            pdfView
            NavigationLink(destination:CoordinateList()){
                Text("Add Points")
            }
        }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DocumentView_Previews: PreviewProvider {
    
    static var previews: some View {
        DocumentView(
            pdfView:PDFViewUI(url:Bundle.main.url(forResource:"NARC", withExtension: "pdf")!))
    }
}
