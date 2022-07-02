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
    }

    func subScripeObservers(){
        viewModel.historyBehaviour.subscribe { histroy in
            self.histroy = histroy
            self.currencyLbl.text = self.fromCurrency
            self.historyTable.reloadData()
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

