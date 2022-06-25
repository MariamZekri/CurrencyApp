//
//  CurrencyConverterViewController.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 6/25/22.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var toBtn: UIButton!
    @IBOutlet weak var exchangeBtn: UIButton!
    @IBOutlet weak var amountTxt: UITextField!
    @IBOutlet weak var conversionTxt: UITextField!
    @IBOutlet weak var detailsBtn: UIButton!
    
    var symbols: [String: String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ApiService.getListSymbols { symbols in
            self.symbols = symbols
            
        } failure: {
            error in
            print(error)
        }
    }
    

    @IBAction func fromActionBtn(_ sender: Any) {
        showAlert { key in
            self.fromBtn.setTitle(key, for: .normal)
        }
    }
    
    
    @IBAction func toActionBtn(_ sender: Any) {
        showAlert { key in
            self.toBtn.setTitle(key, for: .normal)
        }

    }
    
    
    func showAlert(completionHandeler: @escaping(String)-> Void){
        let alert = UIAlertController(title: "", message: "Please Select Currency", preferredStyle: .actionSheet)
        
        for key in symbols.keys{
        alert.addAction(UIAlertAction(title: key, style: .default , handler:{ (UIAlertAction)in
    
            completionHandeler(key)
        }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

}
