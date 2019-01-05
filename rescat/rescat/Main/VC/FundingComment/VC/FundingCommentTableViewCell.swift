//
//  FundingCommentTableViewCell.swift
//  rescat
//
//  Created by jigeonho on 03/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class FundingCommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var caretakerImageView: UIImageView!
    
    @IBOutlet var sendButton : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
