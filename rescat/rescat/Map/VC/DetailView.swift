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
    
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var birthLabel : UILabel!
    @IBOutlet var title1 : UILabel!
    @IBOutlet var title2 : UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commomInit()
    }
    private func commomInit(){
        let view = Bundle.main.loadNibNamed("DetailView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)

    }
    
}
