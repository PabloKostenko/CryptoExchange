//
//  DropDownMenuView.swift
//  CryptoExchange
//
//  Created by Pavlo Kostenko on 14/07/2024.
//

import SwiftUI

struct DropDownMenuView: View {
    @ObservedObject var viewModel: DropDownMenuViewModel
    @Binding var selectedOptionIndex: Int

    var menuWidth: CGFloat = 280
    var buttonHeight: CGFloat = 40
    var maxItemDisplayed: Int = 3
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                // selected item
                Button(action: {
                    viewModel.toggleDropdown()
                }, label: {
                    HStack {
                        Text(viewModel.options[selectedOptionIndex].name)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(viewModel.showDropdown ? -180 : 0))
                    }
                })
                .padding(.horizontal, 20)
                .frame(width: menuWidth, height: buttonHeight, alignment: .leading)
                
                // selection menu
                if viewModel.showDropdown {
                    let scrollViewHeight: CGFloat = viewModel.options.count > maxItemDisplayed ? (buttonHeight * CGFloat(maxItemDisplayed)) : (buttonHeight * CGFloat(viewModel.options.count))
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.options.indices, id: \.self) { index in
                                Button(action: {
                                    viewModel.selectOption(index: index)
                                    selectedOptionIndex = index
                                }, label: {
                                    HStack {
                                        Text(viewModel.options[index].name)
                                        Spacer()
                                        if index == selectedOptionIndex {
                                            Image(systemName: "checkmark.circle.fill")
                                        }
                                    }
                                })
                                .padding(.horizontal, 20)
                                .frame(width: menuWidth, height: buttonHeight, alignment: .leading)
                            }
                        }
                    }
                    .scrollDisabled(viewModel.options.count <= maxItemDisplayed)
                    .frame(height: scrollViewHeight)
                }
            }
            .font(Font.custom("Montserrat-SemiBold", size: 18))
            .foregroundColor(Color.black)
            .background(RoundedRectangle(cornerRadius: 30).fill(Color("DropDownColor")))
        }
        .frame(width: menuWidth, height: buttonHeight, alignment: .top)
        .zIndex(100)
    }
}
