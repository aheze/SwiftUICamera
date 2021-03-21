//
//  ContentView.swift
//  SwiftUICamera
//
//  Created by Zheng on 3/21/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
        Text("Hello, camera!")
            .padding()
            
         SwiftUICameraView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
