//
//  CoordinateList.swift
//  TankerCoPirate
//
//  Created by sean ogden on 1/19/21.
//

import SwiftUI

struct CoordinateList: View {
    @EnvironmentObject var modelData : ModelData
    
    var body: some View {
        VStack{
            Text("Location Log")
                .font(.largeTitle).padding()
            List{
            ForEach(modelData.positionCoords){
                CoordinateRow(point:$0)
            }
            }
            Button(action:{
                modelData.positionCoords.append(LocationTime())
            }){
                Image(systemName: "plus.circle")
                    .imageScale(.large)
                    .scaleEffect(2.0)
                    .padding()
            }
            
            
            Spacer()
        }
        
    }
}

struct CoordinateList_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        modelData.positionCoords.append(LocationTime())
        return CoordinateList()
            .environmentObject(modelData)
    }
}
