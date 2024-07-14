//
//  CoinManager.swift
//  CryptoExchange
//
//  Created by Pavlo Kostenko on 14/07/2024.
//

import SwiftUI

class CoinManager: ObservableObject {
    @Published var rate: Double = 0.0
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "69D3F21F-4C46-4151-BB0A-279463B1B857"
    
    func getCoinRate(currency: String, crypto: String, completion: @escaping (Double) -> Void) {
        let urlString = "\(baseURL)/\(crypto)/\(currency)?apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    completion(0.0)
                    return
                }
                
                if let safeData = data {
                    if let rate = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            completion(rate)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinJson.self, from: data)
            return decodedData.rate
        } catch {
            print(error)
            return nil
        }
    }
}
