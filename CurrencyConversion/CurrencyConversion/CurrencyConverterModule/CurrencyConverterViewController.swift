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
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var symbols: [String: String] = [:]
    var fromTxt = ""
    var toTxt = ""
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
            self.fromTxt = key
            self.fromBtn.setTitle(key, for: .normal)
            let amountValue = Double(self.amountTxt.text ?? "1.0")
            self.amountTxt.resignFirstResponder()
            self.updateConvertCurrency(amountValue: amountValue ?? 1.0)
        }
    }
    
    
    @IBAction func exchangeActionBtn(_ sender: Any) {
        if fromTxt != "" && toTxt != ""{
        let fromCurrency = fromTxt
        fromTxt = toTxt
        fromBtn.setTitle(toTxt, for: .normal)
        toBtn.setTitle(fromCurrency, for: .normal)
        toTxt = fromCurrency

        let amountValue = Double(self.amountTxt.text ?? "1.0")
        amountTxt.resignFirstResponder()
        self.updateConvertCurrency(amountValue: amountValue ?? 1.0)
        }
    }
    
    
    @IBAction func toActionBtn(_ sender: Any) {
        showAlert { key in
            self.toTxt = key
            self.toBtn.setTitle(key, for: .normal)
            let amountValue = Double(self.amountTxt.text ?? "1.0")
            self.amountTxt.resignFirstResponder()
            self.updateConvertCurrency(amountValue: amountValue ?? 1.0)
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
    
    func updateConvertCurrency(amountValue: Double) {
        if fromTxt != "" && toTxt != ""{
            loader.isHidden = false
            ApiService.convertCurrency(from: fromTxt, to: toTxt, amount:  amountValue) { result in
                self.conversionTxt.text = "\(result)"
                self.loader.isHidden = true
            } failure: { error in
                print(error)
            }
        }
    }
}
extension CurrencyConverterViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let amountValue = Double(text.replacingCharacters(in: textRange,
                                                              with: string))
            updateConvertCurrency(amountValue: amountValue ?? 1.0)
            
        }
        return true
    }
    
}
