//
//  CommonModifier.swift
//  SwiftUI-MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import SwiftUI

struct NavigationPropertiesModifier : ViewModifier {
    func body(content: Content) -> some View {
    content
        .accentColor(.accentColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ScreenEdgesPaddingModifier : ViewModifier {
    func body(content: Content) -> some View {
    content
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .padding(.top, kSafeAreaTop)
        .padding(.bottom, kSafeAreaBottom)
    }
}

 
struct TextTitleModifier : ViewModifier {
    func body(content: Content) -> some View {
    content
            .font(.title2)
            .multilineTextAlignment(.leading)
    }
}

struct TextDescriptionModifier : ViewModifier {
    func body(content: Content) -> some View {
    content
            .font(.caption)
            .multilineTextAlignment(.leading)
    }
}

struct TextPriceModifier : ViewModifier {
    func body(content: Content) -> some View {
    content
            .font(.caption)
            .multilineTextAlignment(.leading)
    }
}

struct InputModifier : ViewModifier {
    func body(content: Content) -> some View {
    content
            .font(.caption)
            .multilineTextAlignment(.leading)
    }
} 


struct NavigationBarHiddenModifier : ViewModifier {
    func body(content: Content) -> some View {
    content
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ThumbnailImageModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 60 , height: 70 )
            .aspectRatio(contentMode: .fit)
            .cornerRadius(5)
    }
}


struct ImageModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 120 , height: 150 )
            .aspectRatio(contentMode: .fit)
            .cornerRadius(5)
    }
}

struct ImageFullScreenModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: kScreen.width * 0.9, height: kScreen.height - (kSafeAreaTop! + kSafeAreaBottom!) - 200)
            .scaledToFit()
            .cornerRadius(10)
    }
}
