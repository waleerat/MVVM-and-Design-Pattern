//
//  ProductIndexView:.swift
//  SwiftUI-MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import SwiftUI
import Kingfisher

struct ProductIndexView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var productVM = ProductVM()
    
    @State var isShowFormView: Bool = false
    @State var isReload: Bool = false
    @State var groupSelection: ProductModel?
    
    @State var selectionLink:String?
    var categories: [String : [ProductModel]] {
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
            
            VStack(alignment: .trailing, spacing: 20){
                
                HStack {
                    Text("Products")
                        .modifier(TextTitleModifier())
                    Spacer()
                    ButtonWithCircleIconAction(systemName: "plus", action: {
                        isShowFormView = true
                    })
                }
                
                List{
                    // Note: - Row preview
                  
                    ForEach(productVM.contentRows) { row in
                        
                        HStack {
                            if !row.imageURL.isEmpty {
                                KFImage(URL(string: row.imageURL)!)
                                    .resizable()
                                    .modifier(ThumbnailImageModifier())
                            } else {
                                Image(systemName : "doc.richtext")
                                    .resizable()
                                    .modifier(ThumbnailImageModifier())
                            }
                            Text(row.name).modifier(TextDescriptionModifier())
                            
                            Spacer()
                        }
                       .onTapGesture(perform: {
                            // Note: - Open Sheet to update
                            self.isShowFormView.toggle()
                            productVM.selectedRow = row
                        })
                        .frame(width: kScreen.width * 0.8)
                        .listRowBackground(Color.white)
                      
                    }.onDelete(perform: delete)
                    //: END LOOP CONTENT ROWS
                }.listStyle(PlainListStyle())
                Spacer()
            }
            //:VSTACK
            .onChange(of: isReload, perform: { _ in
                if isReload {
                    // Note: - Fetching All data
                    productVM.getRecords()
                    productVM.selectedRow = nil
                    // Note: - Close buttom sheet
                    isReload = false
                }
            })
            .sheet(isPresented: $isShowFormView, content: {
                if isShowFormView {
                    ProductFormView(isReload: $isReload)
                    .environmentObject(productVM)
                }
             })
            .frame(width: kScreen.width * 0.9)
           
            // MARK: - End
        }
        .modifier(ScreenEdgesPaddingModifier())
    }
    
    // MARK: - HELPER FUNCTIONS
    func delete(at offsets: IndexSet) {
        let objectId = productVM.contentRows[offsets.first!].id
        productVM.removeRecord(objectId: objectId) { (isSuccess) in  }
        productVM.contentRows.remove(atOffsets: offsets)
    }
}
 
struct CategoryIndexView_Previews: PreviewProvider {
    static var previews: some View {
        ProductIndexView()
    }
}


 
