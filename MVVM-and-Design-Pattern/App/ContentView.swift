//
//  ContentView.swift
//  MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LandingPage()
        }
        .modifier(NavigationPropertiesModifier()) 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
