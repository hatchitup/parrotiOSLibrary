//
//  TextFieldExt.swift
//  HAIP
//
//  Created by Hemant Singh on 09/12/16.
//  Copyright © 2016 Hemant Singh. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func isNotEmpty() -> Bool {
        return self.text != nil && self.text?.characters.count != 0
    }
    func isValidEmail() -> Bool {
        // println("validate calendar: \(testStr)")
        if self.isNotEmpty(){
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text)
        }
        else{
            return false
        }
    }
}
