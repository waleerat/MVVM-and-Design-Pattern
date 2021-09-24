//
//  LandingPage.swift
//  SwiftUI-MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import SwiftUI
struct LandingPage: View {
    
    @AppStorage("tabIndex") private var tabIndex: Int = 0
    
    var body: some View{
        // tabview with navigation bar...
        
        ZStack(alignment: .bottom) {
           // Color(.orange).opacity(0.5)
            // changing view based on index...
            switch (self.tabIndex) {
            case 0 : HomeView()
            case 1 : ProductIndexView()
            default: HomeView()
            }
            
            // Note: - Tab bar
            TabFontendMenuView()
        }
        .edgesIgnoringSafeArea(.all)
        .padding(0)
    }
}



// MARK: - Tab menu View
struct TabFontendMenuView:View {
    @AppStorage("tabIndex") private var tabIndex: Int = 0
   
    var body: some View {
        ZStack(alignment: .top) {
            HStack(alignment: .center, spacing: 0){
                Button(action: {
                      self.tabIndex = 0
                  }) {
                    TabIconMenuView(tabIndex: $tabIndex,
                                 currentIndex: 0,
                                 systemName: "heart.text.square",
                                 title: "Frontend")
                  }
                Spacer()
                Button(action: {
                      self.tabIndex = 1
                  }) {
                    TabIconMenuView(tabIndex: $tabIndex,
                                 currentIndex: 1,
                                 systemName: "heart.text.square",
                                 title: "BackEnd")
                  }
            }
            .frame(height: 40)
            .padding(.horizontal, 20)
            .padding(.top)
            .padding(.bottom, kSafeAreaBottom)
            .background(Color.white)
            .foregroundColor(Color.black)
            .shadow(color: Color.primary.opacity(0.08), radius: 5, x: 0, y: -5)
        }
    }
}

struct TabIconMenuView: View {
    @Binding var tabIndex: Int
    @State var currentIndex:Int
    @State var systemName:String
    @State var title:String
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Image(systemName: systemName)
                .font(.system(size: 25))
                .padding(.horizontal)
                .foregroundColor(currentIndex == self.tabIndex ? Color.accentColor : Color.primary.opacity(0.25))
            Text(title)
                .font(.caption)
                .foregroundColor(currentIndex == self.tabIndex ? Color.accentColor : Color.primary.opacity(0.25))
        }
        .frame(width: kScreen.width / 2)
    }
}
