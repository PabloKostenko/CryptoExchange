//
//  ContentView.swift
//  CryptoExchange
//
//  Created by Pavlo Kostenko on 14/07/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                TypingLabelWrapper(fullText: "Crypto Exchange")
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .padding(.init(top: 0, leading: 0, bottom: 30, trailing: 0))
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 344, height: 371)
                        .background(Color.white)
                        .cornerRadius(50)
                    VStack {
                        RoundedTextFieldView(text: $viewModel.amount, placeholder: "Enter amount here")
                        DropDownMenuView(viewModel: DropDownMenuViewModel(options: viewModel.cryptoArray.map { MenuOption(name: $0) }, selectedOptionIndex: viewModel.selectedCryptoOptionIndex), selectedOptionIndex: $viewModel.selectedCryptoOptionIndex)
                        Image("Arrow")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .opacity(viewModel.isArrowTapped ? 0.5 : 1.0)
                            .onTapGesture {
                                   withAnimation {
                                       viewModel.isArrowTapped = true
                                   }
                                   viewModel.updateRate()
                                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                       withAnimation {
                                           viewModel.isArrowTapped = false
                                       }
                                   }
                               }
                        
                        RoundedTextFieldView(text: $viewModel.rate, placeholder: "Converted value")
                            .disabled(true)
                        DropDownMenuView(viewModel: DropDownMenuViewModel(options: viewModel.currencyArray.map { MenuOption(name: $0) }, selectedOptionIndex: viewModel.selectedCurrencyOptionIndex), selectedOptionIndex: $viewModel.selectedCurrencyOptionIndex)

                    }
                    
                }
                .padding(.init(top: 0, leading: 0, bottom: 50, trailing: 0))
            }
        }
        .onChange(of: viewModel.amount) { newValue in
            viewModel.updateRate()
        }
        .onChange(of: viewModel.selectedCurrencyOptionIndex) { _ in
            viewModel.updateRate()
        }
        .onChange(of: viewModel.selectedCryptoOptionIndex) { _ in
            viewModel.updateRate()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
