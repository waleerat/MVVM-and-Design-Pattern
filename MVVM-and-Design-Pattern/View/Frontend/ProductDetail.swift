//
//  ProductDetail.swift
//  MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-24.
//

import SwiftUI
import Kingfisher

struct ProductDetail : View {
    @Binding var isShowDetail:Bool
    @State var row : ProductModel
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.clear
                .cornerRadius(10)
            
            VStack {
                ZStack(alignment: .bottom) {
                    if !row.imageURL.isEmpty {
                        KFImage(URL(string: row.imageURL)!)
                            .resizable()
                            .modifier(ImageFullScreenModifier())
                    }
               
                    VStack(spacing:20) {
                        Text(row.name)
                            .modifier(TextTitleModifier())
                        Text(row.description)
                            .modifier(TextDescriptionModifier())
                       
                        Text(getPrice(price: row.price))
                            .modifier(TextDescriptionModifier())
                    }
                    .background(Color.white.opacity(0.6))
                    .padding()
                    .cornerRadius(10)
                }
                Spacer()
            }
            .frame(width: kScreen.width * 0.85, height: kScreen.height * 0.7 )
            .background(Color.red)
            .cornerRadius(10)
        }
        .onTapGesture {
            isShowDetail.toggle()
        }
        .ignoresSafeArea(.all)
    }
}


/*
 Spacer()
 VStack {
     HStack{
         
     }
    Spacer()
 }
 .padding()

 

 Spacer()
 
 */
