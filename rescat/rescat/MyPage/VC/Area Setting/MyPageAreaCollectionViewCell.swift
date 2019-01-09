//
//  MyPageAreaCollectionViewCell.swift
//  rescat
//
//  Created by 김예은 on 08/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class MyPageAreaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var addHandler : (() -> Void)?
    var delHanler : (() -> Void)?
    
    func configure(tag : Int){
        
        addButton.addTarget(self, action: #selector(addAction(_:)), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(delAction(_:)), for: .touchUpInside)
        
    }
    
    //지역 추가 액션
    @IBAction func addAction(_ sender: UIButton) {
        addHandler!()
    }
    
    //지역 삭제 액션
    @IBAction func delAction(_ sender: UIButton) {
        delHanler!()
    }
    
}
