//
//  CommentTableViewCell.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var reportButton: UIButton!
    var reportHandler : ((_ c_id: Int, _ isWriter: Bool) -> Void)?
    var warnHandler : ((_ c_id: Int) -> Void)?
    var isWriter: Bool?
    
    func configure(data : AdoptCommentData){

        reportButton.addTarget(self, action: #selector(reportAction(_:)), for: .touchUpInside)
        reportButton.tag = data.idx
        isWriter = data.isWriter
        
    }
    
    
    @IBAction func reportAction(_ sender: UIButton) {
        reportHandler!(sender.tag, isWriter ?? true)
    }
}
