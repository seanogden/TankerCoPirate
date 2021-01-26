//
//  ModelData.swift
//  TankerCoPirate
//
//  Created by sean ogden on 1/18/21.
//

import Foundation
import SwiftUI

class ModelData: ObservableObject {
    @Published var routeCoords : [CGPoint] = [CGPoint]()
    @Published var routeText : String = "" {
        didSet {
            let routeSplit = routeText.split(separator: " ")
            var routeCoords = [CGPoint]()
            
            for point in routeSplit {
                //print(point)
                if let pt = GPSCoordinate(String(point))?.toCGPoint() {
                    routeCoords.append(pt)
                }
                else {
                    return
                }
            }
            
            self.routeCoords = routeCoords
        }
    }
    @Published var positionCoords = [LocationTime]()

}

