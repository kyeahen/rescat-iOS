//
//  DetailView3.swift
//  rescat
//
//  Created by jigeonho on 11/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit

class DetailView3 : UIView{
    
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var saleLabel : UILabel!
    @IBOutlet var propertyLabel : UITextView!
    @IBOutlet var modifyButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    private func commonInit(){
        let view = Bundle.main.loadNibNamed("DetailView3", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}

