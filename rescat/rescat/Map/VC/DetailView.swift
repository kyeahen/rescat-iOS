//
//  DetailView.swift
//  rescat
//
//  Created by jigeonho on 26/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
class DetailView : UIView {
    

    @IBOutlet var modifyButton : UIButton!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var sexLabel : UILabel!
    @IBOutlet var ageLabel : UILabel!
    @IBOutlet var TRNLabel : UILabel!
    @IBOutlet var propertyLabel : UITextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    private func commonInit(){
        let view = Bundle.main.loadNibNamed("DetailView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}

