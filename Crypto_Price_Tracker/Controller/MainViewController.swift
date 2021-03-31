//
//  MainViewController.swift
//  Crypto_Price_Tracker
//
//  Created by Jordan Denning on 3/30/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLogoImage: UIImageView!
    
    var cryptoSelect: String?
    var cryptoImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bitcoinPressed(_ sender: Any) {
        cryptoSelect = "BTC"
        cryptoImage = #imageLiteral(resourceName: "Bitcoin")
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    @IBAction func ethereumPressed(_ sender: Any) {
        cryptoSelect = "ETH"
        cryptoImage = #imageLiteral(resourceName: "Eth")
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destVC = segue.destination as! CryptoViewController
            destVC.crypto = cryptoSelect
            destVC.cryptoImage = cryptoImage
        }
    }
    
}
