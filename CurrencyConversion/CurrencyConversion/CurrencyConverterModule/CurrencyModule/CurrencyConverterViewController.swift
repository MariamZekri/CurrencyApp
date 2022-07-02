//
//  CurrencyConverterViewController.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 6/25/22.
//

import UIKit
import RxSwift
import RxCocoa

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
    var disposeBag = DisposeBag()
    var viewModel = CurrencyConversionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getSymbols()
        subScripeObservers()
        
    }
    
    func subScripeObservers(){
        viewModel.symbolsBehaviour.subscribe { symbols in
            self.symbols = symbols
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
        
        viewModel.convertedResult.subscribe { conversionResult in
            if (conversionResult > 0){
                self.loader.isHidden = true
                self.conversionTxt.text = "\(conversionResult)"
            }
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
        amountTxt.rx.text
            .orEmpty
            .subscribe(
                onNext: { text in
                    if self.fromTxt != "" && self.toTxt != ""{
                        let amountValue = Double(text)
                        self.loader.isHidden = false
                        self.viewModel.updateConvertCurrency(amountValue: amountValue ?? 1.0, fromTxt: self.fromTxt, toTxt: self.toTxt)
                    }
                }).disposed(by: disposeBag)
    }
    
    @IBAction func DetailsActionBtn(_ sender: Any) {
      
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CurrencyDetailsViewController") as? CurrencyDetailsViewController else { return }
        secondViewController.fromCurrency = self.fromTxt
        secondViewController.toCurrency = self.toTxt
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func fromActionBtn(_ sender: Any) {
        showAlert { key in
            self.fromTxt = key
            self.fromBtn.setTitle(key, for: .normal)
            let amountValue = Double(self.amountTxt.text ?? "1.0")
            if self.fromTxt != "" && self.toTxt != ""{
                self.amountTxt.resignFirstResponder()
                self.loader.isHidden = false
                self.viewModel.updateConvertCurrency(amountValue: amountValue ?? 1.0, fromTxt: self.fromTxt, toTxt: self.toTxt)
            }
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
            self.loader.isHidden = false
            self.viewModel.updateConvertCurrency(amountValue: amountValue ?? 1.0, fromTxt: self.fromTxt, toTxt: self.toTxt)
        }
    }
    
    @IBAction func toActionBtn(_ sender: Any) {
        showAlert { key in
            self.toTxt = key
            self.toBtn.setTitle(key, for: .normal)
            let amountValue = Double(self.amountTxt.text ?? "1.0")
            if self.fromTxt != "" && self.toTxt != ""{
                self.amountTxt.resignFirstResponder()
                self.loader.isHidden = false
                self.viewModel.updateConvertCurrency(amountValue: amountValue ?? 1.0, fromTxt: self.fromTxt, toTxt: self.toTxt)
            }
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
