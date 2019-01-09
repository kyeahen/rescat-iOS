//
//  AreaSettingTableViewCell.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class AreaSettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var areaLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
        backView.makeRounded(cornerRadius: 17.5)
    }


}
