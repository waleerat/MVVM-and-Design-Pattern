//
//  ProductVM.swift
//  SwiftUI-MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import Foundation
import SwiftUI

class ProductVM: ObservableObject {
    @Published var contentRows: [ProductModel] = []
    @Published var countRow: Int = 0
    @Published var selectedRow: ProductModel?
    
    @State var contentRowsByCategory : [ProductModel] = []
    
    init() {
       getRecords()
    }
    
    func getRecords() {
        self.contentRows = []
        FirebaseReference(.Product).getDocuments { [self] (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                for snapshot in snapshot.documents {
                    let rowData = snapshot.data()
                    let rowStructure = dictionaryToStructrue(rowData)
                    self.contentRows.append(rowStructure)
                }
                
                self.contentRowsByCategory = self.contentRows
            }
        }
         
    }
    
    func getSelectedRow(selectedRow: ProductModel) {
        self.selectedRow = selectedRow
    }
    
    // Note: - Create/Update Record
    func SaveRecord(objectId: String, modelData: ProductModel, completion: @escaping (_ isCompleted: Bool?) -> Void) {
        
        let dictionaryRowData = self.structureToDictionary(modelData)
        FirebaseReference(.Product).document(objectId).setData(dictionaryRowData) {
            error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(false)
                }
                completion(true)
            }
        }
    }
    
    // Note: - Delete Record
    func removeRecord(objectId: String, completion: @escaping (_ isCompleted:Bool?) -> Void) {
        FirebaseReference(.Product).document(objectId).delete() { error in
            if let _ = error {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    
    func structureToDictionary(_ row : ProductModel) -> [String : Any] {
        return NSDictionary(
            objects:
                [row.id,
                 row.name,
                 row.imageURL,
                 row.category,
                 row.description,
                 row.price
                ],
            forKeys: [
                "id" as NSCopying,
                "name" as NSCopying,
                "imageURL" as NSCopying,
                "category" as NSCopying,
                "description" as NSCopying,
                "price" as NSCopying
            ]
        ) as! [String : Any]
    }
    
    func dictionaryToStructrue(_ dictionaryRow : [String : Any]) -> ProductModel {
        return ProductModel(id: dictionaryRow["id"] as? String ?? "",
                            name: dictionaryRow["name"] as? String ?? "",
                            imageURL: dictionaryRow["imageURL"] as? String ?? "",
                            category: dictionaryRow["category"] as? String ?? "",
                            description:dictionaryRow["description"] as? String ?? "",
                            price: dictionaryRow["price"] as? Double ?? 0.00)
    }
     
    
}
