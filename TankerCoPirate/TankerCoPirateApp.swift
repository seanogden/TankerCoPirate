//
//  TankerCoPirateApp.swift
//  TankerCoPirate
//
//  Created by sean ogden on 1/18/21.
//

import SwiftUI

@main
struct TankerCoPirateApp: App {
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
