//
//  ProductModel.swift
//  SwiftUI-MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import Foundation
import SwiftUI


struct ProductModel: Identifiable {
    var id: String
    var name: String
    var imageURL: String
    var category: String
    var description: String
    var price: Double
}
