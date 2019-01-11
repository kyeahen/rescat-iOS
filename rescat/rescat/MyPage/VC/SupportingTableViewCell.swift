//
//  SupportingTableViewCell.swift
//  rescat
//
//  Created by 김예은 on 07/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class SupportingTableViewCell: UITableViewCell {

    @IBOutlet weak var supportImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var percentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bottomView.layer.addBorder(edge: .top, color: #colorLiteral(red: 0.9175666571, green: 0.9176985621, blue: 0.9175377488, alpha: 1), thickness: 0.5)
    }

}
