# CMS with MVVM Design Patern 
###### SwiftUI, Firebase, Kingfisher

### MVVM-and-Design-Pattern Project
MVVM-and-Design-Pattern show both MVVM patern and how to structure files as well as full flow of CMS and fronend for products which you can use is project to start your project. 

 

# MVVM pattern architecture
Model-View-ViewModel (MVVM) is a structural design pattern that separates objects into three distinct groups:
##### 1. Model
The Model represents simple data. It simply holds the data and has nothing to do with any of the business logic. You can simply say it’s a plain structure of data that we are expecting from our API.
##### 2. View
To receive data from ViewModel class we have link our ViewModel property inside the view controller class

#### 3. ViewModel
ViewModel is the main component of this architecture pattern. ViewModel never knows what the view is or what the view does. This makes this architecture more testable and removes complexity from the view. 

# How to install
1. Download project to your Mac
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/MVVM-and-Design-Pattern/github-repo.png" width="50%" height="50%">
3. Setup firebase
```sh
 https://firebase.google.com/docs/ios/setup
```
5. Delete "GoogleService-Info.plist" in App/ and import your own GoogleService-Info.plist
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/MVVM-and-Design-Pattern/googleService-Info.png" width="50%" height="50%">
5. run pod install in Terminal
```sh
 run pod install
```
6. Close project and open again 
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/MVVM-and-Design-Pattern/project-folders-in-finder.png" width="50%" height="50%">

7. ✨Well done, now you will be able to see the CMS screen.

<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/MVVM-and-Design-Pattern/Home-screen.png" width="20%" height="20%"> | <img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/MVVM-and-Design-Pattern/backend-product-list.png" width="20%" height="20%"> |  <img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/MVVM-and-Design-Pattern/product-form.png" width="20%" height="20%">

# Folder Structure
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/MVVM-and-Design-Pattern/folder-structure.png?raw=true" width="20%" height="20%">
<img src="https://github.com/waleerat/GitHub-Photos-Shared/blob/main/MVVM-and-Design-Pattern/folder-structure.png?raw=true" width="20%" height="20%">

# Check these files

#####   Pods for MVVM-and-Design-Pattern
Run `open podfile`, Only check what pods we use in the project.
```sh
 open podfile
```

```sh
  pod 'Firebase'
  pod 'Firebase/Firestore'


  # download the image from url
  pod 'Kingfisher', '~> 6.0'
```

##### MVVM_and_Design_PatternApp.swift
if you want to separate to difference Firebase for development and production so you can use this code otherwise you can just use `FirebaseApp.configure()`
```sh
    private func setupFirebaseApp() {
        
       guard let plistPath = Bundle.main.path(
        forResource: "GoogleService-Info", ofType: "plist"),
             let options =  FirebaseOptions(contentsOfFile: plistPath)
                      else { return }
        
          if FirebaseApp.app() == nil{
              FirebaseApp.configure(options: options)
          }
    }
```
Example for Config 2 difference Firebase.
```sh
     private func setupFirebaseApp() {
        #if DEBUG
            let kGoogleServiceInfoFileName = "DEVELOPMENT-GoogleService-Info"
        #else
            let kGoogleServiceInfoFileName = "GoogleService-Info"
        #endif
        
       guard let plistPath = Bundle.main.path(
        forResource: kGoogleServiceInfoFileName, ofType: "plist"),
             let options =  FirebaseOptions(contentsOfFile: plistPath)
                      else { return }
        
          if FirebaseApp.app() == nil{
              FirebaseApp.configure(options: options)
          }
    }
```



##### Constants.swift
The constants values that I use in the project.

```sh
public let kSafeAreaTop = UIApplication.shared.windows.first?.safeAreaInsets.top
public let kSafeAreaBottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom
public let kScreen = UIScreen.main.bounds
public let kUserDefaults = UserDefaults.standard
public let kScreenBackground: String = "background"

let KCategories = ["ALL","MAN","WOMAN", "KIDS"] 
```

##### FCollectionReference.swift
Collections for firebase 

```sh
enum FCollectionReference: String {
    case ProductGroup = "pia_productGroup"
    case Product = "pia_product"
    case ProductBundle = "pia_productBundle"
    
} 

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
} 
```
How to use : 
```sh
FirebaseReference(.Product).document(objectId).delete() { error in }
```

##### ProductModel.swift  (Model)
```sh

struct ProductModel: Identifiable {
    var id: String
    var name: String
    var imageURL: String
    var category: String
    var description: String
    var price: Double
}
```

##### ProductModel.swift  (View)
Example for View, program will receive data from ViewModel and present to the screen.

```sh
struct ProductFormView: View {
    // MARK: - Variable here
    
    var body: some View {
        
         // MARK: - View here
        
    } 
    
    // MARK: - HELPER FUNCTIONS
    func saveToFirebase(objectId: String){
        // Note: - Save to Firebase 
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
}```sh


```
##### ProductVM.swift (ViewModel)
  All insert/update/delete processes.
```sh
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

```
##### ButtonIconAction.swift
If you have same design buttons in your app it's good to use shared button action view. 
```sh
struct ButtonWithCircleIconAction: View {
    var systemName:String
    
    var action: () -> Void
    var body: some View {
        Button(action: action , label: {
            Image(systemName: systemName)
                .foregroundColor(Color.white)
                .padding()
                .background(Color.accentColor.opacity(0.3))
                .clipShape(Circle())
        })
    }
}
```
When you use 


```sh
ButtonWithCircleIconAction(systemName: "magnifyingglass", action: {
    // Your code here
 })
```

##### CommonModifier.swift
It's useful for style objects. it's similar to CSS for website.

```sh
struct ImageFullScreenModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: kScreen.width * 0.9, height: kScreen.height - (kSafeAreaTop! + kSafeAreaBottom!) - 200)
            .scaledToFit()
            .cornerRadius(10)
    }
}

```

