//
//  TabFormSelectionView.swift
//  Sawasdee By WGO
//
//  Created by Waleerat Gottlieb on 2021-09-02.
//

import SwiftUI

struct TabFormSelectionView: View {
    
    @Binding var tabSelectedIndex: Int 
    
    var body: some View {
        HStack {
            Spacer()
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), alignment: .center, spacing: 10) {
                ForEach(KCategories, id: \.self) { tab in
                    HStack( spacing: 5) {
                        
                        Button(action: {
                            // action do something
                            if let index = KCategories.firstIndex(of: tab) {
                                tabSelectedIndex = Int(index.description.capitalized)!
                            }
                            
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 11)
                                    .fill(Color.gray.opacity(0.6))
                                    .frame(width: 22, height: 22)
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(tab == KCategories[tabSelectedIndex] ? Color.accentColor : Color.gray)
                                    .frame(width: 17, height: 17)
                            }
                        })
                        Text(tab)
                            .font(.system(size: 16, weight: .bold ))
                        Spacer()
                    }
                } //: ForEach
            } //: LazyVGrid
            Spacer()
        }
        //: HStack
    }
}

struct TabFormSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TabFormSelectionView(tabSelectedIndex: .constant(1))
    }
}
