//
//  PDFViewWrapper.swift
//  TankerCoPirate
//
//  Created by sean ogden on 1/17/21.
//

import SwiftUI
import PDFKit

struct PDFViewUI : UIViewRepresentable {

    @EnvironmentObject var modelData : ModelData
    let pdfView = PDFView()
    var url: URL?
    init(url : URL) {
        self.url = url
    }

    func makeUIView(context: Context) -> UIView {

        if let url = url {
            pdfView.document = PDFDocument(url: url)
        }

        pdfView.autoScales = true
        pdfView.displayDirection = .vertical
        drawLine()
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        drawLine()
    }
    
    func drawLine() {
        //Hard Coded parameters to draw a line from the bottom left of the
        //screen to 40 West, 40 North
        let path = UIBezierPath()
        
        //Coordinates of the corners of the actual map within the pdf
        //path.move(to:CGPoint(x:18,y:18))
        //path.addLine(to:CGPoint(x:2800,y:1983))
        
        //move the cursor to the edge of the margin on the bottom left.
        //path.move(to:CGPoint(x:18,y:18))
        //draw a line to 40W/40N
        //path.addLine(to:zeroizeNarc(lambert(longitude:-40.0, latitude:40.0)))
        for coord : CGPoint in modelData.routeCoords {
            let loc : CGPoint = zeroizeNarc(lambert(longitude:Double(coord.x), latitude:Double(coord.y)))
            path.addLine(to:loc)
            path.move(to:loc)
        }
        //Set up an annotation object to put our line, and then add to the page
        let page = pdfView.currentPage!
        
        for a in page.annotations {
            page.removeAnnotation(a)
        }
        
        print(page.bounds(for:.mediaBox))

        let border = PDFBorder()
        border.lineWidth = 6.0 // Set your line width here
        let annotation = PDFAnnotation(bounds: page.bounds(for: pdfView.displayBox), forType: .ink, withProperties: nil)
        annotation.color = .red
        annotation.border = border
        annotation.add(path)
        page.addAnnotation(annotation)
        //pdfView.usePageViewController(false)
        //pdfView.scaleFactor = pdfView.scaleFactorForSizeToFit * 2
        //print(annotation.bounds)
        /*print(path.bounds)
        print (page.bounds(for:pdfView.displayBox).width)
        print (path.bounds.width)
        if path.bounds.width == 0 { return }
        let xscale = page.bounds(for:pdfView.displayBox).width / (path.bounds.width)
        print (xscale)
        pdfView.scaleFactor = pdfView.scaleFactorForSizeToFit * xscale / 1.5
        pdfView.go(to:path.bounds.offsetBy(dx:40,dy:100), on:page)
        print(pdfView.bounds)*/
        
    }

}


func lambert(longitude: Double, latitude: Double) -> CGPoint {
    func qphp(_ Pn:Double) -> Double {
        0.25 * Double.pi + 0.5 * Pn
    }

    func cot(_ x:Double) -> Double {
        cos(x) / sin(x)
    }

    func sec(_ x:Double) -> Double {
        1.0 / cos(x)
    }

    func rad(_ x:Double) -> Double {
        x * Double.pi / 180.0
    }

    func deg(_ x:Double) -> Double {
        x * 180.0 / Double.pi
    }
    
    //These are hard coded for now, they are constants specific to the north atlantic
    //oceanic planning chart (NARCZ)
    let L0 = rad(-24.0) // 0 longitude
    let P0 = rad(32.5) // 0 latitude
    let P1 = rad(14.0) // standard parallel 1
    let P2 = rad(51.0) // standard parallel 2
    let L = rad(longitude) // longitude to plot
    let P = rad(latitude) // latitude latitude to plot



    let n = log(cos(P1) * sec(P2)) / log(tan(qphp(P2)) * cot(qphp(P1)))
    let F = cos(P1) * pow(tan(qphp(P1)), n) / n
    let r = F * pow(cot(qphp(P)), n)
    let r0 = F * pow(cot(qphp(P0)), n)

    let x = deg(r * sin(n * (L - L0)))
    let y = deg(r0 - r * cos(n * (L - L0)))
    
    //Return easting and westing (basically coordinates based on a square grid)
    return CGPoint(x:x, y:y)
}

func zeroize(_ pt: CGPoint, origin: CGPoint, scale: CGPoint) -> CGPoint {
    //The origin of our map is actually somewhere in the middle, so we need
    //to shift it to the bottom right, and then scale our coordinates to
    //get (0,0) as bottom left and (100, 100) os top right
    var newPoint = CGPoint(x:0.0,y:0.0)
    newPoint.x = pt.x - origin.x
    newPoint.y = pt.y - origin.y
    newPoint.x = newPoint.x/scale.x
    newPoint.y = newPoint.y/scale.y
    return newPoint
}

func zeroizeNarc(_ pt: CGPoint) -> CGPoint {
    //This function shifts and scales our 0-100 scale to fit our PDF dimensions.
    //The 18.0 offset is where the margin ends, and then 2800 and 1983 or the upper
    //right corner of the map at the edge of the margin.
    let scale = CGPoint(x:72.8038558502012, y:51.560186976602445)
    let origin = CGPoint(x:-54.416948753361076, y:-18.421245080535243)
    
    var newPoint = zeroize(pt, origin:origin, scale:scale)
    print(newPoint)
    newPoint.x = newPoint.x * (2800.0 - 18.0) + 18.0
    newPoint.y = newPoint.y * (1983.0 - 18.0) + 18.0
    print(newPoint)
    return newPoint
}


