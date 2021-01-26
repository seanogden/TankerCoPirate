//
//  LocationTime.swift
//  TankerCoPirate
//
//  Created by sean ogden on 1/19/21.
//
import SwiftUI
import Foundation

class LocationTime : ObservableObject, Identifiable, Hashable {
    
    static func == (lhs: LocationTime, rhs: LocationTime) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @Published var id = UUID()
    @Published var lat: String = "0.0"
    @Published var lon: String = "0.0"
    @Published var timestamp: String =  {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        return dateFormatter.string(from: date)
    }()
}
