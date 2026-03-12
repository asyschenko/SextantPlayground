//
//  ContentView.swift
//  SextantPlayground
//
//  Created by Alexander Syshchenko on 12.03.2026.
//

import SwiftUI

struct ContentView: View {

    @StateObject var textModel = JSONTextViewModel()
    @State var v = 0.0

    var body: some View {
        VStack {
            TextField("Path", text: $textModel.pathString)
                .font(
                    .system(size: 12)
                    .monospaced()
                )
                .textFieldStyle(.roundedBorder)
            HStack(spacing: 0) {
                VStack {
                    HStack {
                        Text("JSON:")
                        Spacer()
                    }
                    JSONTextView(text: $textModel.leftText)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 3))
                VStack {
                    HStack {
                        Text("Result:")
                        Spacer()
                    }
                    JSONTextView(text: $textModel.rightText, isEditable: false)
                }
                .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 0))
            }
            HStack {
                Text(textModel.errorStr)
                    .foregroundStyle(.red)
                    .font(
                        .system(size: 12)
                        .monospaced()
                    )
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
