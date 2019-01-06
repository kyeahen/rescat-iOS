//
//  RadioButton.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
    var alternateButton: Array<RadioButton>?
    
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setImage(UIImage(named: "buttonRadioButton"), for: .normal)
            } else {
                self.setImage(UIImage(named: "buttonRadioButton"), for: .normal)
                self.backgroundColor = #colorLiteral(red: 0.7352672219, green: 0.5879593492, blue: 0.4972323775, alpha: 1)
            }
        }
    }
}
