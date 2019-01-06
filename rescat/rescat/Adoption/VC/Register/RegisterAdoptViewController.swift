//
//  RegisterAdoptViewController.swift
//  rescat
//
//  Created by 김예은 on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class RegisterAdoptViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var breedTextField: UITextField!
    
    var dataRecieved: String? {
        willSet {
            breedTextField.text = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn()
        setCollectionView()
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: UnwindSegue (breedVC -> resisterVC)
    @IBAction func unwindToRegister(sender: UIStoryboardSegue) {
        if let breedVC = sender.source as? SearchCatViewController {
            dataRecieved = breedVC.cat
        }
    }

}

//MARK: CollectionView Extension
extension RegisterAdoptViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResisterImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ResisterImageCollectionViewCell
        
        return cell
    }
    
}
