//
//  CryptoViewController.swift
//  Crypto_Price_Tracker
//
//  Created by Jordan Denning on 3/30/21.
//

import UIKit

class CryptoViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var cryptoLabel: UIImageView!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var cryptoManager = CryptoManager()
    
    var crypto: String?
    var cryptoImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cryptoManager.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        cryptoLabel.image = cryptoImage
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
    
extension CryptoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cryptoManager.currArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cryptoManager.currArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = cryptoManager.currArray[row]
        cryptoManager.fetchPrice(for: selected, crypto: crypto!)
    }
        
}
    
extension CryptoViewController: cryptoManagerDelegate {
        
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.priceLabel.text = price
            print(currency)
        }
    }
    
    func didFail(error: Error) {
        print(error)
    }
}
    
