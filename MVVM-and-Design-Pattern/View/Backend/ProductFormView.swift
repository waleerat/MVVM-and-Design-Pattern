//
//  ProductFormView.swift
//  SwiftUI-MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import SwiftUI
import Kingfisher

struct ProductFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var productVM: ProductVM
    
    @Binding var isReload: Bool
    @State var objectId:String = ""
    @State var name:String = ""
    @State var imageURL:String = ""
    @State var category: String = ""
    @State var description:String = ""
    @State var price:String = "0.00"
    
    @State var isSaved: Bool = false
    @State var tabCategory: Int = 3 
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(kScreenBackground)
                .ignoresSafeArea()
            // MARK: - Start
            VStack(spacing: 20){
                HStack {
                    ButtonWithCircleIconAction(systemName: "arrow.backward", action: {
                        isReload = true
                        self.presentationMode.wrappedValue.dismiss()
                    })
                    
                    Text((productVM.selectedRow == nil ? "Add" : "Update"))
                        .modifier(TextTitleModifier())
                    
                    Spacer()
                }
                
               
                ScrollView(.vertical, showsIndicators: false) {
                    if !imageURL.isEmpty {
                        if verifyUrl(urlString: imageURL) {
                            KFImage(URL(string: imageURL)!)
                                .resizable()
                                .modifier(ImageModifier())
                        } else {
                            Image(systemName : "doc.richtext")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                    } else {
                        Image(systemName : "doc.richtext")
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    
                    TabFormSelectionView(tabSelectedIndex: $tabCategory)
                    
                    TextFieldInputView(textInput: $price, textFieldTitle: "Price", textPlaceholder: "0.00", editorType: editor.textinput)
                    
                    TextFieldInputView(textInput: $name, textFieldTitle: "Product", textPlaceholder: "Product Name", editorType: editor.textinput)
                    TextFieldInputView(textInput: $imageURL, textFieldTitle: "Image URL", textPlaceholder: "http://", editorType: editor.textarea)
                    TextFieldInputView(textInput: $description, textFieldTitle: "Description", textPlaceholder: "", editorType: editor.textarea)
                }
                
                ButtonTextAction(buttonLabel: .constant("Save"), isActive: .constant(!name.isEmpty), action: {
                    saveToFirebase(objectId: objectId)
                }).disabled(name.isEmpty)
              
                Spacer()
            }
            .blur(radius: (isSaved)  ? 8.0 : 0, opaque: false)
            .onChange(of: isSaved, perform: { _ in
                if isSaved {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isReload = true
                        self.presentationMode.wrappedValue.dismiss()
                   }
                }
            })
            .onAppear() {
                if let currentRow = productVM.selectedRow {
                    self.objectId = currentRow.id
                    self.name = currentRow.name
                    self.imageURL = currentRow.imageURL
                    self.category = currentRow.category
                    self.description = currentRow.description
                    self.price = String(currentRow.price)
                    
                    tabCategory = KCategories.firstIndex(of: category) ?? 0
                } else {
                    objectId = UUID().uuidString
                }
            }
            .onTapGesture {
                withAnimation() {
                    hideKeyboard()
                }
              }
            .padding(20)
            // MARK: - End
        }
        .modifier(NavigationBarHiddenModifier())
        
    }
    
    
    // MARK: - HELPER FUNCTIONS
    func saveToFirebase(objectId: String){
        // Note: - Save to Firebase
       print(" >> \(price)")
        let modelData = ProductModel(id: objectId,
                                     name: name,
                                     imageURL: imageURL,
                                     category: KCategories[tabCategory],
                                     description: description,
                                     price: Double(price)! )
        
        productVM.SaveRecord(objectId: objectId, modelData: modelData) { isCompleted in
            isSaved = true
        }
    }

    func resetFields(){
        name = ""
        imageURL = ""
        imageURL = ""
        category = ""
        description = ""
        price = "0.00"
    }
}

