//
//  DropDownMenuViewModel.swift
//  CryptoExchange
//
//  Created by Pavlo Kostenko on 14/07/2024.
//

import SwiftUI

class DropDownMenuViewModel: ObservableObject {
    @Published var selectedOptionIndex: Int
    @Published var showDropdown: Bool
    let options: [MenuOption]
    
    init(options: [MenuOption], selectedOptionIndex: Int = 0) {
        self.options = options
        self.selectedOptionIndex = selectedOptionIndex
        self.showDropdown = false
    }
    
    func toggleDropdown() {
        withAnimation {
            showDropdown.toggle()
        }
    }
    
    func selectOption(index: Int) {
        withAnimation {
            selectedOptionIndex = index
            showDropdown.toggle()
        }
    }
}
