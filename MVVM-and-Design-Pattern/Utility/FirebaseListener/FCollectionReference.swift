//
//  FCollectionReference.swift
//  LetsMeet
//
//  Created by David Kababyan on 30/06/2020.
//

import Foundation
import Firebase


enum FCollectionReference: String {
    case ProductGroup = "pia_productGroup"
    case Product = "pia_product"
    case ProductBundle = "pia_productBundle"
    
} 

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
