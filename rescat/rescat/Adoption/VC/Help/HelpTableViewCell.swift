//
//  HelpTableViewCell.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class HelpTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    
    override func awakeFromNib() {
        bottomView.layer.addBorder(edge: .top, color: #colorLiteral(red: 0.9175666571, green: 0.9176985621, blue: 0.9175377488, alpha: 1), thickness: 0.5)
    }
}
