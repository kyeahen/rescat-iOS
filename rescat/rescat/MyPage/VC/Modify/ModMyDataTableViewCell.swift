//
//  ModMyDataTableViewCell.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class ModMyDataTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var modifyButton: UIButton!
    var modHandler : (() -> Void)?
    
    @IBAction func modAction(_ sender: UIButton) {
        modHandler!()
    }
}
