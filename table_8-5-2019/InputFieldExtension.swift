//
//  InputFieldExtension.swift
//  table_8-5-2019
//
//  Created by Nathaniel Mcdowell on 8/5/19.
//  Copyright © 2019 Nathaniel Mcdowell. All rights reserved.
//

import UIKit

extension UITextField {
    
    override open func resignFirstResponder() -> Bool {
        print("lost focus at \(self.text != "" ? self.text! : "Empty")")
         self.layer.borderWidth = 0
        
        return super.resignFirstResponder()
    }
    
    override open func becomeFirstResponder() -> Bool {
        let hereText = self.text != "" ? "Gained focus at: \(self.text!)" : "New focus at: Blank"
       print(hereText)
        return super.becomeFirstResponder()
    }
}
