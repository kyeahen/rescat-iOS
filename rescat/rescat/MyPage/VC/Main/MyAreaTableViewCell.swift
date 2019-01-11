//
//  MyAreaTableViewCell.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class MyAreaTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var areaButton: UIButton!
    var regions: [MyPageRegions] = [MyPageRegions]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setCollectionView()
    }
    
    //MARK: 컬렉션 뷰 세팅
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

//MARK: CollectionView Extension
extension MyAreaTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AreaCollectionViewCell.reuseIdentifier, for: indexPath) as! AreaCollectionViewCell
        
        if indexPath.row == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.7470303178, green: 0.5998028517, blue: 0.5045881271, alpha: 1)
        }
        
        let area = regions[indexPath.row].name
        let dong = area.components(separatedBy: " ")
        cell.areaLabel.text = dong[2]
        
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
}

