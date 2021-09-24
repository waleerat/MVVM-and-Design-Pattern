//
//  TextFieldInputView.swift
//  Sawasdee By WGO
//
//  Created by Waleerat Gottlieb on 2021-08-26.
//

import SwiftUI

enum editor {
    case textinput
    case textarea
    case numberinput
}

// MARK: - TextFieldInputView
struct TextFieldInputView:View {
    @Binding var textInput:String
    @State var textFieldTitle:String?
    @State var textPlaceholder:String
    @State var editorType :editor = editor.textinput
    
    var body: some View {
        if editorType == .textarea {
            VStack(alignment: .leading, spacing: 10) {
                if let text = textFieldTitle {
                    Text(text).modifier(InputModifier())
                }
                ZStack {
                    Color.clear
                        TextEditor(text: $textInput)
                            .padding(5)
                            .modifier(InputModifier())
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .clipped()
                            
                        Text(textInput).opacity(0).padding(.all, 8) // <- This will solve the issue if it is in the same ZStack
                }
            }
            .frame(height: 200)
            .onAppear() {
                UITextView.appearance().backgroundColor = .clear
            }
        } else if editorType == .numberinput {
            
            VStack(alignment: .leading, spacing: 10) {
                if let text = textFieldTitle {
                    Text(text).modifier(InputModifier())
                }
                TextField(textPlaceholder, text: $textInput)
                    .keyboardType(.numberPad)
                    .padding()
                    .modifier(InputModifier())
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .clipped()
            }
       
        } else {
            VStack(alignment: .leading, spacing: 10) {
                if let text = textFieldTitle {
                    Text(text).modifier(InputModifier())
                }
                TextField(textPlaceholder, text: $textInput)
                    .padding()
                    .modifier(InputModifier())
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .clipped()
            }
           
        }
    }
    
}
