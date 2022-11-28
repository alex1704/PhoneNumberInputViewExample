//
//  ContentView.swift
//  PhoneNumberInputViewExample
//
//  Created by Alex Kostenko on 28.11.2022.
//

import SwiftUI
import PhoneNumberInputView

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.yellow
            PhoneNumberInputView(model: $model) { textView in
                textView.keyboardType = .phonePad
                textView.textColor = .black
                textView.placeholder = "phone"
            }
                .padding([.leading, .trailing])
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.white)
                )
                .overlay(forwardButtonView)
                .padding([.leading, .trailing])
        }
        .animation(.easeIn, value: model.region)
        .animation(.spring(), value: model.isValid)
        .ignoresSafeArea()
    }

    @State private var model = PhoneNumberInputView.Model()
    @State private var showValid = false
}

extension ContentView {
    private var forwardButtonView: some View {
        HStack {
            Spacer()
            if !model.region.isEmpty {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(
                            model.isValid ? .green.opacity(0.2) : .blue.opacity(0.2)
                        )
                        .frame(width: 60)
                    HStack(spacing: 4) {
                        Text(model.regionAsEmojiFlag)
                        if model.isValid {
                            Image(systemName: "arrow.forward.square.fill")
                                .foregroundColor(.green)
                                .transition(.slide.combined(with: .opacity).combined(with: .scale))
                        }
                    }
                }
                .transition(.opacity)
                .onTapGesture {
                    showValid = model.isValid
                }
                .alert(isPresented: $showValid) {
                    Alert(
                        title: Text("Valid number"),
                        message: Text(model.raw)
                    )
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
