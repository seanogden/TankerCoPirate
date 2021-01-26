//
//  GPSCoordinate.swift
//  TankerCoPirate
//
//  Created by sean ogden on 1/18/21.
//

import Foundation
import SwiftUI

struct GPSCoordinate {
    let latitude: Double?
    let longitude: Double?
    
    init?(_ string:String) {
        let coords = string.split(separator: "/")
        if coords.count != 2 {
            return nil
        }
        
        if let lon = Double(coords[0]) {
            longitude = lon
        }
        else {
            return nil
        }
        
        if let lat = Double(coords[1]) {
            latitude = lat
        }
        else {
            return nil
        }
        
        
    }
    
    func toCGPoint() -> CGPoint? {
        if latitude == nil || longitude == nil { return nil }
        
        return CGPoint(x:latitude!, y:longitude!)
    }
}
