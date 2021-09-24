//
//  TabCategory.swift
//  MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import SwiftUI

struct TabCategory: View {
    @Binding var tabSelectedIndex:Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 20) {
                ForEach (KCategories, id: \String.self) {
                    tab in
                    VStack {
                        Button(action: {
                            // action do something
                            if let index = KCategories.firstIndex(of: tab) {
                                tabSelectedIndex = Int(index.description.capitalized)!
                            }
                            
                        }, label: {
                            Text(tab)
                                .modifier(TextDescriptionModifier())
                                 .foregroundColor(tab == KCategories[tabSelectedIndex] ? Color.accentColor : Color.gray)
                        })
                        .buttonStyle(PlainButtonStyle())
                        .padding(.top)
                        Rectangle()
                            .frame(width: widthForTab(tab), height: 2)
                            .foregroundColor(tab == KCategories[tabSelectedIndex] ? Color.accentColor : Color.gray.opacity(0.2))
                    }
                    
                }
            }
        }
    }
    
    func widthForTab(_ string: String) -> CGFloat {
        let width = string.widthOfString(usingFont: .systemFont(ofSize: 16, weight: .bold))
        return width
    }
}

struct TabCategory_Previews: PreviewProvider {
    static var previews: some View {
        TabCategory(tabSelectedIndex: .constant(1))
    }
}
