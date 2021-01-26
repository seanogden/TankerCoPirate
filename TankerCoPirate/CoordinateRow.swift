//
//  CoordinateRow.swift
//  TankerCoPirate
//
//  Created by sean ogden on 1/18/21.
//

import SwiftUI

struct CoordinateRow: View {
    @EnvironmentObject var modelData: ModelData
    
    var point : LocationTime
    
    var body: some View {
        HStack {
            let pointIndex = modelData.positionCoords.firstIndex(of:point)
            Text("Lon: ")
            TextField("40",text:$modelData.positionCoords[pointIndex!].lon)
            Text("Lat: ")
            TextField("",text:$modelData.positionCoords[pointIndex!].lat)
            Text("Time: ")
            TextField("time",text:$modelData.positionCoords[pointIndex!].timestamp)
        }.padding()
        .overlay(RoundedRectangle(cornerRadius:16)
                    .stroke(Color.blue,lineWidth:4.0))
    }
}

struct CoordinateRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let modelData = ModelData()
        let point = LocationTime()
        modelData.positionCoords.append(point)
        return CoordinateRow(point:point)
            .environmentObject(modelData)
    }
}
