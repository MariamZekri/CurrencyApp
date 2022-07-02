//
//  CurrencyDetailsViewController.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 7/2/22.
//

import UIKit
import RxSwift

class CurrencyDetailsViewController: UIViewController {

    
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    
    @IBOutlet weak var currency1: UILabel!
    @IBOutlet weak var currency2: UILabel!
    @IBOutlet weak var currency3: UILabel!
    @IBOutlet weak var currency4: UILabel!
    @IBOutlet weak var currency5: UILabel!
    @IBOutlet weak var currency6: UILabel!
    @IBOutlet weak var currency7: UILabel!
    @IBOutlet weak var currency8: UILabel!
    @IBOutlet weak var currency9: UILabel!
    @IBOutlet weak var currency10: UILabel!
    
    var disposeBag = DisposeBag()
    var viewModel = CurrencyDetailsViewModel()
    var fromCurrency: String = ""
    var toCurrency : String = ""
    var histroy: [String : [String : Double]] = ["" : ["" : 0.0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subScripeObservers()
        // Do any additional setup after loading the view.
        viewModel.getlastThreeDaysCurrency(fromCurrency: fromCurrency, toCurrency: toCurrency)
        viewModel.getTenCurrencies(baseCurrency: fromCurrency)
    }

    func subScripeObservers(){
        viewModel.historyBehaviour.subscribe { histroy in
            self.histroy = histroy
            self.currencyLbl.text = self.fromCurrency
            self.historyTable.reloadData()
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
        
        viewModel.tenCurrenciesBehaviour.subscribe { result in
            if result.count == 10 {
            self.currency1.text = "\(Array(result)[0].key)  \(Array(result)[0].value)"
            self.currency2.text = "\(Array(result)[1].key)  \(Array(result)[1].value)"
            self.currency3.text = "\(Array(result)[2].key)  \(Array(result)[2].value)"
            self.currency4.text = "\(Array(result)[3].key)  \(Array(result)[3].value)"
            self.currency5.text = "\(Array(result)[4].key)  \(Array(result)[4].value)"
            self.currency6.text = "\(Array(result)[5].key)  \(Array(result)[5].value)"
            self.currency7.text = "\(Array(result)[6].key)  \(Array(result)[6].value)"
            self.currency8.text = "\(Array(result)[7].key)  \(Array(result)[7].value)"
            self.currency9.text = "\(Array(result)[8].key)  \(Array(result)[8].value)"
            self.currency10.text = "\(Array(result)[9].key)  \(Array(result)[9].value)"
            }
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)

    }
}

extension CurrencyDetailsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.histroy.count > 1 ? self.histroy.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyArray = Array(self.histroy)[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "historyCellTableViewCell", for: indexPath) as? historyCellTableViewCell {
            cell.setCell(history: [historyArray.key : [historyArray.value.first?.key ?? "" : historyArray.value.first?.value ?? 0.0]] )
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

