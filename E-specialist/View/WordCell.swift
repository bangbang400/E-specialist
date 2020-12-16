//
//  WordCell.swift
//  E-specialist
//
//  Created by YhamIVan on 2020/12/15.
//

import UIKit

class WordCell: UITableViewCell {
     
    //    単語を表示
    @IBOutlet weak var wordLabel: UILabel!
    //    わかるボタン
    @IBOutlet weak var proveBtn: UIButton!
    //    わからないボタン    
    @IBOutlet weak var noBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //わかるボタンの囲み線
        proveBtn.layer.borderColor = UIColor.gray.cgColor
        proveBtn.layer.borderWidth = 0.5
        proveBtn.layer.cornerRadius = 5.0
        //わからないボタンの囲み線
        noBtn.layer.borderColor = UIColor.gray.cgColor
        noBtn.layer.borderWidth = 0.5
        noBtn.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //    わかるボタンを押下した際のアクション
    @IBAction func proveBtnAct(_ sender: Any) {
    
        proveBtn.backgroundColor = UIColor.red
    }
    
}


