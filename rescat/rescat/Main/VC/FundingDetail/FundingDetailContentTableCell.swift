//
//  FundingDetailContentTableCell.swift
//  rescat
//
//  Created by jigeonho on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class FundingDetailContentTableCell: UITableViewCell {
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet var perentageView : UIProgressView!
    @IBOutlet weak var contentsLabel: UITextView!
    @IBOutlet weak var remainDateLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var currentAmountLabel: UILabel!
    
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
