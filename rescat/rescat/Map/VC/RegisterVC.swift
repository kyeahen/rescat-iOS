//
//  RegisterVC.swift
//  rescat
//
//  Created by jigeonho on 26/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit
class RegisterVC : UIViewController, UITextFieldDelegate{
    @IBOutlet var type1Button : UIButton!
    @IBOutlet var type2Button : UIButton!
    @IBOutlet var representImageView : UIImageView!
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var propertyTextField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        propertyTextField.delegate = self
        type1Button.tag = 0; type1Button.addTarget(self, action: #selector(changeTypeButtonAction(_:)), for: .touchUpInside)
        type2Button.tag = 1; type2Button.addTarget(self, action: #selector(changeTypeButtonAction(_:)), for: .touchUpInside)
//        print(Bundle.main.pa)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("begin")
        textField.resignFirstResponder()
        return false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return")
        textField.becomeFirstResponder()
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @objc func changeTypeButtonAction( _ sender : UIButton!){
        if sender.tag == 0 {
           
            propertyTextField.text = ""; nameTextField.text = "" ; nameTextField.placeholder = "고양이 이름"

        } else {
//            representImageView.image = UIImage(named: String)
            propertyTextField.text = ""; nameTextField.text = "" ; nameTextField.placeholder = "배식소 이름"

        }
    }

}
