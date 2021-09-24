//
//  HomeView.swift
//  SwiftUI-MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import SwiftUI


struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var productVM = ProductVM()
    
    @State var  isShowDetail:Bool = false
    @State var selectedRow: ProductModel?
    @State var tabSelectedIndex = 0
    
   
    var productByCategory: [String : [ProductModel]] {
        .init(
            grouping: productVM.contentRows,
            by: {$0.category}
        )
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(kScreenBackground)
                .ignoresSafeArea()
            // MARK: - Start
            VStack(spacing: 20){
               // Note: - Tab
                TabCategory(tabSelectedIndex: $tabSelectedIndex)
                // Note: - Get Products
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        if let rows = productByCategory[KCategories[tabSelectedIndex]] {
                            ForEach(rows) { row in
                                ProductRow(row: row, isShowDetail: $isShowDetail, selectedRow: $selectedRow)
                            }
                        } else if (KCategories[tabSelectedIndex] == "ALL" || tabSelectedIndex == 0) {
                            ForEach(productVM.contentRows) { row in
                                ProductRow(row: row, isShowDetail: $isShowDetail, selectedRow: $selectedRow)
                            }
                        }
                    }
                }
                Spacer()
            }
            .blur(radius: (isShowDetail)  ? 8.0 : 0, opaque: false)
            .frame(width: kScreen.width * 0.90)
            
            if isShowDetail {
                if let selectedRow = selectedRow {
                    ProductDetail(isShowDetail: $isShowDetail, row: selectedRow)
                }
            }
            // MARK: - End
        }
        .modifier(ScreenEdgesPaddingModifier())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


