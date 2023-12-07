//
//  ContentView.swift
//  DesignCodeiOS15
//
//  Created by Alexander Sobolev on 4.5.23..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack(alignment: .bottom) {
             
            HomeView()
           
              
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(Model())
    }
}
