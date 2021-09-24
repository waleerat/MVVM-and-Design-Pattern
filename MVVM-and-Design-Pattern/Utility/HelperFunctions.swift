//
//  HelperFunctions.swift
//  MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-24.
//

import Foundation
import SwiftUI

func verifyUrl (urlString: String?) -> Bool {
    if let urlString = urlString {
        if let _ = NSURL(string: urlString) {
            return true
        }
    }
    return false
}

func getPrice(price: Double) -> String {
    let formattedValue = "Price \(String(format: "%.2f", price)) US"
    return formattedValue
}
