//
//  CryptoManager.swift
//  Crypto_Price_Tracker
//
//  Created by Jordan Denning on 3/30/21.
//

import Foundation

protocol cryptoManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFail(error: Error)
}

struct CryptoManager {
    let byteCoinApi = "https://rest.coinapi.io/v1/exchangerate/"
    let currArray = ["USD", "EUR", "NOK", "JPY"]
    
    var delegate: cryptoManagerDelegate?
    
    func fetchPrice(for currency: String, crypto: String) {
        print(currency)
        let urlString = "\(byteCoinApi)\(crypto)/\(currency)?apikey=7CCDD74A-0656-4233-B0CE-893C885F6421"
        print(urlString)
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    self.delegate?.didFail(error: error!)
                    return
                }
                
                if let workingData = data {
                    if let price = self.parseJSON(workingData) {
                        let priceString = String(format: "%.4f", price)
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ data: Data) -> Double? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CryptoRates.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
        } catch {
            delegate?.didFail(error: error)
            return nil
        }
    }
}
