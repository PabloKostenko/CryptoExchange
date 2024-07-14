//
//  ContentViewModel.swift
//  CryptoExchange
//
//  Created by Pavlo Kostenko on 14/07/2024.
//


import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var amount: String = ""
    @Published var rate: String = "0.0"
    @Published var isArrowTapped = false
    @Published var showCurrencyDropdown = false
    @Published var showCryptoDropDown = false
    
    let coinManager = CoinManager()
    let currencyArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","SEK","SGD","UAH", "USD","ZAR"]
    let cryptoArray = ["BTC","ETH","USDT","BNB","USDC","XRP","BUSD","ADA","DOGE","SOL","MATIC","DOT"]
    
    @Published var selectedCurrencyOptionIndex = 0 {
        didSet {
            updateRate()
        }
    }
    
    @Published var selectedCryptoOptionIndex = 0 {
        didSet {
            updateRate()
        }
    }
    
    var selectedCurrency: String {
        currencyArray[selectedCurrencyOptionIndex]
    }
    
    var selectedCrypto: String {
        cryptoArray[selectedCryptoOptionIndex]
    }
    
    func updateRate() {
        coinManager.getCoinRate(currency: selectedCurrency, crypto: selectedCrypto) { rate in
            if let amountValue = Double(self.amount) {
                self.rate = String(format: "%.2f", amountValue * rate)
            } else {
                self.rate = "0.0"
            }
        }
    }
}
