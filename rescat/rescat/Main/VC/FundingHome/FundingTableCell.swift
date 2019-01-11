//
//  TempTableCell.swift
//  rescat
//
//  Created by jigeonho on 27/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class FundingTableCell : UITableViewCell {

    @IBOutlet var labelImageView : UIImageView!
    @IBOutlet var backView : UIView!
    @IBOutlet var backgroundImageView : UIImageView!
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var contentsLabel : UILabel!
    @IBOutlet var goalLabel : UILabel!
    @IBOutlet var stageView : UIView!
    @IBOutlet var remainLabel : UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
