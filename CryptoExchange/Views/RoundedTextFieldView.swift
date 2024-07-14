//
//  RoundedTextFieldView.swift
//  CryptoExchange
//
//  Created by Pavlo Kostenko on 14/07/2024.
//

import SwiftUI

struct RoundedTextFieldView: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .frame(width: 280, height: 42)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.black, lineWidth: 2)
            )
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
    }
}
