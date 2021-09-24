//
//  ButtonIconAction.swift
//  Sawasdee By WGO
//
//  Created by Waleerat Gottlieb on 2021-08-27.
//

import SwiftUI


struct ButtonTextAction: View {
    
    @Binding var buttonLabel: String
    @Binding var isActive: Bool
    @State var buttonColor:Color = Color(.blue)
    @State var frameWidth: CGFloat = 200 
    
    var action: () -> Void
    var body: some View {
        Button(action: action , label: {
            Text(buttonLabel)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical,10)
                .frame(width: frameWidth)
                .background(isActive ? buttonColor : Color.gray.opacity(0.7))
                .clipShape(Capsule())
        })
    }
}


struct ButtonWithCircleIconAction: View {
    var systemName:String
    
    var action: () -> Void
    var body: some View {
        Button(action: action , label: {
            Image(systemName: systemName)
                .foregroundColor(Color.white)
                .padding()
                .background(Color.accentColor.opacity(0.3))
                .clipShape(Circle())
        })
    }
}

struct ButtonWithIconAction: View {
    var systemName:String
    
    var action: () -> Void
    var body: some View {
        Button(action: action , label: {
            Image(systemName: systemName)
                .font(.system(size: 25))
                .padding(.horizontal,5)
                .foregroundColor(.accentColor) 
        })
    }
}
