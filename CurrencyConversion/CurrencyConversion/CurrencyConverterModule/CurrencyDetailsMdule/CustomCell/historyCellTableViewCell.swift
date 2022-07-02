//
//  historyCellTableViewCell.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 7/2/22.
//

import UIKit

class historyCellTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(history: [String : [String : Double]]){
    
        dateLbl.text = history.first?.key
        currencyLbl.text = "\(history.first?.value.first?.key ?? "") = \(history.first?.value.first?.value ?? 0.0)"
        
    }

}
