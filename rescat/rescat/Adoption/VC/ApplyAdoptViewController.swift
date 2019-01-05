//
//  ApplyAdoptViewController.swift
//  rescat
//
//  Created by 김예은 on 04/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class ApplyAdoptViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var mainAddressTextField: UITextField!
    @IBOutlet weak var subAddressTextField: UITextField! {
        didSet {
            contentTextView.tintColor = #colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1)
            contentTextView.reloadInputViews()
        }
    }
    
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCustomView()
        
    }
    
    //MARK: 뷰 요소 커스텀 세팅
    func setCustomView() {
        nameTextField.setTextField()
        phoneTextField.setTextField()
        roleTextField.setTextField()
        mainAddressTextField.setTextField()
        subAddressTextField.setTextField()
        contentTextView.setTextView()
        contentTextView.tintColor = #colorLiteral(red: 0.948010385, green: 0.566582799, blue: 0.5670218468, alpha: 1)
    }
    

}



