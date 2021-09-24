//
//  MVVM_and_Design_PatternApp.swift
//  MVVM-and-Design-Pattern
//
//  Created by Waleerat Gottlieb on 2021-09-23.
//

import SwiftUI
import Firebase

@main
struct MVVM_and_Design_PatternApp: App {
    init() {
       setupFirebaseApp()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
   
    private func setupFirebaseApp() {
        
       guard let plistPath = Bundle.main.path(
        forResource: "GoogleService-Info", ofType: "plist"),
             let options =  FirebaseOptions(contentsOfFile: plistPath)
                      else { return }
        
          if FirebaseApp.app() == nil{
              FirebaseApp.configure(options: options)
          }
    }
}
