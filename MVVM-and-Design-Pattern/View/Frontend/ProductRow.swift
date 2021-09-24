//
//  ProductRow.swift
//  MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import SwiftUI
import Kingfisher

struct ProductRow : View {
    @State var row: ProductModel
    @Binding var isShowDetail:Bool
    @Binding var selectedRow: ProductModel?
    var body: some View {
        ZStack(alignment: .bottom) {
            
            
            if !row.imageURL.isEmpty {
                KFImage(URL(string: row.imageURL)!)
                    .resizable()
                    .modifier(ImageFullScreenModifier())
            } else {
                Image(systemName : "doc.richtext")
                    .resizable()
                    .modifier(ImageFullScreenModifier())
            }
            VStack (spacing: 20) {
                HStack{
                    Spacer()
                    ButtonWithCircleIconAction(systemName: "magnifyingglass", action: {
                        selectedRow = row
                        isShowDetail.toggle()
                    })
                }
                Spacer()
                if (!isShowDetail) {
                    VStack(spacing: 20) {
                        Text(row.name).modifier(TextDescriptionModifier())
                        Text(getPrice(price: row.price)).modifier(TextDescriptionModifier())
                    }
                    .padding()
                    .frame(width: kScreen.width * 0.8)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                }
               
                
            }
            .padding()
            .frame(width: kScreen.width * 0.8)
            
        }.frame(height: kScreen.height - (kSafeAreaTop! + kSafeAreaBottom!) - 200)
    }
}
