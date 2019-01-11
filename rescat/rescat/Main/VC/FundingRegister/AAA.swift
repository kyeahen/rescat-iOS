//
//  FundingRegisterVC2.swift
//  rescat
//
//  Created by jigeonho on 04/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit

class AAAA : UIViewController , UITextFieldDelegate {
    
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var phoneTextField : UITextField!
    
    @IBOutlet var bottomView : UIView!
    @IBOutlet var introductionTextView : UITextView!
    @IBOutlet var depositTextField : UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.tag = 0
        nameTextField.delegate = self
        phoneTextField.tag = 1
        phoneTextField.delegate = self
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if ( textField.tag == 1) {
            print("view up")
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    @IBAction func registerVC(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FundingRegisterCompleteVC") as! FundingRegisterCompleteVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
